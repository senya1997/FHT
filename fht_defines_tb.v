	/*  TEXT defines must be on fixed place (row and column)  */
	/* permitted only comment correspondig define by 'Ctrl+Q' */
	/*     because this check in tcl when compile project     */
// `define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
`define COMPARE_WITH_MATLAB

	/* For apply changing in defines - click 'compile all' in modelsim 2 times */
`define TACT 20
`define HALF_TACT `TACT/2

`define N 1024
`define BANK_SIZE (`N/4) // cause Radix-4 

`define D_SIZE 17 // data - signed 
`define W_SIZE 12 // rotation coefficients - signed 

`define MAX_D 32768 // or 32768 ?
`define MAX_W 1024

`define NUM_OF_RPT 10 // number of repeat butterfly test