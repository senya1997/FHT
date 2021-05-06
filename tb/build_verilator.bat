@echo off

REM set PATH_MF="C:/intelFPGA_lite/18.1/quartus/eda/fv_lib/verilog"
set PATH_MF="D:/Program Files/altera/14.1/quartus/eda/fv_lib/verilog"

set PATH_VINC=C:/msys64/mingw64/share/verilator/include/

set TIMESCALE=1ns/1ns

set TOP_MODULE=fht_top

cd..
	rm -rf obj_dir
	verilator_bin -I%PATH_MF% --timescale-override %TIMESCALE% --trace --hierarchical --build -cc %TOP_MODULE%.v
	echo.
pause
cd obj_dir
	make -f V%TOP_MODULE%.mk
	echo.
pause
exit