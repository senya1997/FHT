module fht_rom_block #(parameter W_BIT = 12, A_BIT = 10, 
											MIF_SIN = "./matlab/sin.mif", 
											MIF_COS = "./matlab/cos.mif")(
	input iCLK,
	input iRESET,
	
	input [A_BIT - 1 : 0] iADDR,
	
	output signed [W_BIT - 1 : 0] oSIN_0,
	output signed [W_BIT - 1 : 0] oCOS_0,
	
	output signed [W_BIT - 1 : 0] oSIN_1,
	output signed [W_BIT - 1 : 0] oCOS_1
);

wire signed [W_BIT - 1 : 0] OUT_SIN;
wire signed [W_BIT - 1 : 0] OUT_COS;

fht_rom #(.MIF(MIF_SIN)) ROM_SIN(
	.address(iADDR),
	.clock(iCLK),
	.q(OUT_SIN)
);

fht_rom #(.MIF(MIF_COS)) ROM_COS(
	.address(iADDR),
	.clock(iCLK),
	.q(OUT_COS)
);

// cos(x) = sin(y)
// cos(y) = -sin(x)

assign oSIN_0 = OUT_SIN;
assign oCOS_0 = OUT_COS;

assign oSIN_1 = OUT_COS;
assign oCOS_1 = {~OUT_SIN[W_BIT - 1], OUT_SIN[W_BIT - 2 : 0]};

endmodule 