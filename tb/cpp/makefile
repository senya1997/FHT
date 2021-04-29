CC = g++

SRC = src/main.cpp
HEADER = obj_dir/Vfht_top.h

OBJ = obj/main.o
ADD_OBJ = obj/verilated.o obj/verilated_vcd_c.o

PATH_INC = C:/msys64/mingw64/share/verilator/include

PATH_VERILATED = C:/msys64/mingw64/share/verilator/include/verilated.cpp
PATH_VERILATED_H = C:/msys64/mingw64/share/verilator/include/verilated.h

PATH_VCD = C:/msys64/mingw64/share/verilator/include/verilated_vcd_c.cpp
PATH_VCD_H = C:/msys64/mingw64/share/verilator/include/verilated_vcd_c.h

PATH_LIB = obj_dir/Vfht_top__ALL.a

all: fht_tb

fht_tb: $(ADD_OBJ) $(PATH_LIB) $(SRC) $(HEADER)
	$(CC) -Wall -o fht_tb -I$(PATH_INC) $(SRC) $(ADD_OBJ) $(PATH_LIB)

obj/verilated.o: $(PATH_VERILATED) $(PATH_VERILATED_H)
	$(CC) -Wall -o obj/verilated.o -I$(PATH_INC) -c $(PATH_VERILATED)
	
obj/verilated_vcd_c.o: $(PATH_VCD) $(PATH_VCD_H)
	$(CC) -Wall -o obj/verilated_vcd_c.o -I$(PATH_INC) -c $(PATH_VCD)

#$(OBJ): $(SRC) $(HEADER) $(PATH_VERILATED_H) $(PATH_VCD_H) 
#	$(CC) -Wall -o $(OBJ) -c $(SRC)
	
clean: 
	rm -rf obj/*.o *.exe