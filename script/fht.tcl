proc disp_error msg {
	puts " "
	post_message -type error $msg
	return -code error
}

set prj		fht.qpf
set prj_rev	fht

if {[is_project_open]} {
	project_close
}
if { ![project_exists $prj] } {
    post_message -type error "Project '$prj' does not exist"
    return -code error
}

project_open $prj
set_current_revision $prj_rev;

load_package flow

# ================================================================================= #
# 											 input parameters: 											#
# ================================================================================= #

# keys: -c (compile and copy .sdo, .vo, .do for modelsim)
#		-cl (remove .txt, .do, .tcl, .mif etc. that generated by tcl, matlab, tb, from repo and other dir)

#----------------------
# A_BIT |  N	| D_BIT |
#----------------------|
#	5	  | 128	|	23   |
# 	6	  | 256	|	24   |
# 	7	  | 512	|	25   |
# 	8	  | 1024	|	26   |
# 	9	  | 2048	|	27   |
# 	10	  | 4096	|	28   |
#----------------------

# ADC bit resolution
	set ADC_BIT 16
# depth of one bank RAM, it is defines number of point transform 'N = 4*2^A_BIT'
	set A_BIT 9
# twiddle coefficient data bit width
	set W_BIT 14
# impulses coefficient data bit width
	set IMP_BIT 16
# number of signal point going on FHT, must be large then 'Nh' and 'N/2' (full RAM FHT - N point)
	set Nx 32
	
# name of define which turn off part of RTL
	set name_def TEST_MIXER
	
# path of element that need to copy/clean
	set path_def			./fht_defines.v
	set path_script			./script
	set path_debug			./debug
	set path_sdo			./simulation/modelsim
	set path_conv_debug		../fht_conv/debug
	set path_modelsim		../modelsim/fht/
	
# ================================================================================= #
# 											 calculate parameters: 										#
# ================================================================================= #

# add expansion bit (for avoid overflow from 'max_negative_num*(-1)' and for use shift operating on division)
	set D_BIT [expr $ADC_BIT + 5]
	#set D_BIT [expr $A_BIT + 18]
	#set D_BIT [expr $A_BIT + 12]
	
	set CONV_BIT [expr $D_BIT + 5]
	
	set W_BIT [expr $W_BIT + 1]
	
# read input keys from cmd
	set flag_compile	[lindex $argv 0]
	set flag_clean		[lindex $argv 1]
	
# calculate defines	
	set MAX_D [expr round(pow(2, $D_BIT - 1))]
	set MAX_W [expr round(pow(2, $W_BIT - 2))]
	set MAX_CONV [expr round(pow(2, $CONV_BIT - 1))]
	set MAX_IMP [expr round(pow(2, $IMP_BIT - 1))]

	set N [expr round(4*pow(2, $A_BIT))] 
	set BANK_SIZE [expr $N/4]
	
	# number of impulse point
		set Nh [expr $N - $Nx]
	# module from +/- max number
		set MAX_ADC_D [expr round(pow(2, $ADC_BIT - 1))]
		
	set WIDTH_RAM	[expr round(log($N)/log(2))]
	set WIDTH_BUF	[expr round(log($Nx)/log(2))]
	
	set DEPTH_ROM	[expr round(pow(2, $A_BIT - 2))]
	
	set LAST_STAGE	[expr round(log($N)/log(2) - 1)] 

puts " "
puts "\tSTART"
puts " "

# ================================================================================= #
# 									generate defines files: 											#
# ================================================================================= #

puts "writing defines..."
set f_def [open $path_def r+]

if {($A_BIT > 3) && ($A_BIT < 11) && ($Nx < $N)} {
	puts $f_def	"`ifndef FHT_DEFINES_H"
	puts $f_def	"`define FHT_DEFINES_H"
	puts $f_def	" "
	puts $f_def "/*****************************************************************************************************************/"
	puts $f_def "/*												auto generated defines (do not modify):												  */"
	puts $f_def "/*****************************************************************************************************************/"
	puts $f_def " "
	puts $f_def "`define N $N"
	puts $f_def "`define Nx $Nx"
	puts $f_def "`define Nh $Nh"
	puts $f_def "`define BANK_SIZE $BANK_SIZE"
	puts $f_def "`define WIDTH_RAM $WIDTH_RAM"
	puts $f_def "`define WIDTH_BUF $WIDTH_BUF"
	puts $f_def "`define DEPTH_ROM $DEPTH_ROM"
	puts $f_def "`define LAST_STAGE $LAST_STAGE"
	
# even/odd of 'LAST_STAGE' defines where output data saved after transform (RAM A or B)	
	if {fmod($LAST_STAGE, 2) == 1} {
		puts $f_def "`define LAST_STAGE_ODD"
	} else {
		puts $f_def "`define LAST_STAGE_EVEN"
	}
	
	puts $f_def " "
} else {
	disp_error "Input parameters is incorrect"
}

if {($D_BIT > 11) && ($D_BIT < 28) &&\
	 ($W_BIT > 11) && ($W_BIT < 21)} {
	puts $f_def "`define ADC_WIDTH $ADC_BIT"
	puts $f_def "`define D_BIT $D_BIT"
	puts $f_def "`define A_BIT $A_BIT"
	puts $f_def "`define W_BIT $W_BIT"
	puts $f_def "`define CONV_BIT $CONV_BIT"
	puts $f_def "`define IMP_BIT $IMP_BIT"
	puts $f_def " "
	puts $f_def "`define MAX_ADC_D $MAX_ADC_D"
	puts $f_def "`define MAX_D $MAX_D"
	puts $f_def "`define MAX_W $MAX_W"
	puts $f_def "`define MAX_CONV $MAX_CONV"
	puts $f_def "`define MAX_IMP $MAX_IMP"
	puts $f_def " "
} else {
	disp_error "Input parameters is incorrect"
}

close $f_def

# ================================================================================= #
# 										compile and copy scripts: 										#
# ================================================================================= #

# check testbench defines for define which turn off part of RTL	
set f_def [open $path_def r]
set flag_def_exist 0

while {[gets $f_def temp_str] >= 0} {
# find define string and ind of first character
# find '//' and check that comment ind of first character is smaller than previously found index
	set ind_def [string first $name_def $temp_str]
	set ind_com [string first // $temp_str]
	
	if {$ind_def != -1} {
		set flag_def_exist 1
	
		if {$ind_com != -1} {
			if {$ind_com > $ind_def} {
				post_message -type warning "$name_def is enabled"
			}
		} else {
			post_message -type warning "$name_def is enabled"
		}
		
		break
	}
}

if {$flag_def_exist == 0} {
	disp_error "'$name_def' define was not found in $path_def"
}

close $f_def

if {[string equal $flag_clean -cl]} {
	puts "clean project...\n"
	
	puts "clean matlab dir"
		file delete -force {*}[glob -nocomplain ./matlab/*.txt]
		file delete -force {*}[glob -nocomplain ../fht_conv/matlab/*.txt]
		
	puts "clean fht dir"
		file delete -force {*}[glob -nocomplain *.mif]
		file delete -force {*}[glob -nocomplain *.ver]
		
		file delete -force {*}[glob -nocomplain $path_debug/wlf*]
		file delete -force {*}[glob -nocomplain $path_debug/vish*]
		file delete -force {*}[glob -nocomplain $path_debug/vsim*]
		file delete -force {*}[glob -nocomplain $path_debug/*.txt]
		file delete -force {*}[glob -nocomplain $path_debug/*.ini]
		file delete -force {*}[glob -nocomplain $path_debug/transcript]
		file delete -force $path_debug/work
		file delete -force $path_debug/lpm_ver
		file delete -force $path_debug/altera_mf_ver
	
	puts "clean conv dir"
		file delete -force {*}[glob -nocomplain $path_conv_debug/wlf*]
		file delete -force {*}[glob -nocomplain $path_conv_debug/vish*]
		file delete -force {*}[glob -nocomplain $path_conv_debug/vsim*]
		file delete -force {*}[glob -nocomplain $path_conv_debug/*.txt]
		file delete -force {*}[glob -nocomplain $path_conv_debug/*.ini]
		file delete -force {*}[glob -nocomplain $path_conv_debug/transcript]
		file delete -force $path_conv_debug/work
		file delete -force $path_conv_debug/lpm_ver
		file delete -force $path_conv_debug/altera_mf_ver
	
	puts "clean modelsim prj dir"
		file delete -force {*}[glob -nocomplain $path_modelsim/*.txt]
		file delete -force {*}[glob -nocomplain $path_modelsim/*.do]
		file delete -force {*}[glob -nocomplain $path_modelsim/*.sdo]
		file delete -force {*}[glob -nocomplain $path_modelsim/*.tcl]
} else {
	puts "generate MIF for ROM and TXT for matlab..."

	for {set j 0} {$j < 2} {incr j} {
		if {$j == 0} {
		# for FPGA
			set f_mif [open sin.mif w]
		# for matlab
			set f_txt [open matlab/sin.txt w]
		} elseif {$j == 1} {
			set f_mif [open cos.mif w]
			set f_txt [open matlab/cos.txt w]
		}
			
		puts $f_mif "WIDTH=$W_BIT;"
		puts $f_mif "DEPTH=$DEPTH_ROM;"
		puts $f_mif " "
		puts $f_mif "ADDRESS_RADIX=UNS;"
		puts $f_mif "DATA_RADIX=DEC;"
		puts $f_mif " "
		puts $f_mif "CONTENT BEGIN"
		
		set pi 3.1415926535
		
		for {set i 0} {$i < $DEPTH_ROM} {incr i} {
			if {$j == 0} {
				set data [expr round(sin(2*$pi*$i/$BANK_SIZE)*pow(2, $W_BIT - 2))]
			} elseif {$j == 1} {
				set data [expr round(cos(2*$pi*$i/$BANK_SIZE)*pow(2, $W_BIT - 2))]
			}
			puts $f_mif "\t$i\t:\t$data;"
			puts $f_txt "$data"
		}
		
		puts $f_mif "END;"
		
		close $f_mif
		close $f_txt
	}
	
	#puts "copy sdo..."
	#	file copy -force {*}[glob $path_sdo/*.sdo] $path_modelsim
	
	puts "copy scripts..."
		file copy -force {*}[glob $path_script/*.do] $path_modelsim
		file copy -force {*}[glob $path_script/*.tcl] $path_modelsim
}

if {[string equal $flag_compile -c]} {
	puts "compiling..."
	execute_flow -compile;
}

project_close

puts " "
puts "\tCOMPLETE"
puts " "