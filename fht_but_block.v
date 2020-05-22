module fht_but_block #(parameter D_BIT = 17, W_BIT = 12, SEC_BIT = 4)(
	input iCLK,
	input iRESET,
	
	input iST_ZERO,
	input iST_LAST,
	input i2ND_PART_SUBSECTOR,
	input [SEC_BIT - 1 : 0] iSECTOR,
	
	input signed [D_BIT - 1 : 0] iBANK_0, 
	input signed [D_BIT - 1 : 0] iBANK_1,
	input signed [D_BIT - 1 : 0] iBANK_2,
	input signed [D_BIT - 1 : 0] iBANK_3,
	
	input signed [W_BIT - 1 : 0] iSIN_0,
	input signed [W_BIT - 1 : 0] iCOS_0,
	
	input signed [W_BIT - 1 : 0] iSIN_1,
	input signed [W_BIT - 1 : 0] iCOS_1,
	
	output signed [D_BIT - 1 : 0] oY_0,
	output signed [D_BIT - 1 : 0] oY_1,
	output signed [D_BIT - 1 : 0] oY_2,
	output signed [D_BIT - 1 : 0] oY_3
);

// this block have 2 butterfly (0 and 1, double butterfly Radix-2)

// on 1st tact reading this block gets 'X2' and 'X3' points that going on multiplier in butterfly
// on 2nd tact this block gets remaining point 'X1' and it going on summator in butterfly

reg signed [D_BIT - 1: 0] mux_buf [0 : 3];

wire signed [D_BIT - 1 : 0] MIX_TO_BUT_0 [0 : 3];
wire signed [D_BIT - 1 : 0] MIX_TO_BUT_1 [0 : 3];

wire signed [D_BIT - 1 : 0] BUT_TO_MIX [0 : 3];

// output bank mixer:
always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET)
		begin
			mux_buf[0] <= 0; mux_buf[1] <= 0; // from '0' butterfly
			mux_buf[2] <= 0; mux_buf[3] <= 0; // from '1' butterfly
		end
	else if(iST_LAST)
		begin
			mux_buf[0] <= BUT_TO_MIX[0];
			mux_buf[1] <= BUT_TO_MIX[1];
			mux_buf[2] <= BUT_TO_MIX[2];
			mux_buf[3] <= BUT_TO_MIX[3];
		end
	else if(i2ND_PART_SUBSECTOR)
		begin
			mux_buf[0] <= BUT_TO_MIX[2];
			mux_buf[1] <= BUT_TO_MIX[0];
			mux_buf[2] <= BUT_TO_MIX[3];
			mux_buf[3] <= BUT_TO_MIX[1];
		end
	else
		begin
			mux_buf[0] <= BUT_TO_MIX[0];
			mux_buf[1] <= BUT_TO_MIX[2];
			mux_buf[2] <= BUT_TO_MIX[1];
			mux_buf[3] <= BUT_TO_MIX[3];
		end
end

// input bank mixers:
fht_in_mix #(.D_BIT(D_BIT), .SEC_BIT(SEC_BIT)) MIX_0(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iST_ZERO(iST_ZERO),
	.iSECTOR(iSECTOR),
	
	.iBANK_0(iBANK_0),
	.iBANK_1(iBANK_1),
	.iBANK_2(iBANK_2),
	.iBANK_3(iBANK_3),
	
	.oY_0(MIX_TO_BUT_0[0]),
	.oY_1(MIX_TO_BUT_0[1]),
	.oY_2(MIX_TO_BUT_0[2])
);

fht_in_mix #(.D_BIT(D_BIT), .SEC_BIT(SEC_BIT)) MIX_1(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iST_ZERO(iST_ZERO),
	.iSECTOR(iSECTOR),
	
	.iBANK_0(iBANK_2),
	.iBANK_1(iBANK_3),
	.iBANK_2(iBANK_0),
	.iBANK_3(iBANK_1),
	
	.oY_0(MIX_TO_BUT_1[0]),
	.oY_1(MIX_TO_BUT_1[1]),
	.oY_2(MIX_TO_BUT_1[2])
);

// butterflyes:
fht_but #(.D_BIT(D_BIT), .W_BIT(W_BIT)) BUT_0(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iX_0(MIX_TO_BUT_0[0]),
	.iX_1(MIX_TO_BUT_0[1]),
	.iX_2(MIX_TO_BUT_0[2]),
	
	.iSIN(iSIN_0),
	.iCOS(iCOS_0),
	
	.oY_0(BUT_TO_MIX[0]),
	.oY_1(BUT_TO_MIX[1])
);

fht_but #(.D_BIT(D_BIT), .W_BIT(W_BIT)) BUT_1(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iX_0(MIX_TO_BUT_1[0]),
	.iX_1(MIX_TO_BUT_1[1]),
	.iX_2(MIX_TO_BUT_1[2]),
	
	.iSIN(iSIN_1),
	.iCOS(iCOS_1),
	
	.oY_0(BUT_TO_MIX[2]),
	.oY_1(BUT_TO_MIX[3])
);

assign oY_0 = mux_buf[0];
assign oY_1 = mux_buf[1];
assign oY_2 = mux_buf[2];
assign oY_3 = mux_buf[3];

endmodule 