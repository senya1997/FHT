module fht_but_block #(parameter D_BIT = 17, A_BIT = 8, W_BIT = 12)(
	input iCLK,
	input iRESET,
	
	input iST_ZERO,
	input iST_LAST,
	input i2ND_PART_SUBSEC,
	//input iNEW_STAGE,
	//input iRDY,
	input [A_BIT - 1 : 0] iSECTOR,
	
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

reg signed [W_BIT - 1 : 0] sin [0 : 1];
reg signed [W_BIT - 1 : 0] cos [0 : 1];

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET)
		begin
			sin[0] <= 0; sin[1] <= 0;
			cos[0] <= 0; cos[1] <= 0;
		end
	else
		begin
			sin[0] <= iSIN_0; sin[1] <= iSIN_1;
			cos[0] <= iCOS_0; cos[1] <= iCOS_1;
		end
end

// this block have 2 butterfly (0 and 1, double butterfly Radix-2)

// on 1st tact reading this block gets 'X2' and 'X3' points that going on multiplier in butterfly
// on 2nd tact this block gets remaining point 'X1' and it going on summator in butterfly

reg signed [D_BIT - 1 : 0] mux_buf [0 : 3];

//reg [5 : 0] sh_bit;
//reg [3 : 0] flag_max_data;

wire signed [D_BIT - 1 : 0] MIX_TO_BUT_0 [0 : 2];
wire signed [D_BIT - 1 : 0] MIX_TO_BUT_1 [0 : 2];

wire signed [D_BIT - 1 : 0] BUT_TO_MIX [0 : 3];

wire signed [D_BIT - 1 : 0] DATA_0 = iBANK_0;
wire signed [D_BIT - 1 : 0] DATA_1 = iBANK_1;
wire signed [D_BIT - 1 : 0] DATA_2 = iBANK_2;
wire signed [D_BIT - 1 : 0] DATA_3 = iBANK_3;

/*wire signed [D_BIT - 1 : 0] DATA_0 = iBANK_0 << sh_bit;
wire signed [D_BIT - 1 : 0] DATA_1 = iBANK_1 << sh_bit;
wire signed [D_BIT - 1 : 0] DATA_2 = iBANK_2 << sh_bit;
wire signed [D_BIT - 1 : 0] DATA_3 = iBANK_3 << sh_bit;

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) flag_max_data <= 4'd0;
	
	else if((iBANK_0[D_BIT - 1 : D_BIT - 2] == 2'b01) | (iBANK_0[D_BIT - 1 : D_BIT - 2] == 2'b10)) flag_max_data[0] <= 1'b1;
	else if((iBANK_1[D_BIT - 1 : D_BIT - 2] == 2'b01) | (iBANK_1[D_BIT - 1 : D_BIT - 2] == 2'b10)) flag_max_data[1] <= 1'b1;
	else if((iBANK_2[D_BIT - 1 : D_BIT - 2] == 2'b01) | (iBANK_2[D_BIT - 1 : D_BIT - 2] == 2'b10)) flag_max_data[2] <= 1'b1;
	else if((iBANK_3[D_BIT - 1 : D_BIT - 2] == 2'b01) | (iBANK_3[D_BIT - 1 : D_BIT - 2] == 2'b10)) flag_max_data[3] <= 1'b1;
	
	else if(iNEW_STAGE | iRDY) flag_max_data <= 4'd0;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) sh_bit <= 1'b0;
	else if(~(|flag_max_data) & iNEW_STAGE) sh_bit <= 1'b1;
	else if(iNEW_STAGE | iRDY) sh_bit <= 1'b0;
end*/

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
	else if(i2ND_PART_SUBSEC)
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
fht_in_mix #(.D_BIT(D_BIT), .A_BIT(A_BIT)) MIX_0(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iST_ZERO(iST_ZERO),
	.iSECTOR(iSECTOR),
	
	.iBANK_0(DATA_0),
	.iBANK_1(DATA_1),
	.iBANK_2(DATA_2),
	.iBANK_3(DATA_3),
	
	.oY_0(MIX_TO_BUT_0[0]),
	.oY_1(MIX_TO_BUT_0[1]),
	.oY_2(MIX_TO_BUT_0[2])
);

fht_in_mix #(.D_BIT(D_BIT), .A_BIT(A_BIT)) MIX_1(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iST_ZERO(iST_ZERO),
	.iSECTOR(iSECTOR),
	
	.iBANK_0(DATA_2),
	.iBANK_1(DATA_3),
	.iBANK_2(DATA_0),
	.iBANK_3(DATA_1),
	
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
	
	.iSIN(sin[0]),
	.iCOS(cos[0]),
	
	.oY_0(BUT_TO_MIX[0]),
	.oY_1(BUT_TO_MIX[1])
);

fht_but #(.D_BIT(D_BIT), .W_BIT(W_BIT)) BUT_1(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iX_0(MIX_TO_BUT_1[0]),
	.iX_1(MIX_TO_BUT_1[1]),
	.iX_2(MIX_TO_BUT_1[2]),
	
	.iSIN(sin[1]),
	.iCOS(cos[1]),
	
	.oY_0(BUT_TO_MIX[2]),
	.oY_1(BUT_TO_MIX[3])
);

assign oY_0 = mux_buf[0];
assign oY_1 = mux_buf[1];
assign oY_2 = mux_buf[2];
assign oY_3 = mux_buf[3];

endmodule 