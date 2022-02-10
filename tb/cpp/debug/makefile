
#===================================================================================================#
#									paramteres and paths:											#
#===================================================================================================#

# compiler options:
    # used compiler:
    	GXX := g++
	
    OPT_LVL := -O0
    DBG_LVL := -g3
	
	# compile info '-Wall' or nothing:
    	CMPL_INF := -Wall

# verilator:
	VERILATOR := verilator_bin
	
	# DUT:
    	TOP_MODULE := fht_top
    	 
	TIMESCALE := 1ns/1ns
	
	# required to compile:
		VSRC := verilated.cpp verilated_vcd_c.cpp
	
	#PATH_MF := "C:/intelFPGA_lite/18.1/quartus/eda/fv_lib/verilog"
	#PATH_MF := "D:/Program Files/altera/14.1/quartus/eda/fv_lib/verilog"
	PATH_MF := "C:/altera/14.1/quartus/eda/fv_lib/verilog"
	
	PATH_VINC := C:/msys64/mingw64/share/verilator/include/
	#PATH_VINC := C:/msys64/usr/share/verilator/include/
	
	# auto forming:
	    VH := ../../../obj_dir/V$(TOP_MODULE).h
	    VLIB := ../../../obj_dir/V$(TOP_MODULE)__ALL.a
		
		# for compiler:
	    	VCMPL := $(addprefix $(PATH_VINC), $(VSRC))
	    	
	    VNAME := $(basename $(VSRC))
	    
	    # verilator dependences:
	    	VDEP := $(wildcard $(PATH_VINC)%.cpp $(PATH_VINC)%.h)
		
		VOBJ := $(addprefix ../obj/, $(addsuffix .o, $(basename $(VSRC))))
	
# main files:
    OUT := fht_tb

	SRC := ../src/*.cpp
	HEADER := $(VH) ../inc/*.h

#===================================================================================================#
#											make:													#
#===================================================================================================#

all: $(OUT)

$(OUT): $(VOBJ) $(SRC) $(VLIB) $(HEADER)
	$(GXX) $(CMPL_INF) $(OPT_LVL) $(DBG_LVL) -o $(OUT) -I$(PATH_VINC) $(SRC) $(VOBJ) $(VLIB)

$(VOBJ): $(VCMPL)
	mkdir -p ../obj
	for vsrc in $(VNAME) ; do \
		$(GXX) $(CMPL_INF) $(OPT_LVL) $(DBG_LVL) \
		-o $(addprefix ../obj/, $(addsuffix .o, $$vsrc)) -I$(PATH_VINC) \
		-c $(addprefix $(PATH_VINC), $(addsuffix .cpp, $$vsrc)) ; \
	done
	
clean:
	rm -rf ../obj/*.o *.exe
	rm -rf *.vcd *.wlf ../*.vcd ../*.wlf