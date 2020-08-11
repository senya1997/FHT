`include "fht_defines.v"

module fht_but #(parameter D_BIT = 17, W_BIT = 12)(
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

reg signed [D_BIT + W_BIT - 1 : 0] sum_mul;

reg signed [D_BIT - 1 : 0] sum_buf;
reg signed [D_BIT - 1 : 0] sub_buf;
	
`ifdef TEST_MIXER
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
	wire signed [D_BIT + W_BIT : 0] EXT_X0 = {{(W_BIT + `ADC_WIDTH - D_BIT + 1){iX_0[D_BIT - 1]}}, iX_0, {(D_BIT - `ADC_WIDTH){1'b0}}};

	wire signed [D_BIT + W_BIT : 0] EXT_SUM_MUL = iX_1 * iCOS + iX_2 * iSIN; // 16 bit after point
	
	wire signed [D_BIT + W_BIT + 1 : 0] EXT_SUM = EXT_X0 + sum_mul;
	wire signed [D_BIT + W_BIT + 1 : 0] EXT_SUB = EXT_X0 - sum_mul;
	
	wire POS_LHALF_SUM = (~EXT_SUM[D_BIT + W_BIT] & EXT_SUM[W_BIT - 1]); // '+' & '>= 0.5'
	wire NEG_LHALF_SUM = ( EXT_SUM[D_BIT + W_BIT] & EXT_SUM[W_BIT - 1 : 0] > {1'b1, {(W_BIT - 1){1'b0}}}); // '-' & '> 0.5'

	wire POS_LHALF_SUB = (~EXT_SUB[D_BIT + W_BIT] & EXT_SUB[W_BIT - 1]); // '+' & '>= 0.5'
	wire NEG_LHALF_SUB = ( EXT_SUB[D_BIT + W_BIT] & EXT_SUB[W_BIT - 1 : 0] > {1'b1, {(W_BIT - 1){1'b0}}}); // '-' & '> 0.5'
	
	wire signed [D_BIT - 1 : 0] ROUND_SUM = (POS_LHALF_SUM | NEG_LHALF_SUM) ? (EXT_SUM[D_BIT + W_BIT - 1 : W_BIT] + 1'b1) : 
																										EXT_SUM[D_BIT + W_BIT - 1 : W_BIT];
	wire signed [D_BIT - 1 : 0] ROUND_SUB = (POS_LHALF_SUB | NEG_LHALF_SUB) ? (EXT_SUB[D_BIT + W_BIT - 1 : W_BIT] + 1'b1) : 
																										EXT_SUB[D_BIT + W_BIT - 1 : W_BIT];
	
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
				sum_buf <= ROUND_SUM;
				sub_buf <= ROUND_SUB;
			end
	end
`endif

assign oY_0 = sum_buf;
assign oY_1 = sub_buf;

endmodule 