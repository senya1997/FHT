`include "fht_defines.v"

module fht_top #(parameter D_BIT = `D_BIT, A_BIT = `A_BIT, W_BIT = `W_BIT, 
									MIF_SIN = `MIF_SIN, MIF_COS = `MIF_COS)(
	input iCLK,
	input iRESET,
	
	input iSTART, // after load point in RAM(A) required issue strobe on 'iSTART'
	
	input [3 : 0] iWE, // 'WE' is signal of 'bank choice'
	
	input signed [D_BIT - 1 : 0] iDATA_0,
	input signed [D_BIT - 1 : 0] iDATA_1,
	input signed [D_BIT - 1 : 0] iDATA_2,
	input signed [D_BIT - 1 : 0] iDATA_3,
	
	input [A_BIT - 1 : 0] iADDR_WR_0,
	input [A_BIT - 1 : 0] iADDR_WR_1,
	input [A_BIT - 1 : 0] iADDR_WR_2,
	input [A_BIT - 1 : 0] iADDR_WR_3,
	
	input [A_BIT - 1 : 0] iADDR_RD_0,
	input [A_BIT - 1 : 0] iADDR_RD_1,
	input [A_BIT - 1 : 0] iADDR_RD_2,
	input [A_BIT - 1 : 0] iADDR_RD_3,
	
	output signed [D_BIT - 1 : 0] oDATA_0,
	output signed [D_BIT - 1 : 0] oDATA_1,
	output signed [D_BIT - 1 : 0] oDATA_2,
	output signed [D_BIT - 1 : 0] oDATA_3,
	
	output oRDY
);

wire SOURCE_DATA;
wire SOURCE_CONT;

wire RDY;

wire signed [D_BIT - 1 : 0] DATA_RAM_A [0 : 3]; // RAM(A) gives input and issue output points
wire signed [D_BIT - 1 : 0] DATA_BUT [0 : 3];

wire [A_BIT - 1 : 0] ADDR_RD_CTRL [0 : 3];
wire [A_BIT - 1 : 0] ADDR_WR_CTRL [0 : 3];	

wire [A_BIT - 1 : 0] ADDR_RD [0 : 3];
wire [A_BIT - 1 : 0] ADDR_WR [0 : 3];

// syntax: DATA_"FROM"_"TO"
	wire signed [D_BIT - 1 : 0] DATA_RAM_A_BUT [0 : 3];
	wire signed [D_BIT - 1 : 0] DATA_RAM_B_BUT [0 : 3];
	wire signed [D_BIT - 1 : 0] DATA_BUT_RAM [0 : 3];

assign DATA_BUT[0] =		SOURCE_DATA ? DATA_RAM_B_BUT[0] : DATA_RAM_A_BUT[0];
assign DATA_BUT[1] =		SOURCE_DATA ? DATA_RAM_B_BUT[1] : DATA_RAM_A_BUT[1];
assign DATA_BUT[2] =		SOURCE_DATA ? DATA_RAM_B_BUT[2] : DATA_RAM_A_BUT[2];
assign DATA_BUT[3] =		SOURCE_DATA ? DATA_RAM_B_BUT[3] : DATA_RAM_A_BUT[3];

assign DATA_RAM_A[0] =	SOURCE_CONT ? iDATA_0 : DATA_BUT_RAM[0];
assign DATA_RAM_A[1] =	SOURCE_CONT ? iDATA_1 : DATA_BUT_RAM[1];
assign DATA_RAM_A[2] =	SOURCE_CONT ? iDATA_2 : DATA_BUT_RAM[2];
assign DATA_RAM_A[3] =	SOURCE_CONT ? iDATA_3 : DATA_BUT_RAM[3];

assign ADDR_WR[0] = 		SOURCE_CONT ? iADDR_WR_0 : ADDR_WR_CTRL[0];
assign ADDR_WR[1] = 		SOURCE_CONT ? iADDR_WR_1 : ADDR_WR_CTRL[1];
assign ADDR_WR[2] = 		SOURCE_CONT ? iADDR_WR_2 : ADDR_WR_CTRL[2];
assign ADDR_WR[3] = 		SOURCE_CONT ? iADDR_WR_3 : ADDR_WR_CTRL[3];

wire WE_A, WE_B;
wire [3 : 0] WE;
	assign WE[0] = SOURCE_CONT ? iWE[0] : WE_A;
	assign WE[1] = SOURCE_CONT ? iWE[1] : WE_A;
	assign WE[2] = SOURCE_CONT ? iWE[2] : WE_A;
	assign WE[3] = SOURCE_CONT ? iWE[3] : WE_A;
	
assign ADDR_RD[0] = SOURCE_CONT ? iADDR_RD_0 : ADDR_RD_CTRL[0];
assign ADDR_RD[1] = SOURCE_CONT ? iADDR_RD_1 : ADDR_RD_CTRL[1];
assign ADDR_RD[2] = SOURCE_CONT ? iADDR_RD_2 : ADDR_RD_CTRL[2];
assign ADDR_RD[3] = SOURCE_CONT ? iADDR_RD_3 : ADDR_RD_CTRL[3];

// ======================= control: =========================== //

wire ST_ZERO, ST_LAST;
wire SEC_PART_SUBSEC;

wire [A_BIT - 1 : 0] SECTOR;
wire [A_BIT - 3 : 0] ADDR_COEF;

fht_control #(.A_BIT(A_BIT)) CONTROL(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iSTART(iSTART),
	
	.oST_ZERO(ST_ZERO),
	.oST_LAST(ST_LAST), 
	.o2ND_PART_SUBSEC(SEC_PART_SUBSEC),
	.oSECTOR(SECTOR), 
	
	.oADDR_RD_0(ADDR_RD_CTRL[0]),
	.oADDR_RD_1(ADDR_RD_CTRL[1]),
	.oADDR_RD_2(ADDR_RD_CTRL[2]),
	.oADDR_RD_3(ADDR_RD_CTRL[3]),

	.oADDR_WR_0(ADDR_WR_CTRL[0]),
	.oADDR_WR_1(ADDR_WR_CTRL[1]),
	.oADDR_WR_2(ADDR_WR_CTRL[2]),
	.oADDR_WR_3(ADDR_WR_CTRL[3]),
	
	.oADDR_COEF(ADDR_COEF),
	
	.oWE_A(WE_A),
	.oWE_B(WE_B),
	
	.oSOURCE_DATA(SOURCE_DATA),
	.oSOURCE_CONT(SOURCE_CONT),
	
	.oRDY(RDY)
);

// ==================== butterfly block: ====================== //

wire signed [W_BIT - 1 : 0] SIN_0, COS_0;
wire signed [W_BIT - 1 : 0] SIN_1, COS_1;

fht_but_block #(.A_BIT(A_BIT), .D_BIT(D_BIT), .W_BIT(W_BIT)) BUT_BLOCK(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iST_ZERO(ST_ZERO),
	.iST_LAST(ST_LAST),
	.i2ND_PART_SUBSEC(SEC_PART_SUBSEC),
	.iSECTOR(SECTOR),
	
	.iBANK_0(DATA_BUT[0]), 
	.iBANK_1(DATA_BUT[1]),
	.iBANK_2(DATA_BUT[2]),
	.iBANK_3(DATA_BUT[3]),
	
	.iSIN_0(SIN_0),
	.iCOS_0(COS_0),
	
	.iSIN_1(SIN_1),
	.iCOS_1(COS_1),
	
	.oY_0(DATA_BUT_RAM[0]),
	.oY_1(DATA_BUT_RAM[1]),
	.oY_2(DATA_BUT_RAM[2]),
	.oY_3(DATA_BUT_RAM[3])
);

// ========================== RAM: ============================ //

fht_ram_block #(.D_BIT(D_BIT), .A_BIT(A_BIT), .DEPTH(`BANK_SIZE)) FHT_RAM_A(
	.iCLK(iCLK),
	.iRESET(iRESET),

	.iDATA_0(DATA_RAM_A[0]),
	.iDATA_1(DATA_RAM_A[1]),
	.iDATA_2(DATA_RAM_A[2]),
	.iDATA_3(DATA_RAM_A[3]),

	.iADDR_RD_0(ADDR_RD[0]),
	.iADDR_RD_1(ADDR_RD[1]),
	.iADDR_RD_2(ADDR_RD[2]),
	.iADDR_RD_3(ADDR_RD[3]),

	.iADDR_WR_0(ADDR_WR[0]),
	.iADDR_WR_1(ADDR_WR[1]),
	.iADDR_WR_2(ADDR_WR[2]),
	.iADDR_WR_3(ADDR_WR[3]),

	.iWE_0(WE[0]),
	.iWE_1(WE[1]),
	.iWE_2(WE[2]),
	.iWE_3(WE[3]),

	.oDATA_0(DATA_RAM_A_BUT[0]),
	.oDATA_1(DATA_RAM_A_BUT[1]),
	.oDATA_2(DATA_RAM_A_BUT[2]),
	.oDATA_3(DATA_RAM_A_BUT[3])
);

fht_ram_block #(.D_BIT(D_BIT), .A_BIT(A_BIT), .DEPTH(`BANK_SIZE)) FHT_RAM_B(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iDATA_0(DATA_BUT_RAM[0]),
	.iDATA_1(DATA_BUT_RAM[1]),
	.iDATA_2(DATA_BUT_RAM[2]),
	.iDATA_3(DATA_BUT_RAM[3]),
	
	.iADDR_RD_0(ADDR_RD_CTRL[0]),
	.iADDR_RD_1(ADDR_RD_CTRL[1]),
	.iADDR_RD_2(ADDR_RD_CTRL[2]),
	.iADDR_RD_3(ADDR_RD_CTRL[3]),
	
	.iADDR_WR_0(ADDR_WR_CTRL[0]),
	.iADDR_WR_1(ADDR_WR_CTRL[1]),
	.iADDR_WR_2(ADDR_WR_CTRL[2]),
	.iADDR_WR_3(ADDR_WR_CTRL[3]),

	.iWE_0(WE_B),
	.iWE_1(WE_B),
	.iWE_2(WE_B),
	.iWE_3(WE_B),
	
	.oDATA_0(DATA_RAM_B_BUT[0]),
	.oDATA_1(DATA_RAM_B_BUT[1]),
	.oDATA_2(DATA_RAM_B_BUT[2]),
	.oDATA_3(DATA_RAM_B_BUT[3])
);

// ========================== ROM: ============================= //

fht_rom_block #(.A_BIT(A_BIT - 2), .DEPTH(`DEPTH_ROM), .W_BIT(W_BIT),
					 .MIF_SIN(MIF_SIN), .MIF_COS(MIF_COS)) ROM_BLOCK(
	.iCLK(iCLK),
	
	.iST_ZERO(ST_ZERO),
	
	.iADDR(ADDR_COEF),
	
	.oSIN_0(SIN_0),
	.oCOS_0(COS_0),
	
	.oSIN_1(SIN_1),
	.oCOS_1(COS_1)
);

`ifdef LAST_STAGE_ODD
	assign oDATA_0 = DATA_RAM_A_BUT[0];
	assign oDATA_1 = DATA_RAM_A_BUT[1];
	assign oDATA_2 = DATA_RAM_A_BUT[2];
	assign oDATA_3 = DATA_RAM_A_BUT[3];
`elsif LAST_STAGE_EVEN
	assign oDATA_0 = DATA_RAM_B_BUT[0];
	assign oDATA_1 = DATA_RAM_B_BUT[1];
	assign oDATA_2 = DATA_RAM_B_BUT[2];
	assign oDATA_3 = DATA_RAM_B_BUT[3];
`endif

assign oRDY = RDY;

endmodule 