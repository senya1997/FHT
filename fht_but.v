module fht_but #(parameter D_BIT = 17, W_BIT = 12, W_HALF = 11'sd512)(
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

reg signed [D_BIT - 1 : 0] mul_cos_buf;
reg signed [D_BIT - 1 : 0] mul_sin_buf;

reg signed [D_BIT - 1 : 0] sum_buf;
reg signed [D_BIT - 1 : 0] sub_buf;

wire signed [D_BIT + W_BIT - 1 : 0] EXT_MUL_COS = iX_1 * iCOS + W_HALF;
wire signed [D_BIT + W_BIT - 1 : 0] EXT_MUL_SIN = iX_2 * iSIN + W_HALF;

//wire signed [D_BIT - 1 : 0] MUX_SUM = iSEL ? (iX_1) : (mul_cos_buf + mul_sin_buf); // for '0' stage
//wire signed [D_BIT - 1 : 0] MUX_SUB = iSEL ? (iX_1) : (mul_cos_buf - mul_sin_buf);

//wire signed [D_BIT : 0] EXT_SUM = iX_0 + MUX_SUM + 2'sd1;
//wire signed [D_BIT : 0] EXT_SUB = iX_0 - MUX_SUB + 2'sd1;

wire signed [D_BIT : 0] EXT_SUM = iX_0 + mul_cos_buf + mul_sin_buf + 2'sd1;
wire signed [D_BIT : 0] EXT_SUB = iX_0 - mul_cos_buf - mul_sin_buf + 2'sd1;

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET)
		begin
			mul_cos_buf <= 0;
			mul_sin_buf <= 0;
		end
	else
		begin
			mul_cos_buf <= EXT_MUL_COS[D_BIT + W_BIT - 3 : W_BIT - 2];
			mul_sin_buf <= EXT_MUL_SIN[D_BIT + W_BIT - 3 : W_BIT - 2];
		end
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET)
		begin
			sum_buf <= 0;
			sub_buf <= 0;
		end
	else
		begin
			sum_buf <= EXT_SUM[D_BIT : 1];
			sub_buf <= EXT_SUB[D_BIT : 1];
		end
end

assign oY_0 = sum_buf;
assign oY_1 = sub_buf;

endmodule 