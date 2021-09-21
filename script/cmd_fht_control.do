project open ../modelsim/fht/fht.mpf

project compileall
vlog -novopt ../../fht/tb/fht_control_tb.sv

# simulate
	vsim -novopt fht_control_tb -logfile  LOG_FHT_CONTROL.txt
	run -all
	
quit -sim
project close
quit
