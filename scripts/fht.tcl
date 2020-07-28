proc disp_warning msg {
	puts " "
	puts "WARNING: $msg"
	puts " "
	post_message -type warning "$msg"
}

proc disp_error msg {
	puts " "
	post_message -type error $msg
	return -code error $msg
}

# 'arg = 0' - write sin, 1 - cos
proc generate_mif {arg W_BIT DEPTH_ROM BANK_SIZE} {
	if {$arg == 0} {
	# for FPGA
		set f_mif [open sin.mif w]
	# for matlab
		set f_txt [open matlab/sin.txt w]
	} elseif {$arg == 1} {
		set f_mif [open cos.mif w]
		set f_txt [open matlab/cos.txt w]
	} else {
		disp_error "Wrong input argument in 'generate_mif' proc"
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
		if {$arg == 0} {
			set data [expr round(sin(2*$pi*$i/$BANK_SIZE)*pow(2, $W_BIT - 2))]
		} elseif {$arg == 1} {
			set data [expr round(cos(2*$pi*$i/$BANK_SIZE)*pow(2, $W_BIT - 2))]
		}
		puts $f_mif "\t$i\t:\t$data;"
		puts $f_txt "$data"
	}
	
	puts $f_mif "END;"
	
	close $f_mif
	close $f_txt
}

set_current_revision fht;

# ================================================================================= #
# 											 input parameters: 											#
# ================================================================================= #

# keys: -c (compile and copy .sdo, .vo for modelsim)

#---------------
# A_BIT |  N	|
#---------------
#	5	  | 128	|
# 	6	  | 256	|
# 	7	  | 512	|
# 	8	  | 1024	|
# 	9	  | 2048	|
#---------------

# ADC data bit width
	set D_BIT 16
# depth of one bank RAM, it is defines number of point transform 'N = 4*2^A_BIT'
	set A_BIT 8
# twiddle coefficient data bit width
	set W_BIT 12

# name of define which turn off part of RTL
	set name_def TEST_MIXER
	
# path of element that need to copy
	set path_script	./scripts
	set path_modelsim ./../modelsim/fht/
	set path_sdo		./simulation/modelsim

set path_def ./fht_defines.v
	
# ================================================================================= #
# 											 calculate parameters: 										#
# ================================================================================= #

# add expansion bit (for avoid overflow from 'max_negative_num*(-1)' and for use shift operating on division)
	set D_BIT [expr $D_BIT + 1]
	set W_BIT [expr $W_BIT + 1]
	
# read input keys from cmd
	set compile [lindex $argv 0]

# calculate defines	
	set MAX_D [expr round(pow(2, $D_BIT - 2))]
	set MAX_W [expr round(pow(2, $W_BIT - 2))]

	set N [expr round(4*pow(2, $A_BIT))] 
	set BANK_SIZE [expr $N/4]

	set DEPTH_ROM			[expr round(pow(2, $A_BIT - 2))]
	set LAST_STAGE			[expr round(log($N)/log(2) - 1)] 

puts " "
puts "\tSTART"
puts " "

# ================================================================================= #
# 									generate defines and MIF files: 									#
# ================================================================================= #

puts "writing defines..."
set f_def [open $path_def r+]

if {($A_BIT > 4) && ($A_BIT < 10)} {
	puts $f_def "/*******************************************/"
	puts $f_def "/* auto generated defines (do not modify): */"
	puts $f_def "/*******************************************/"
	puts $f_def " "
	puts $f_def "`define N $N"
	puts $f_def "`define BANK_SIZE $BANK_SIZE"
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
	disp_error "A_BIT is not valid"
}

if {($D_BIT > 11) && ($D_BIT < 25) &&\
	 ($W_BIT > 11) && ($W_BIT < 21)} {
	puts $f_def "`define D_BIT $D_BIT"
	puts $f_def "`define A_BIT $A_BIT"
	puts $f_def "`define W_BIT $W_BIT"
	puts $f_def " "
	puts $f_def "`define MAX_D $MAX_D"
	puts $f_def "`define MAX_W $MAX_W"
	puts $f_def " "
	puts $f_def "/*******************************************/"
	puts $f_def " "
} else {
	disp_error "Input parameters is not correct"
}

close $f_def

puts "generate MIF for ROM and TXT for matlab..."
	generate_mif 0 $W_BIT $DEPTH_ROM $BANK_SIZE
	generate_mif 1 $W_BIT $DEPTH_ROM $BANK_SIZE

# ================================================================================= #
# 										compile and copy scripts: 										#
# ================================================================================= #
	
if {[string equal $compile -c]} {
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
					disp_warning "$name_def is enabled"
				}
			} else {
				disp_warning "$name_def is enabled"
			}
			
			break
		}
	}
	
	if {$flag_def_exist == 0} {
		disp_error "'$name_def' define was not found in $path_def"
	}
	
	close $f_def
	
	puts "compiling..."
	execute_flow -compile;
	
	puts "copy sdo..."
	file copy -force $path_sdo/fht_v.sdo	$path_modelsim
	file copy -force $path_sdo/fht.vo		$path_modelsim
}

puts "copy scripts..."

file copy -force $path_script/fht_control.do	$path_modelsim
file copy -force $path_script/fht_but_sdf.do	$path_modelsim
file copy -force $path_script/fht.do			$path_modelsim

file copy -force $path_script/lib_setup.tcl	$path_modelsim
file copy -force $path_script/src.tcl			$path_modelsim

puts " "
puts "\tCOMPLETE"
puts " "