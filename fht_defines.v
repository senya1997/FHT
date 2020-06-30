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

// for rtl:
	`define D_BIT 17 // data bit size with bit expansion for avoid overflow from 'max_negative_num*(-1)'
	`define W_BIT 16 // twiddle coefficient bit analog data with bit expansion for use shift operating on division 
	`define A_BIT 8 // depth of memory one bank RAM

	`define SEC_BIT 9

// for tb:
	`define TACT 20
	`define HALF_TACT `TACT/2

	`define N 1024
	`define BANK_SIZE (`N/4) // cause Radix-4 

	`define MAX_D 32768
	`define MAX_W 16384

	`define NUM_OF_RPT 20 // number of repeat butterfly test