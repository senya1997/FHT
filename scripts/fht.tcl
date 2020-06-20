####################################################
#																	#
#	keys: -c -upd												#
#																	#
#	-c:	compile and copy .sdo, .vo	 for modelsim	#
#	-upd: copy .do, .tcl for modelsim					#
#																	#
####################################################

proc disp_warning msg {
	puts "\tWARNING: $msg"
	puts " "
	post_message -type warning "$msg"
}

set_current_revision fht;

# ========================= input parameters: ========================= #

	# name of define and file that include him which turn off part of RTL
		set path_def ./fht_defines_tb.v
		set name_def TEST_MIXER

	# read input keys from cmd
		set compile [lindex $argv 0]
		set upd_script [lindex $argv 1]

	# path of element that need to copy
		set path_script	./scripts
		set path_modelsim ./../modelsim/fht/
		set path_sdo		./simulation/modelsim
	
puts " "
puts "******************   START   *******************"
puts " "

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

if {[string equal $upd_script -upd]} {
	puts "copy scripts..."
	
	file copy -force $path_script/fht_control.do	$path_modelsim
	file copy -force $path_script/fht_but_sdf.do	$path_modelsim
	file copy -force $path_script/fht.do			$path_modelsim
	
	file copy -force $path_script/lib_setup.tcl	$path_modelsim
	file copy -force $path_script/src.tcl			$path_modelsim
}

puts " "
puts "******************  COMPLETE  ******************"
puts " "