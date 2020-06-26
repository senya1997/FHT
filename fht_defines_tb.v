`include "fht_defines.v"

// `define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
`define COMPARE_WITH_MATLAB

	/* For apply changing in defines - click 'compile all' in modelsim 2 times */
`define TACT 20
`define HALF_TACT `TACT/2

`define N 1024
`define BANK_SIZE (`N/4) // cause Radix-4 

`define MAX_D 32768
`define MAX_W (2*`HALF_W_MAX)

`define NUM_OF_RPT 10 // number of repeat butterfly test