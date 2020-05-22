transcript on

quit -sim

set path_vo ../../fht/simulation/modelsim/fht.vo

if {![file exist $path_vo]} { project::addfile $path_vo }

project::compileall

vsim -novopt fht_but_tb\
 -L altera_mf_ver -L altera_prim_ver -L cycloneiv_ver -L cycloneive_ver\
 -sdftyp /fht_but_tb/BUT=../../modelsim/fht/fht_v.sdo

configure wave -timelineunits us