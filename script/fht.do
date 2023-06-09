transcript on

quit -sim

#set work_pc [lindex $argv 0]
#if {[string equal $work_pc -w]}

#remove .vo from prj
	set path_vo ../../fht/simulation/modelsim/fht.vo	
	project::addfile 	$path_vo
	project::removefile $path_vo

project::compileall
vlog -novopt ../../fht/tb/fht_tb.sv

#simulate
	#vlog fft_tb.sv
	#vsim -L altera_mf_ver -L cycloneiv_ver -L cycloneive_ver -L altera_prim_ver -c fht_tb -sv_lib signal -novopt
	#vsim -L altera_mf_ver -L altera_mf -L cycloneiv_ver -L cycloneive_ver -L altera_prim_ver -L lpm_ver -c fht_tb -novopt
	vsim -L altera_mf_ver -logfile LOG_FHT.txt fht_tb -novopt
	
do ../../fht/tb/wave/top.do
configure wave -timelineunits us