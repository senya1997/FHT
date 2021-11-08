# for open questa from cmd to see waveforms:
#	vsim -voptargs="+acc" -L altera_mf_ver -logfile LOG_FHT.txt fht_tb -do "transcript on" -do "../../fht/tb/wave/top.do" -do "configure wave -timelineunits us"
#	vsim -voptargs="+acc" -logfile LOG_FHT_BUT.txt fht_but_tb -do "transcript on" -do "../../fht/tb/wave/but.do"
#	vsim -voptargs="+acc" -logfile LOG_FHT_CONTROL.txt fht_control_tb -do "transcript on" -do "../../fht/tb/wave/control.do" -do "configure wave -timelineunits us"

#PATH_QUARTUS := D:/Program Files/altera/14.1/quartus
PATH_QUARTUS := C:/altera/14.1/quartus

LIB_LPM	:= lpm_ver
LIB_MF	:= altera_mf_ver

LOG_COMP_RTL	:= LOG_COMP_RTL.txt
LOG_COMP_PKG	:= LOG_COMP_PKG.txt
LOG_COMP_TB		:= LOG_COMP_TB.txt

LOG_FHT_TB			:= LOG_FHT.txt
LOG_FHT_BUT_TB		:= LOG_FHT_BUT.txt
LOG_FHT_CONTROL_TB	:= LOG_FHT_CONTROL.txt

VOPT := -voptargs="+acc"

#===================================================================================================#
#											make:													#
#===================================================================================================#

all: run_fht
	
run_fht: lib comp_fht
	vsim -c $(VOPT) -L $(LIB_MF) -logfile $(LOG_FHT_TB) fht_tb \
	-do 'run -all'

run_fht_but: comp_fht_but
	vsim -c $(VOPT) -logfile $(LOG_FHT_BUT_TB) fht_but_tb \
	-do 'run -all'

run_fht_control: comp_fht_control
	vsim -c $(VOPT) -logfile $(LOG_FHT_CONTROL_TB) fht_control_tb \
	-do 'run -all'

# =========== compile libs: ===========

lib: $(LIB_MF) $(LIB_LPM)

$(LIB_MF):
	vlib $(LIB_MF)
	vmap $(LIB_MF) $(LIB_MF)
	vlog -work $(LIB_MF) "$(PATH_QUARTUS)/eda/sim_lib/altera_mf.v"
	
$(LIB_LPM):
	vlib $(LIB_LPM)
	vmap $(LIB_LPM) $(LIB_LPM)
	vlog -work $(LIB_LPM) "$(PATH_QUARTUS)/eda/sim_lib/220model.v"

# ========= compile sources: =========

comp:
	vlog -logfile $(LOG_COMP_RTL) -incr ../*.v
	vlog -logfile $(LOG_COMP_PKG) ../tb/pkg.sv
	vlog -logfile $(LOG_COMP_TB) -incr +incdir+../ ../tb/*_tb.sv
	
comp_fht:
	vlog -logfile $(LOG_COMP_RTL) -incr ../*.v
	vlog -logfile $(LOG_COMP_PKG) ../tb/pkg.sv
	vlog -logfile $(LOG_COMP_TB) -incr +incdir+../ ../tb/fht_tb.sv

comp_fht_but:
	vlog -logfile $(LOG_COMP_RTL) -incr ../fht_but.v
	vlog -logfile $(LOG_COMP_PKG) ../tb/pkg.sv
	vlog -logfile $(LOG_COMP_TB) -incr +incdir+../ ../tb/fht_but_tb.sv

comp_fht_control:
	vlog -logfile $(LOG_COMP_RTL) -incr ../fht_control.v
	vlog -logfile $(LOG_COMP_TB) -incr +incdir+../ ../tb/fht_control_tb.sv

# ============== clean: ==============

clean:
	rm -rf work
	rm -rf $(LIB_MF)
	rm -rf $(LIB_LPM)
	rm -rf wlf* vish* vsim*
	rm -rf *.txt *.ini transcript
	@echo
	@echo ================ COMPLETE ====================
	@echo
