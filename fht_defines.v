/*******************************************/
/* auto generated defines (do not modify): */
/*******************************************/
 
`define N 2048
`define BANK_SIZE 512
`define DEPTH_ROM 128
`define LAST_STAGE 10
`define LAST_STAGE_EVEN
 
`define D_BIT 26
`define A_BIT 9
`define W_BIT 13
`define H_BIT 16
 
`define MAX_D 33554432
`define MAX_W 2048
`define MAX_H 32768
 
/*******************************************/
 

 
//`define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
`define COMPARE_WITH_MATLAB
`define USE_2_RAM_FOR_COEF // formula conv: Z(i) = 0.5*(X(i)*(I(i) + I(-i)) + X(-i)*(I(i) - I(-i)))
									// '(I(i) + I(-i))' and '(I(i) - I(-i))' can be calc in advance but it 
									// require 2 RAM N point, or use 1 RAM but requre direct calc coef and
									//	use more resources with 1 tact delay in calc module
									
`ifdef MODEL_TECH
	`define MIF_SIN "../../fht/sin.mif"
	`define MIF_COS "../../fht/cos.mif"
// `define MIF_IMP "../../conv/imp.mif"
`else
	`define MIF_SIN "./sin.mif"
	`define MIF_COS "./cos.mif"
// `define MIF_IMP "./imp.mif"
`endif		

	`define ADC_WIDTH 16
	`define MAX_ADC_D (2**(`ADC_WIDTH - 1))
	
	`define TACT 20
	`define HALF_TACT `TACT/2 

	`define NUM_OF_RPT 20 // number of repeat butterfly test

	`define ERROR_THRESHOLD 0.001
	
`define RAM_BUG // if modelsim issue error 'Unresolved reference to...' try to switch this define