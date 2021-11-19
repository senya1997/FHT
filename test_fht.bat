quartus_sh -t script/src.tcl
quartus_sh -t script/fht.tcl -- -cl
quartus_sh -t script/fht.tcl -- --

matlab -nosplash -nodesktop -r "run('matlab/fht.m'); quit;"