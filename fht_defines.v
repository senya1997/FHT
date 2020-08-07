/*******************************************/
/* auto generated defines (do not modify): */
/*******************************************/
 
`define N 4096
`define BANK_SIZE 1024
`define DEPTH_ROM 256
`define LAST_STAGE 11
`define LAST_STAGE_ODD
 
`define D_BIT 17
`define A_BIT 10
`define W_BIT 16
 
`define MAX_D 32768
`define MAX_W 16384
 
/*******************************************/
 

 
 
 
 
 
 
 
 //`define TEST_MIXER // check only 'top' + 'control', RAM data (0..N) "avoid" butterfly and multipliers
`define COMPARE_WITH_MATLAB

`ifdef MODEL_TECH
	`define MIF_SIN "../../fht/sin.mif"
	`define MIF_COS "../../fht/cos.mif"
`else
	`define MIF_SIN "./sin.mif"
	`define MIF_COS "./cos.mif"
`endif		

	`define TACT 20
	`define HALF_TACT `TACT/2 

	`define NUM_OF_RPT 20 // number of repeat butterfly test
	
`define RAM_BUG // if modelsim issue error 'Unresolved reference to...' try to switch this define