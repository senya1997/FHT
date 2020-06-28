module fht_rom_block #(parameter W_BIT = 12, A_BIT = 6, 
											MIF_SIN = "./matlab/sin.mif", 
											MIF_COS = "./matlab/cos.mif")(
	input iCLK,
	
	input iST_ZERO,
	
	input [A_BIT - 1 : 0] iADDR,
	
	output signed [W_BIT - 1 : 0] oSIN_0,
	output signed [W_BIT - 1 : 0] oCOS_0,
	
	output signed [W_BIT - 1 : 0] oSIN_1,
	output signed [W_BIT - 1 : 0] oCOS_1
);

wire signed [W_BIT - 1 : 0] OUT_SIN;
wire signed [W_BIT - 1 : 0] OUT_COS;

fht_rom #(.W_BIT(W_BIT), .MIF(MIF_SIN)) ROM_SIN(
	.address(iADDR),
	.clock(iCLK),
	.q(OUT_SIN)
);

fht_rom #(.W_BIT(W_BIT), .MIF(MIF_COS)) ROM_COS(
	.address(iADDR),
	.clock(iCLK),
	.q(OUT_COS)
);

// stage after zero:
	// cos(x) = sin(y)
	// cos(y) = -sin(x)
wire [W_BIT - 1 : 0] NEG_SIN = (~OUT_SIN + 1'b1);
	
assign oSIN_0 = OUT_SIN;
assign oCOS_0 = OUT_COS;

assign oSIN_1 = iST_ZERO ? OUT_SIN : OUT_COS;
assign oCOS_1 = iST_ZERO ? OUT_COS : NEG_SIN;

endmodule 