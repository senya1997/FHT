CC = g++

SRC = src/main.cpp
HEADER = obj_dir/Vfht_top.h

OBJ = obj/main.o 
ALL_OBJ = obj/verilated.o obj/verilated_vcd_c.o $(OBJ)

PATH_INC = C:/msys64/mingw64/share/verilator/include

PATH_VERILATED = C:/msys64/mingw64/share/verilator/include/verilated.cpp
PATH_VERILATED_H = C:/msys64/mingw64/share/verilator/include/verilated.h

PATH_VCD = C:/msys64/mingw64/share/verilator/include/verilated_vcd_c.cpp
PATH_VCD_H = C:/msys64/mingw64/share/verilator/include/verilated_vcd_c.h

PATH_LIB = obj_dir/Vfht_top__ALL.a

all: fht_tb

fht_tb: $(ALL_OBJ) $(PATH_LIB)
	$(CC) -o fht_tb -I$(PATH_INC) $(ALL_OBJ) $(PATH_LIB)

obj/verilated.o obj/verilated_vcd_c.o: $(PATH_VERILATED) $(PATH_VCD) $(PATH_VERILATED_H) $(PATH_VCD_H)
	$(CC) -o obj/verilated_vcd_c.o -I$(PATH_INC) -c $(PATH_VCD)
	$(CC) -o obj/verilated.o -I$(PATH_INC) -c $(PATH_VERILATED)

$(OBJ): $(SRC) $(HEADER) $(PATH_VERILATED_H) $(PATH_VCD_H) 
	$(CC) -o $(OBJ) -c $(SRC)
	
clean: 
	rm -rf obj/*.o *.exe