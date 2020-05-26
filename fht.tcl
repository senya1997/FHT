set_current_revision fht;

set compile 1
set upd_script 1

puts " "
puts "******************   START   *******************"
puts " "

set path_wave		./tb/wave
set path_script	./tb/scripts
set path_modelsim ../modelsim/fht/

if {$compile} {
	puts "compiling..."
	execute_flow -compile;
	
	puts "copy sdo..."
	file copy -force ./simulation/modelsim/fht_v.sdo $path_modelsim
	file copy -force ./simulation/modelsim/fht.vo $path_modelsim
}

if {$upd_script} {
	puts "copy scripts..."
	
#	file copy -force $path_script/fht_control.do $path_modelsim
	file copy -force $path_script/fht_but_sdf.do $path_modelsim
#	file copy -force $path_script/fht.do $path_modelsim
	
	file copy -force $path_script/lib_setup.tcl $path_modelsim
}

puts " "
puts "******************  COMPLETE  ******************"
puts " "