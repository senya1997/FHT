`include "fht_defines.v"
`include "fht_defines_tb.v"

module fht_top(
	input	iCLK,
	input	iRESET,
	
	input iSTART,
	
	input [`D_BIT - 2 : 0] iDATA, // ADC data without expansion bit
	
	input [`A_BIT - 1 : 0] iADDR_RD_0,
	input [`A_BIT - 1 : 0] iADDR_RD_1,
	input [`A_BIT - 1 : 0] iADDR_RD_2,
	input [`A_BIT - 1 : 0] iADDR_RD_3,

	input [`A_BIT - 1 : 0] iADDR_WR_0,
	input [`A_BIT - 1 : 0] iADDR_WR_1,
	input [`A_BIT - 1 : 0] iADDR_WR_2,
	input [`A_BIT - 1 : 0] iADDR_WR_3,
	
	input iWE_0,
	input iWE_1,
	input iWE_2,
	input iWE_3,	
	
	output [`D_BIT - 1 : 0] oDATA_RE_0,
	output [`D_BIT - 1 : 0] oDATA_RE_1,
	output [`D_BIT - 1 : 0] oDATA_RE_2,
	output [`D_BIT - 1 : 0] oDATA_RE_3,
	
	output oRDY
);

wire SOURCE_CONT;

wire [1 : 0] BANK_RD_ROT;
wire [1 : 0] BANK_WR_ROT;

wire [`D_BIT - 1 : 0] RE_RAM_A [0 : 3];
wire [`D_BIT - 1 : 0] RE_OUTMIX [0 : 3];
	assign RE_RAM_A[0] = SOURCE_CONT ? {iDATA[15], iDATA} : RE_OUTMIX[0];
	assign RE_RAM_A[1] = SOURCE_CONT ? {iDATA[15], iDATA} : RE_OUTMIX[1];
	assign RE_RAM_A[2] = SOURCE_CONT ? {iDATA[15], iDATA} : RE_OUTMIX[2];
	assign RE_RAM_A[3] = SOURCE_CONT ? {iDATA[15], iDATA} : RE_OUTMIX[3];

wire [`A_BIT - 1 : 0] ADDR_RD_CTRL [0 : 3];
wire [`A_BIT - 1 : 0] ADDR_RD [0 : 3];
	assign ADDR_RD[0] = SOURCE_CONT ? iADDR_RD_0 : ADDR_RD_CTRL[0];
	assign ADDR_RD[1] = SOURCE_CONT ? iADDR_RD_1 : ADDR_RD_CTRL[1];
	assign ADDR_RD[2] = SOURCE_CONT ? iADDR_RD_2 : ADDR_RD_CTRL[2];
	assign ADDR_RD[3] = SOURCE_CONT ? iADDR_RD_3 : ADDR_RD_CTRL[3];

wire [`A_BIT - 1 : 0] ADDR_WR_CTRL;	
wire [`A_BIT - 1 : 0] ADDR_WR [0 : 3];
	assign ADDR_WR[0] = SOURCE_CONT ? iADDR_WR_0 : ADDR_WR_CTRL;
	assign ADDR_WR[1] = SOURCE_CONT ? iADDR_WR_1 : ADDR_WR_CTRL;
	assign ADDR_WR[2] = SOURCE_CONT ? iADDR_WR_2 : ADDR_WR_CTRL;
	assign ADDR_WR[3] = SOURCE_CONT ? iADDR_WR_3 : ADDR_WR_CTRL;

wire WE_A_CTRL;
wire WE_B_CTRL;
wire [3 : 0] WE;
	assign WE[0] = SOURCE_CONT ? iWE_0 : WE_A_CTRL;
	assign WE[1] = SOURCE_CONT ? iWE_1 : WE_A_CTRL;
	assign WE[2] = SOURCE_CONT ? iWE_2 : WE_A_CTRL;
	assign WE[3] = SOURCE_CONT ? iWE_3 : WE_A_CTRL;

`ifdef TEST_MIXER	
	wire [`A_BIT - 1 : 0] ADDR_COEF = 0; // "turn off" multipliers
`else
	wire [`A_BIT - 1 : 0] ADDR_COEF;
`endif

wire [11 : 0] W_RE [1 : 3];
wire [11 : 0] W_IM [1 : 3];

// syntax: RE_"FROM"_"TO", IM_"FROM"_"TO"

wire [`D_BIT - 1 : 0] RE_RAM_A_INMIX [0 : 3];
wire [`D_BIT - 1 : 0] IM_RAM_A_INMIX [0 : 3];
wire [`D_BIT - 1 : 0] RE_RAM_B_INMIX [0 : 3];
wire [`D_BIT - 1 : 0] IM_RAM_B_INMIX [0 : 3];

wire [`D_BIT - 1 : 0] RE_INMIX [0 : 3];
wire [`D_BIT - 1 : 0] IM_INMIX [0 : 3];

wire SOURCE_DATA;

genvar k;
generate
	for(k = 0; k < 4; k = k + 1)
		begin: data_for_inmix
			assign RE_INMIX[k] = SOURCE_CONT ? 17'd0 : (SOURCE_DATA ? RE_RAM_B_INMIX[k] : RE_RAM_A_INMIX[k]);
			assign IM_INMIX[k] = SOURCE_CONT ? 17'd0 : (SOURCE_DATA ? IM_RAM_B_INMIX[k] : IM_RAM_A_INMIX[k]);
		end
endgenerate
	
// =================   control   ===================

	fft_control #(.A_BIT(`A_BIT)) CONTROL(
		.iCLK(iCLK),
		.iRESET(iRESET),
		
		.iSTART(iSTART),
		
		.oBANK_RD_ROT(BANK_RD_ROT),
		.oBANK_WR_ROT(BANK_WR_ROT),
		
		.oADDR_RD_0(ADDR_RD_CTRL[0]),
		.oADDR_RD_1(ADDR_RD_CTRL[1]),
		.oADDR_RD_2(ADDR_RD_CTRL[2]),
		.oADDR_RD_3(ADDR_RD_CTRL[3]),
		
		.oADDR_WR(ADDR_WR_CTRL),
		
		`ifdef TEST_MIXER
			.oADDR_COEF(),
		`elsif TEST_FFT
			.oADDR_COEF(ADDR_COEF),
		`endif
		
		.oWE_A(WE_A_CTRL),
		.oWE_B(WE_B_CTRL),
		
		.oSOURCE_DATA(SOURCE_DATA),
		.oSOURCE_CONT(SOURCE_CONT),
		
		.oRDY(oRDY)
	);

// =================   rotator   ===================

wire [`D_BIT - 1 : 0] RE_INMIX_BUT [0 : 3];
wire [`D_BIT - 1 : 0] IM_INMIX_BUT [0 : 3];

wire [`D_BIT - 1 : 0] RE_MULT_OUTMIX [0 : 3];
wire [`D_BIT - 1 : 0] IM_MULT_OUTMIX [0 : 3];

wire [`D_BIT - 1 : 0] IM_OUTMIX [0 : 3];

	fft_input_mix #(.BIT(`D_BIT)) INPUT_MIX(
		.iCLK(iCLK),
		.iRESET(iRESET),
		
		.iSEL(BANK_RD_ROT),
		
		.iX0_RE(RE_INMIX[0]),
		.iX0_IM(IM_INMIX[0]),
		.iX1_RE(RE_INMIX[1]),
		.iX1_IM(IM_INMIX[1]),
		.iX2_RE(RE_INMIX[2]),
		.iX2_IM(IM_INMIX[2]),
		.iX3_RE(RE_INMIX[3]),
		.iX3_IM(IM_INMIX[3]),
		
		.oY0_RE(RE_INMIX_BUT[0]),
		.oY0_IM(IM_INMIX_BUT[0]),
		.oY1_RE(RE_INMIX_BUT[1]),
		.oY1_IM(IM_INMIX_BUT[1]),
		.oY2_RE(RE_INMIX_BUT[2]),
		.oY2_IM(IM_INMIX_BUT[2]),
		.oY3_RE(RE_INMIX_BUT[3]),
		.oY3_IM(IM_INMIX_BUT[3])
	);
	
	fft_output_mix #(.BIT(`D_BIT)) OUTPUT_MIX(
		.iCLK(iCLK),
		.iRESET(iRESET),
		
		.iSEL(BANK_WR_ROT),
		
		.iX0_RE(RE_MULT_OUTMIX[0]),
		.iX0_IM(IM_MULT_OUTMIX[0]),
		.iX1_RE(RE_MULT_OUTMIX[1]),
		.iX1_IM(IM_MULT_OUTMIX[1]),
		.iX2_RE(RE_MULT_OUTMIX[2]),
		.iX2_IM(IM_MULT_OUTMIX[2]),
		.iX3_RE(RE_MULT_OUTMIX[3]),
		.iX3_IM(IM_MULT_OUTMIX[3]),
		
		.oY0_RE(RE_OUTMIX[0]),
		.oY0_IM(IM_OUTMIX[0]),
		.oY1_RE(RE_OUTMIX[1]),
		.oY1_IM(IM_OUTMIX[1]),
		.oY2_RE(RE_OUTMIX[2]),
		.oY2_IM(IM_OUTMIX[2]),
		.oY3_RE(RE_OUTMIX[3]),
		.oY3_IM(IM_OUTMIX[3])
	);

// =================   butterfly and multipiler   ===================

wire [`D_BIT - 1 : 0] RE_BUT_MULT [0 : 3];
wire [`D_BIT - 1 : 0] IM_BUT_MULT [0 : 3];

`ifdef TEST_MIXER
	reg [`D_BIT - 1 : 0] re_delay [0 : 3];
	reg [`D_BIT - 1 : 0] im_delay [0 : 3];
	
	genvar k;
	generate
		for(k = 0; k < 4; k = k + 1)
			begin: but_delay
				always@(posedge iCLK or negedge iRESET)begin
					if(!iRESET) re_delay[k] = 0;
					else re_delay[k] = RE_INMIX_BUT[k];
				end

				always@(posedge iCLK or negedge iRESET)begin
					if(!iRESET) im_delay[k] = 0;
					else im_delay[k] = IM_INMIX_BUT[k];
				end
				
				assign RE_BUT_MULT[k] = re_delay[k];
				assign IM_BUT_MULT[k] = im_delay[k];
			end
	endgenerate
`else
	fft_but_comp #(.BIT(`D_BIT)) BUTTER(
		.iCLK(iCLK),
		.iRESET(iRESET),

		.iX0_RE(RE_INMIX_BUT[0]),
		.iX0_IM(IM_INMIX_BUT[0]),
		.iX1_RE(RE_INMIX_BUT[1]),
		.iX1_IM(IM_INMIX_BUT[1]),
		.iX2_RE(RE_INMIX_BUT[2]),
		.iX2_IM(IM_INMIX_BUT[2]),
		.iX3_RE(RE_INMIX_BUT[3]),
		.iX3_IM(IM_INMIX_BUT[3]),
		
		.oY0_RE(RE_BUT_MULT[0]),
		.oY0_IM(IM_BUT_MULT[0]),
		.oY1_RE(RE_BUT_MULT[1]),
		.oY1_IM(IM_BUT_MULT[1]),
		.oY2_RE(RE_BUT_MULT[2]),
		.oY2_IM(IM_BUT_MULT[2]),
		.oY3_RE(RE_BUT_MULT[3]),
		.oY3_IM(IM_BUT_MULT[3])
	);
`endif
	
	fft_mult_block #(.D_BIT(`D_BIT), .W_BIT(`W_BIT)) MULT_BLOCK(
		.iCLK(iCLK),
		.iRESET(iRESET),
		
		.iX0_RE(RE_BUT_MULT[0]),
		.iX0_IM(IM_BUT_MULT[0]),
		.iX1_RE(RE_BUT_MULT[1]),
		.iX1_IM(IM_BUT_MULT[1]),
		.iX2_RE(RE_BUT_MULT[2]),
		.iX2_IM(IM_BUT_MULT[2]),
		.iX3_RE(RE_BUT_MULT[3]),
		.iX3_IM(IM_BUT_MULT[3]),
		
		.iW1_RE(W_RE[1]),
		.iW1_IM(W_IM[1]),
		.iW2_RE(W_RE[2]),
		.iW2_IM(W_IM[2]),
		.iW3_RE(W_RE[3]),
		.iW3_IM(W_IM[3]),
		
		.oY0_RE(RE_MULT_OUTMIX[0]),
		.oY0_IM(IM_MULT_OUTMIX[0]),
		.oY1_RE(RE_MULT_OUTMIX[1]),
		.oY1_IM(IM_MULT_OUTMIX[1]),
		.oY2_RE(RE_MULT_OUTMIX[2]),
		.oY2_IM(IM_MULT_OUTMIX[2]),
		.oY3_RE(RE_MULT_OUTMIX[3]),
		.oY3_IM(IM_MULT_OUTMIX[3])
	);	
	
// ==================== RAM: ======================

wire [`D_BIT - 1 : 0] IM_RAM_A [0 : 3];

assign IM_RAM_A[0] = SOURCE_CONT ? 0 : IM_OUTMIX[0];
assign IM_RAM_A[1] = SOURCE_CONT ? 0 : IM_OUTMIX[1];
assign IM_RAM_A[2] = SOURCE_CONT ? 0 : IM_OUTMIX[2];
assign IM_RAM_A[3] = SOURCE_CONT ? 0 : IM_OUTMIX[3];	
	
	fft_ram_block #(.D_BIT(`D_BIT), .A_BIT(`A_BIT)) RAM_A(
		.iCLK(iCLK),
		
		.iDATA_RE_0(RE_RAM_A[0]),
		.iDATA_IM_0(IM_RAM_A[0]),
		.iDATA_RE_1(RE_RAM_A[1]),
		.iDATA_IM_1(IM_RAM_A[1]),
		.iDATA_RE_2(RE_RAM_A[2]),
		.iDATA_IM_2(IM_RAM_A[2]),
		.iDATA_RE_3(RE_RAM_A[3]),
		.iDATA_IM_3(IM_RAM_A[3]),
		
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
		
		.oDATA_RE_0(RE_RAM_A_INMIX[0]),
		.oDATA_IM_0(IM_RAM_A_INMIX[0]),
		.oDATA_RE_1(RE_RAM_A_INMIX[1]),
		.oDATA_IM_1(IM_RAM_A_INMIX[1]),
		.oDATA_RE_2(RE_RAM_A_INMIX[2]),
		.oDATA_IM_2(IM_RAM_A_INMIX[2]),
		.oDATA_RE_3(RE_RAM_A_INMIX[3]),
		.oDATA_IM_3(IM_RAM_A_INMIX[3])
	);
	
	fft_ram_block #(.D_BIT(`D_BIT), .A_BIT(`A_BIT)) RAM_B(
		.iCLK(iCLK),
		
		.iDATA_RE_0(RE_OUTMIX[0]),
		.iDATA_IM_0(IM_OUTMIX[0]),
		.iDATA_RE_1(RE_OUTMIX[1]),
		.iDATA_IM_1(IM_OUTMIX[1]),
		.iDATA_RE_2(RE_OUTMIX[2]),
		.iDATA_IM_2(IM_OUTMIX[2]),
		.iDATA_RE_3(RE_OUTMIX[3]),
		.iDATA_IM_3(IM_OUTMIX[3]),
		
		.iADDR_RD_0(ADDR_RD_CTRL[0]),
		.iADDR_RD_1(ADDR_RD_CTRL[1]),
		.iADDR_RD_2(ADDR_RD_CTRL[2]),
		.iADDR_RD_3(ADDR_RD_CTRL[3]),
		
		.iADDR_WR_0(ADDR_WR_CTRL),
		.iADDR_WR_1(ADDR_WR_CTRL),
		.iADDR_WR_2(ADDR_WR_CTRL),
		.iADDR_WR_3(ADDR_WR_CTRL),

		.iWE_0(WE_B_CTRL),
		.iWE_1(WE_B_CTRL),
		.iWE_2(WE_B_CTRL),
		.iWE_3(WE_B_CTRL),
		
		.oDATA_RE_0(RE_RAM_B_INMIX[0]),
		.oDATA_IM_0(IM_RAM_B_INMIX[0]),
		.oDATA_RE_1(RE_RAM_B_INMIX[1]),
		.oDATA_IM_1(IM_RAM_B_INMIX[1]),
		.oDATA_RE_2(RE_RAM_B_INMIX[2]),
		.oDATA_IM_2(IM_RAM_B_INMIX[2]),
		.oDATA_RE_3(RE_RAM_B_INMIX[3]),
		.oDATA_IM_3(IM_RAM_B_INMIX[3])
	);	

// ==================== ROM: ======================

	fft_rom #(.MIF(`MIF_1)) ROM_1(
		.address(ADDR_COEF),
		.clock(iCLK),
		.q({W_IM[1], W_RE[1]})
	);

	fft_rom #(.MIF(`MIF_2)) ROM_2(
		.address(ADDR_COEF),
		.clock(iCLK),
		.q({W_IM[2], W_RE[2]})
	);

	fft_rom #(.MIF(`MIF_3)) ROM_3(
		.address(ADDR_COEF),
		.clock(iCLK),
		.q({W_IM[3], W_RE[3]})
	);

assign oDATA_RE_0 = RE_RAM_A_INMIX[0];
assign oDATA_RE_1 = RE_RAM_A_INMIX[1];
assign oDATA_RE_2 = RE_RAM_A_INMIX[2];
assign oDATA_RE_3 = RE_RAM_A_INMIX[3];
	
endmodule 