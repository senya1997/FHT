
#PATH_QUARTUS := D:/Program Files/altera/14.1/quartus
PATH_QUARTUS := C:/altera/14.1/quartus

LIB_LPM	:= lpm_ver
LIB_MF	:= altera_mf_ver

LOG_COMP_RTL	:= LOG_COMP_RTL.txt
LOG_COMP_PKG	:= LOG_COMP_PKG.txt
LOG_COMP_TB		:= LOG_COMP_TB.txt

LOG_FHT_TB := LOG_FHT.txt

VOPT := -voptargs="+acc"

#===================================================================================================#
#											make:													#
#===================================================================================================#

all: run
	
run: lib comp
	vsim -c $(VOPT) -L $(LIB_LPM) -L $(LIB_MF) -logfile $(LOG_FHT_TB) fht_tb \
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
	
# ============== clean: ==============

clean:
	rm -rf work
	rm -rf $(LIB_MF)
	rm -rf $(LIB_LPM)
	rm -rf *.txt *.ini transcript
	@echo
	@echo ================ COMPLETE ====================
	@echo