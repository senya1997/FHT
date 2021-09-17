transcript on

quit -sim

# remove .vo from prj cause get error "need lib for sim with sdf"
	set path_vo ../../fht/simulation/modelsim/fht.vo
	project::addfile 	$path_vo
	project::removefile $path_vo

project::compileall

# for upd package in current tb (egg. 'fli::*')
	vlog -novopt ../../fht/tb/fht_control_tb.sv

vsim -novopt fht_control_tb

do ../../fht/tb/wave/control.do
configure wave -timelineunits us