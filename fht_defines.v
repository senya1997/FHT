`ifdef MODEL_TECH
	`define MIF_SIN "D:/SS/fpga/fht/matlab/sin.mif"
	`define MIF_COS "D:/SS/fpga/fht/matlab/cos.mif"
`else
	`define MIF_SIN "./matlab/sin.mif"
	`define MIF_COS "./matlab/cos.mif"
`endif	
	
`define D_BIT 17 // data bit size with bit expansion for avoid overflow from 'max_negative_num*(-1)'
`define W_BIT 12 // twiddle coefficient bit analog data with bit expansion for use shift operating on division 
`define A_BIT 8 // depth of memory one bank RAM

`define SEC_BIT 9