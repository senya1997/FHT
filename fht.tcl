set_current_revision fht;

set compile 0
set upd_script 1

puts " "
puts "******************   START   *******************"
puts " "

set path_wave		./tb/wave
set path_script	./tb/scripts
set path_modelsim ../modelsim/fht/

set test_mixer_str_num 189

if {$compile} {
# check testbench defines for define TEST_MIXER which turn off part of RTL	
	set f_def [open ./fht_defines_tb.v r]
	seek $f_def $test_mixer_str_num
	set temp_str [gets $f_def] 
	set bool [string first // $temp_str]
		
		if {$bool != 0} {
			puts "\tWARNING: TEST_MIXER is enabled"
			puts " "
			
			post_message -type warning "TEST_MIXER is enabled"
		}
	close $f_def
	
	puts "compiling..."
	execute_flow -compile;
	
	puts "copy sdo..."
	file copy -force ./simulation/modelsim/fht_v.sdo $path_modelsim
	file copy -force ./simulation/modelsim/fht.vo $path_modelsim
}

if {$upd_script} {
	puts "copy scripts..."
	
	file copy -force $path_script/fht_control.do $path_modelsim
	file copy -force $path_script/fht_but_sdf.do $path_modelsim
	file copy -force $path_script/fht.do $path_modelsim
	
	file copy -force $path_script/lib_setup.tcl $path_modelsim
}

puts " "
puts "******************  COMPLETE  ******************"
puts " "