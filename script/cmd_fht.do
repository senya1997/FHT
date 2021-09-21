project open ../modelsim/fht/fht.mpf

project compileall
vlog -novopt ../../fht/tb/fht_tb.sv

# simulate
	vsim -L altera_mf_ver -logfile LOG_FHT.txt fht_tb -novopt
	run -all
	
quit -sim
project close
quit