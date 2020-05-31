module fht_ram_block #(parameter D_BIT = 17, A_BIT = 8)(
	input iCLK,
	input iRESET,
	
	input [D_BIT - 1 : 0] iDATA_0,
	input [D_BIT - 1 : 0] iDATA_1,
	input [D_BIT - 1 : 0] iDATA_2,
	input [D_BIT - 1 : 0] iDATA_3,
	
	input [A_BIT - 1 : 0] iADDR_RD_0,
	input [A_BIT - 1 : 0] iADDR_RD_1,
	input [A_BIT - 1 : 0] iADDR_RD_2,
	input [A_BIT - 1 : 0] iADDR_RD_3,
	
	input [A_BIT - 1 : 0] iADDR_WR_0,
	input [A_BIT - 1 : 0] iADDR_WR_1,
	input [A_BIT - 1 : 0] iADDR_WR_2,
	input [A_BIT - 1 : 0] iADDR_WR_3,

	input iWE_0,
	input iWE_1,
	input iWE_2,
	input iWE_3,
	
	output [D_BIT - 1 : 0] oDATA_0,
	output [D_BIT - 1 : 0] oDATA_1,
	output [D_BIT - 1 : 0] oDATA_2,
	output [D_BIT - 1 : 0] oDATA_3
);

wire [D_BIT - 1 : 0] DATA_IN [0 : 3];
	assign DATA_IN[0] = iDATA_0;
	assign DATA_IN[1] = iDATA_1;
	assign DATA_IN[2] = iDATA_2;
	assign DATA_IN[3] = iDATA_3;

wire [A_BIT - 1 : 0] ADDR_RD [0 : 3];
	assign ADDR_RD[0] = iADDR_RD_0;
	assign ADDR_RD[1] = iADDR_RD_1;
	assign ADDR_RD[2] = iADDR_RD_2;
	assign ADDR_RD[3] = iADDR_RD_3;
	
wire [A_BIT - 1 : 0] ADDR_WR [0 : 3];
	assign ADDR_WR[0] = iADDR_WR_0;
	assign ADDR_WR[1] = iADDR_WR_1;
	assign ADDR_WR[2] = iADDR_WR_2;
	assign ADDR_WR[3] = iADDR_WR_3;

wire [3 : 0] WE = {iWE_3, iWE_2, iWE_1, iWE_0};

wire [D_BIT - 1 : 0] DATA_OUT [0 : 3];

genvar k;
generate 
	for(k = 0; k < 4; k = k + 1)
		begin: ram_bank
			fht_ram RAM_BANK(
				.clock(iCLK),
				.data(DATA_IN[k]),
				.rdaddress(ADDR_RD[k]),
				.wraddress(ADDR_WR[k]),
				.wren(WE[k]),
				.q(DATA_OUT[k])
			);
		end
endgenerate

assign oDATA_0 = DATA_OUT[0];
assign oDATA_1 = DATA_OUT[1];
assign oDATA_2 = DATA_OUT[2];
assign oDATA_3 = DATA_OUT[3];
	
endmodule 