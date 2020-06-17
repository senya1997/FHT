	/*  TEXT defines must be on fixed place (row and column)  */
	/* permitted only comment correspondig define by 'Ctrl+Q' */
	/*     because this check in tcl when compile project     */
`define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
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

`ifdef TEST_MIXER
	`define NUM
`else
// choose test signal:
	// `define SIN
	// `define AUDIO // from '.wav' file 
	// `define BIAS // integer const 
	`define NUM // default test signal, numbers 0..N (function 'y = x', x > 0)
`endif

`ifdef SIN
	`undef AUDIO
	`undef BIAS
	`undef NUM
	
	// SIN spec:
		`define AMP_1 10000 // integer [`D_BIT - 2 : 0]
		`define AMP_2 5000
		`define AMP_NOISE 15000
		
		`define FREQ_D 44100
		`define FREQ_1 9000 // integer Hz
		`define FREQ_2 4500
		
		`define PHASE_1 0 // float Rad
		`define PHASE_2 0.645
		
		`define BIAS 0 // integer ~ MAX_AMP/2 if use unsigned (by default - decimal format)
`elsif AUDIO
	`undef BIAS
	`undef NUM
	
	`define AUDIO_PATH "../../fht/matlab/impulses/g.wav"
`elsif BIAS
	`undef NUM
	
	`define CONST 100
`endif