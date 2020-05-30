`define MIF_SIN "./matlab/sin.mif"
`define MIF_COS "./matlab/cos.mif"

`define D_BIT 17 // data bit size with bit expansion for avoid overflow from 'max_negative_num*(-1)'
`define W_BIT 12 // twiddle coefficient bit analog data with bit expansion for use shift operating on division 
`define A_BIT 8 // depth of memory one bank RAM

`define SEC_BIT 9