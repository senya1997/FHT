`include "fht_defines.v"

module fht_top(
	input iCLK,
	input iRESET,
	
	input iSTART,
	
	input [`D_BIT - 1 : 0] iDATA,
	input [`A_BIT - 1 : 0] iADDR_WR,
	
	input [`A_BIT - 1 : 0] iADDR_RD_0,
	input [`A_BIT - 1 : 0] iADDR_RD_1,
	input [`A_BIT - 1 : 0] iADDR_RD_2,
	input [`A_BIT - 1 : 0] iADDR_RD_3,
	
	input iWE,
	
	output [`D_BIT - 1 : 0] oDATA_0,
	output [`D_BIT - 1 : 0] oDATA_1,
	output [`D_BIT - 1 : 0] oDATA_2,
	output [`D_BIT - 1 : 0] oDATA_3,
	
	output oRDY
);

wire ST_ZERO, ST_LAST;
wire SEC_PART_SUBSEC;
wire SECTOR;

wire [`A_BIT - 1 : 0] ADDR_COEF;

wire signed [`W_BIT - 1 : 0] SIN_0, COS_0;
wire signed [`W_BIT - 1 : 0] SIN_1, COS_1;

wire RDY;

fht_control #(.A_BIT(`A_BIT), .SEC_BIT(`SEC_BIT)) CONTROL(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iSTART(iSTART),
	
	.oST_ZERO(ST_ZERO),
	.oST_LAST(ST_LAST), 
	.o2ND_PART_SUBSEC(SEC_PART_SUBSEC),
	.oSECTOR(SECTOR), 
	
	.oADDR_RD_0(),
	.oADDR_RD_1(),
	.oADDR_RD_2(),
	.oADDR_RD_3(),
	
	.oADDR_WR_0(),
	.oADDR_WR_1(),
	.oADDR_WR_2(),
	.oADDR_WR_3(),
	
	.oADDR_COEF(ADDR_COEF),
	
	.oWE_A(),
	.oWE_B(),
	
	.oSOURCE_DATA(),
	.oSOURCE_CONT(),
	
	.oRDY(RDY)
);

fht_but_block #(.D_BIT(`D_BIT), .W_BIT(`W_BIT), .SEC_BIT(`SEC_BIT)) BUT_BLOCK(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iST_ZERO(ST_ZERO),
	.iST_LAST(ST_LAST),
	.i2ND_PART_SUBSEC(SEC_PART_SUBSEC),
	.iSECTOR(SECTOR),
	
	.iBANK_0(), 
	.iBANK_1(),
	.iBANK_2(),
	.iBANK_3(),
	
	.iSIN_0(SIN_0),
	.iCOS_0(COS_0),
	
	.iSIN_1(SIN_1),
	.iCOS_1(COS_1),
	
	.oY_0(),
	.oY_1(),
	.oY_2(),
	.oY_3()
);
	
// ==================== RAM: ======================

fht_ram_block #(.D_BIT(`D_BIT), .A_BIT(`A_BIT)) FHT_RAM_A(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iDATA_0(),
	.iDATA_1(),
	.iDATA_2(),
	.iDATA_3(),
	
	.iADDR_RD_0(),
	.iADDR_RD_1(),
	.iADDR_RD_2(),
	.iADDR_RD_3(),
	
	.iADDR_WR_0(),
	.iADDR_WR_1(),
	.iADDR_WR_2(),
	.iADDR_WR_3(),

	.iWE_0(),
	.iWE_1(),
	.iWE_2(),
	.iWE_3(),
	
	.oDATA_0(),
	.oDATA_1(),
	.oDATA_2(),
	.oDATA_3()
);

fht_ram_block #(.D_BIT(`D_BIT), .A_BIT(`A_BIT)) FHT_RAM_B(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iDATA_0(),
	.iDATA_1(),
	.iDATA_2(),
	.iDATA_3(),
	
	.iADDR_RD_0(),
	.iADDR_RD_1(),
	.iADDR_RD_2(),
	.iADDR_RD_3(),
	
	.iADDR_WR_0(),
	.iADDR_WR_1(),
	.iADDR_WR_2(),
	.iADDR_WR_3(),

	.iWE_0(),
	.iWE_1(),
	.iWE_2(),
	.iWE_3(),
	
	.oDATA_0(),
	.oDATA_1(),
	.oDATA_2(),
	.oDATA_3()
);

// ==================== ROM: ======================

fht_rom_block #(.W_BIT(`W_BIT), .A_BIT(`A_BIT),
					 .MIF_SIN(`MIF_SIN), 
					 .MIF_COS(`MIF_COS)) ROM_BLOCK(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iADDR(ADDR_COEF),
	
	.oSIN_0(SIN_0),
	.oCOS_0(COS_0),
	
	.oSIN_1(SIN_1),
	.oCOS_1(COS_1)
);

assign oRDY = RDY;

endmodule 