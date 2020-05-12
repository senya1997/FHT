	/*  TEXT defines must be on fixed place (row and column)  */
	/* permitted only comment correspondig define by 'Ctrl+Q' */
	/*     because this check in tcl when compile project     */
// `define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) avoid butterfly and multipliers
`define TEST_FFT // default

	/* For apply changing in defines - click 'compile all' in modelsim 2 times */
`define TACT 20
`define HALF_TACT `TACT/2

`ifdef TEST_MIXER
	`undef TEST_FFT
`endif