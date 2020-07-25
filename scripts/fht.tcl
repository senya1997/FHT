# keys: -c (compile and copy .sdo, .vo	 for modelsim)

proc disp_warning msg {
	puts " "
	puts "WARNING: $msg"
	puts " "
	post_message -type warning "$msg"
}

proc disp_error msg {
	puts " "
	post_message -type error $msg
	puts " "
	return -code error $msg
}

set_current_revision fht;

# ========================= input parameters: ========================= #

# data bit size with bit expansion for avoid overflow from 'max_negative_num*(-1)'
	set D_BIT 17
# depth of memory one bank RAM
	set A_BIT 8
# twiddle coefficient bit analog data with bit expansion for use shift operating on division
	set W_BIT 16
	
set MAX_D [expr int(pow(2, $D_BIT - 2))]
set MAX_W [expr int(pow(2, $W_BIT - 2))]

set N [expr int(4*pow(2, $A_BIT))] 
set BANK_SIZE [expr $N/4]

set DEPTH_NUM_STAGE	[expr log($A_BIT)/log(2)]
set DEPTH_ROM			[expr int(pow(2, $A_BIT - 2))]
set LAST_STAGE			[expr int(log($N)/log(2) - 1)] 
	
set path_def ./fht_defines.v

	# name of define which turn off part of RTL
		set name_def TEST_MIXER

	# read input keys from cmd
		set compile [lindex $argv 0]

	# path of element that need to copy
		set path_script	./scripts
		set path_modelsim ./../modelsim/fht/
		set path_sdo		./simulation/modelsim
	
puts " "
puts "\tSTART"
puts " "

puts "writing defines..."

set f_def [open $path_def r+]

if {[expr round($DEPTH_NUM_STAGE) - $DEPTH_NUM_STAGE] == 0} {
	set DEPTH_NUM_STAGE [expr int($DEPTH_NUM_STAGE)]
	
	puts $f_def "/*******************************************/"
	puts $f_def "/* auto generated defines (do not modify): */"
	puts $f_def "/*******************************************/"
	puts $f_def " "
	puts $f_def "`define N $N"
	puts $f_def "`define BANK_SIZE $BANK_SIZE"
	puts $f_def "`define DEPTH_NUM_STAGE $DEPTH_NUM_STAGE"
	puts $f_def "`define DEPTH_ROM $DEPTH_ROM"
	puts $f_def "`define LAST_STAGE $LAST_STAGE"
	puts $f_def " "
} else {
	disp_error "Point number must be positive and divisible on 4 or DEPTH_NUM_STAGE is not integer"
}

if {([expr round($A_BIT) - $A_BIT] == 0) && ($D_BIT > 0) && ($W_BIT > 0)} {
	set A_BIT [expr int($A_BIT)]
	
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
	disp_error "A_BIT is not integer or D_BIT, W_BIT is not positive"
}

close $f_def

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
		disp_warning "'$name_def' define was not found in $path_def"
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