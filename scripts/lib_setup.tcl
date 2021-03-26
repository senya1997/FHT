set path_to_quartus "D:/Program Files/altera/14.1/quartus"

vlib lpm_ver
vlib altera_mf_ver
vlib altera_prim_ver
vlib sgate_ver
vlib cycloneiv_ver
vlib cycloneive_ver

vmap lpm_ver			lpm_ver
vmap altera_mf_ver	altera_mf_ver
vmap sgate_ver			sgate_ver
vmap cycloneiv_ver	cycloneiv_ver
vmap cycloneive_ver	cycloneive_ver
vmap altera_prim_ver	altera_prim_ver

vlog -work altera_mf_ver	$path_to_quartus/eda/sim_lib/altera_mf.v
vlog -work lpm_ver			$path_to_quartus/eda/sim_lib/220model.v
vlog -work sgate_ver			$path_to_quartus/eda/sim_lib/sgate.v
vlog -work cycloneiv_ver	$path_to_quartus/eda/sim_lib/cycloneiv_atoms.v
vlog -work cycloneive_ver	$path_to_quartus/eda/sim_lib/cycloneive_atoms.v
vlog -work altera_prim_ver	$path_to_quartus/eda/sim_lib/altera_primitives.v
