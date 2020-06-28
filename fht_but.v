`include "fht_defines_tb.v"

module fht_but #(parameter D_BIT = 17, W_BIT = 12, HALF_W_MAX = 11'sd512)(
	input iCLK,
	input iRESET,
	
//	input iSEL,
	
	input signed [D_BIT - 1 : 0] iX_0,
	input signed [D_BIT - 1 : 0] iX_1,
	input signed [D_BIT - 1 : 0] iX_2,
	
	input signed [W_BIT - 1 : 0] iSIN,
	input signed [W_BIT - 1 : 0] iCOS,
	
	output signed [D_BIT - 1 : 0] oY_0,
	output signed [D_BIT - 1 : 0] oY_1
);

//wire signed [D_BIT - 1 : 0] MUX_SUM = iSEL ? (iX_1) : (mul_cos_buf + mul_sin_buf); // for '0' stage
//wire signed [D_BIT - 1 : 0] MUX_SUB = iSEL ? (iX_1) : (mul_cos_buf - mul_sin_buf);

`ifdef TEST_MIXER
	reg signed [D_BIT - 1 : 0] sum_buf;
	reg signed [D_BIT - 1 : 0] sub_buf;

	reg signed [D_BIT - 1 : 0] sum_mul;

// avoid multiply and summ with saving all delayes:
	wire signed [D_BIT - 1 : 0] EXT_SUM_MUL = iX_1;
	
	wire signed [D_BIT - 1 : 0] EXT_SUM = iX_0;
	wire signed [D_BIT - 1 : 0] EXT_SUB = sum_mul;

// avoid divide for normalize output signals:
	always@(posedge iCLK or negedge iRESET)begin
		if(!iRESET) sum_mul <= 0;
		else sum_mul <= EXT_SUM_MUL;
	end

	always@(posedge iCLK or negedge iRESET)begin
		if(!iRESET)
			begin
				sum_buf <= 0;
				sub_buf <= 0;
			end
		else
			begin
				sum_buf <= EXT_SUM;
				sub_buf <= EXT_SUB;
			end
	end
`else
	wire signed [D_BIT + W_BIT : 0] EXT_SUM_MUL = iX_1 * iCOS + iX_2 * iSIN;
	wire signed [D_BIT + W_BIT : 0] ROUND_SUM_MUL;
	
	wire signed [D_BIT : 0] EXT_SUM = iX_0 + ROUND_SUM_MUL[D_BIT + W_BIT - 3 : W_BIT - 2];
	wire signed [D_BIT : 0] EXT_SUB = iX_0 - ROUND_SUM_MUL[D_BIT + W_BIT - 3 : W_BIT - 2];
	
	wire signed [D_BIT : 0] ROUND_SUM;
	wire signed [D_BIT : 0] ROUND_SUB;

	fht_sum #(.D_BIT(D_BIT), .W_BIT(W_BIT)) SUM_MUL_ROUND(
		.aclr(iRESET),
		.cin(EXT_SUM_MUL[D_BIT + W_BIT - 3]),
		.clock(iCLK),
		.dataa(EXT_SUM_MUL),
		.datab(EXT_SUM_MUL[D_BIT + W_BIT - 3] ? {{(D_BIT + 2){1'b1}}, ~HALF_W_MAX} : 
															 {{(D_BIT + 2){1'b0}}, HALF_W_MAX}),
		.result(ROUND_SUM_MUL)
	);

	fht_sum #(.D_BIT(D_BIT), .W_BIT(0)) SUM_ROUND(
		.aclr(iRESET),
		.cin(EXT_SUM[D_BIT]),
		.clock(iCLK),
		.dataa(EXT_SUM),
		.datab(EXT_SUM[D_BIT] ? {(D_BIT + 1){1'b1}} : {(D_BIT + 1){1'b0}}),
		.result(ROUND_SUM)
	);

	fht_sum #(.D_BIT(D_BIT), .W_BIT(0)) SUB_ROUND(
		.aclr(iRESET),
		.cin(EXT_SUB[D_BIT]),
		.clock(iCLK),
		.dataa(EXT_SUB),
		.datab(EXT_SUB[D_BIT] ? {(D_BIT + 1){1'b1}} : {(D_BIT + 1){1'b0}}),
		.result(ROUND_SUB)
	);
`endif

assign oY_0 = ROUND_SUM[D_BIT : 1];
assign oY_1 = ROUND_SUB[D_BIT : 1];

endmodule 