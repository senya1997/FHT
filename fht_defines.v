/*******************************************/
/* auto generated defines (do not modify): */
/*******************************************/
 
`define N 1024
`define BANK_SIZE 256
`define DEPTH_NUM_STAGE 3
`define LAST_STAGE 9
 
`define D_BIT 17
`define A_BIT 8
`define W_BIT 16
 
`define MAX_D 32768
`define MAX_W 16384
 
/*******************************************/
 
 
// `define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
`define COMPARE_WITH_MATLAB

`ifdef MODEL_TECH
//	`define MIF_SIN "D:/SS/fpga/fht/matlab/sin.mif"
//	`define MIF_COS "D:/SS/fpga/fht/matlab/cos.mif"

	`define MIF_SIN "D:/work/fht/matlab/sin.mif"
	`define MIF_COS "D:/work/fht/matlab/cos.mif"
	
//	`define MIF_SIN "./../fht/matlab/sin.mif"
//	`define MIF_COS "./../fht/matlab/cos.mif"
`else
	`define MIF_SIN "./matlab/sin.mif"
	`define MIF_COS "./matlab/cos.mif"
`endif		

	`define TACT 20
	`define HALF_TACT `TACT/2 

	`define NUM_OF_RPT 20 // number of repeat butterfly test