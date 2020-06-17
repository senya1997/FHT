transcript on

quit -sim

set work_pc 1

#remove .vo from prj
	set path_vo ../../fht/simulation/modelsim/fht.vo	
	project::addfile 	$path_vo
	project::removefile $path_vo

project::compileall
	
#compile .c to .dll
	file copy -force ../../fht/tb/scripts/signal.c ../../modelsim/fht
	if {![file exist signal.dll]} { file delete -force signal.dll }
	
	if {$work_pc} { exec C:/mingw64/bin/gcc -shared -o signal.dll signal.c
	} else { exec "D:/Program Files/mingw-w64/x86_64-8.1.0-posix-seh-rt_v6-rev0/mingw64/bin/gcc" -shared -o signal.dll signal.c }
		
#simulate	
	#vlog fft_tb.sv
	vsim -L altera_mf_ver -L cycloneiv_ver -L cycloneive_ver -L altera_prim_ver -c fht_tb -sv_lib signal -novopt
	
do ../../fht/tb/wave/top.do
configure wave -timelineunits us