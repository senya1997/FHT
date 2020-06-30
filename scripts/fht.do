transcript on

quit -sim

#set work_pc [lindex $argv 0]
#if {[string equal $work_pc -w]}

#remove .vo from prj
	set path_vo ../../fht/simulation/modelsim/fht.vo	
	project::addfile 	$path_vo
	project::removefile $path_vo

project::compileall

#simulate
	#vlog fft_tb.sv
	vsim -L altera_mf_ver -L cycloneiv_ver -L cycloneive_ver -L altera_prim_ver -c fht_tb -sv_lib signal -novopt
	
do ../../fht/tb/wave/top.do
configure wave -timelineunits us