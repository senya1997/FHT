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

# ============ run test in cmd mode: ===========	

run_fht: lib comp_fht
	vsim -c $(VOPT) -L $(LIB_MF) -logfile $(LOG_FHT_TB) fht_tb \
	-do 'run -all' \
	-do 'quit'

run_but: comp_but
	vsim -c $(VOPT) -logfile $(LOG_FHT_BUT_TB) fht_but_tb \
	-do 'run -all' \
	-do 'quit'

run_control: comp_control
	vsim -c $(VOPT) -logfile $(LOG_FHT_CONTROL_TB) fht_control_tb \
	-do 'run -all' \
	-do 'quit'

# ============ run gui questa test: ===========
	
run_gui_fht: lib comp_fht
	vsim $(VOPT) -L $(LIB_MF) -logfile $(LOG_FHT_TB) fht_tb \
	-do '../tb/wave/top.do' \
	-do 'configure wave -timelineunits us' \
	-do 'transcript on'

run_gui_but: comp_but
	vsim $(VOPT) -logfile $(LOG_FHT_BUT_TB) fht_but_tb \
	-do '../tb/wave/but.do' \
	-do 'configure wave -timelineunits us' \
	-do 'transcript on'

run_gui_control: comp_control
	vsim $(VOPT) -logfile $(LOG_FHT_CONTROL_TB) fht_control_tb \
	-do '../tb/wave/control.do' \
	-do 'configure wave -timelineunits us' \
	-do 'transcript on'

# ================ compile libs: ===============

lib: $(LIB_MF) $(LIB_LPM)

$(LIB_MF):
	vlib $(LIB_MF)
	vmap $(LIB_MF) $(LIB_MF)
	vlog -work $(LIB_MF) "$(PATH_QUARTUS)/eda/sim_lib/altera_mf.v"
	
$(LIB_LPM):
	vlib $(LIB_LPM)
	vmap $(LIB_LPM) $(LIB_LPM)
	vlog -work $(LIB_LPM) "$(PATH_QUARTUS)/eda/sim_lib/220model.v"

# ============== compile sources: ==============

comp:
	vlog -logfile $(LOG_COMP_RTL) -incr ../*.v
	vlog -logfile $(LOG_COMP_PKG) ../tb/pkg.sv
	vlog -logfile $(LOG_COMP_TB) -incr +incdir+../ ../tb/*_tb.sv
	
comp_fht:
	vlog -logfile $(LOG_COMP_RTL) -incr ../*.v
	vlog -logfile $(LOG_COMP_PKG) ../tb/pkg.sv
	vlog -logfile $(LOG_COMP_TB) -incr +incdir+../ ../tb/fht_tb.sv

comp_but:
	vlog -logfile $(LOG_COMP_RTL) -incr ../fht_but.v
	vlog -logfile $(LOG_COMP_PKG) ../tb/pkg.sv
	vlog -logfile $(LOG_COMP_TB) -incr +incdir+../ ../tb/fht_but_tb.sv

comp_control:
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
