module fht_control #(parameter A_BIT = 8, SEC_BIT = 9)(
	input iCLK,
	input iRESET,
	
	input iSTART,
	
	output oST_ZERO, // "0" stage - without multipliers
	output oST_LAST, // on last stage output bank mixer save data in direct order
	output o2ND_PART_SUBSEC, // on 1st and 2nd part of subsector point save in different bank order on output bank mixer
	output [SEC_BIT - 1 : 0] oSECTOR, // defines read order of input data in input bank mixer
	
	output [A_BIT - 1 : 0] oADDR_RD_0,
	output [A_BIT - 1 : 0] oADDR_RD_1,
	output [A_BIT - 1 : 0] oADDR_RD_2,
	output [A_BIT - 1 : 0] oADDR_RD_3,
	
	output [A_BIT - 1 : 0] oADDR_WR,
	output [A_BIT - 1 : 0] oADDR_WR_BIAS,
	
	output [A_BIT - 1 : 0] oADDR_COEF,
	
	output oWE_A,
	output oWE_B,
	
	output oSOURCE_DATA,
	output oSOURCE_CONT,
	
	output oRDY
);

reg clk_2; // clk divide 2

reg [3 : 0] stage; // = log(N)/log(2) - 1
reg [9 : 0] cnt_stage_time; // length of bank RAM * 2 (because butterfly performed in 2 tact) + reserve (for wait time end of writing in RAM)

reg [8 : 0] div; // this "div" = "2*div" from matlab
reg [3 : 0] div_2; // replacement mult on 'div' in calc bias by shift

reg [8 : 0] cnt_sector;
reg [8 : 0] cnt_sector_time;

reg [8 : 0] size_bias_rd;
reg signed [8 : 0] cnt_bias_rd; // required to go [7 : 0], beacuse max 'size_bias_rd' = 256 => max 'cnt_bias_rd' = 255

reg [A_BIT - 1 : 0] addr_rd;
reg [A_BIT - 1 : 0] addr_rd_bias;

reg [A_BIT - 1 : 0] addr_wr;
reg [A_BIT - 1 : 0] addr_wr_bias;

reg [A_BIT - 1 : 0] addr_coef;

reg we_a;
reg we_b;

reg source_data;
reg source_cont;

reg rdy;

wire N_CLK_2 = ~clk_2;

wire ZERO_STAGE =	(stage == 4'd0 & !rdy); // to aviod "1" on output when FHT is not started
wire LAST_STAGE =	(stage == 4'd9);

wire EOF_STAGE =				(cnt_stage_time == 10'd517);
wire EOF_READ =				(cnt_stage_time >= 10'd511);

wire EOF_SECTOR =				(cnt_sector_time == div);
wire EOF_SECTOR_BEHIND_POS =	LAST_STAGE ? EOF_SECTOR : ((cnt_sector_time == div - 9'd1) & clk_2);
wire EOF_SECTOR_BEHIND_NEG =	((cnt_sector_time == div - 9'd1) & N_CLK_2);
wire EOF_SECTOR_BEHIND_BEH =	(((cnt_sector_time == 9'd0) & clk_2) | EOF_SECTOR_BEHIND_POS);

wire SEC_PART_SUBSEC =	(cnt_sector_time >= (div >> 1));

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) clk_2 <= 1'b0;
	else clk_2 <= ~clk_2;
end

// *********** stage counters: *********** //

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) stage <= 4'd0;
	else if(rdy) stage <= 4'd0;
	else if(EOF_STAGE) stage <= stage + 1'b1;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) cnt_stage_time <= 10'd0;
	else if(rdy | EOF_STAGE) cnt_stage_time <= 10'd0;
	else cnt_stage_time <= cnt_stage_time + 1'b1;
end

// *********** sector counters: *********** //

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) 
		begin
			div <= 9'd256; // required to add in defines div = N/N_bank
			div_2 <= 4'd8;
		end
	else if(rdy) 
		begin
			div <= 9'd256;
			div_2 <= 4'd8;
		end
	else if(EOF_STAGE & (!ZERO_STAGE)) 
		begin
			div <= (div >> 1);
			div_2 <= div_2 - 1'b1;
		end
end

wire RESET_CNT = (rdy | EOF_READ);

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) cnt_sector <= 9'd0;
	else if(RESET_CNT | EOF_STAGE ) cnt_sector <= 9'd0;
	else if(EOF_SECTOR) cnt_sector <= cnt_sector + 1'b1;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) cnt_sector_time <= 9'd0;
	else if(RESET_CNT | EOF_SECTOR ) cnt_sector_time <= 9'd0;
	else if(N_CLK_2) cnt_sector_time <= cnt_sector_time + 1'b1;
end

// ************* choose addr: ************* //

// read:
wire NEW_BIAS_RD = ((cnt_bias_rd == -(size_bias_rd - 1'b1)) & (LAST_STAGE ? cnt_sector >= 9'd0 : cnt_sector >= 9'd1));

wire [A_BIT - 1 : 0] INC_ADDR_RD = (addr_rd + 1'b1);
wire signed [9 : 0] BIAS_RD = LAST_STAGE ? (INC_ADDR_RD + cnt_bias_rd) : (INC_ADDR_RD + (cnt_bias_rd << div_2));

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) size_bias_rd <= 9'd0;
	else if(EOF_STAGE) size_bias_rd <= 9'd1;
	else if((LAST_STAGE ? EOF_SECTOR_BEHIND_BEH : EOF_SECTOR_BEHIND_POS) & NEW_BIAS_RD) size_bias_rd = (size_bias_rd << 1);
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) cnt_bias_rd <= 9'd0;
	else if(EOF_STAGE) cnt_bias_rd <= 9'd2;
	else if(LAST_STAGE ? EOF_SECTOR_BEHIND_BEH : EOF_SECTOR_BEHIND_POS)
		begin
			if(NEW_BIAS_RD) cnt_bias_rd = size_bias_rd - 1'b1;
			else cnt_bias_rd = cnt_bias_rd - 9'd2;
		end
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) addr_rd <= 0;
	else if(RESET_CNT) addr_rd <= 0;
	else if(N_CLK_2) addr_rd <= INC_ADDR_RD;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) addr_rd_bias <= 0;
	else if(RESET_CNT) addr_rd_bias <= 0;
	else if(N_CLK_2)
		begin
			if((cnt_sector > 9'd1) | ((cnt_sector == 9'd1) & EOF_SECTOR_BEHIND_NEG)) addr_rd_bias <= BIAS_RD[7 : 0];
			else  addr_rd_bias <= addr_rd_bias + 1'b1;
		end
end

// write:

// coef:

// ************** others: ************** //

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) rdy <= 1'b1;
	else if(iSTART) rdy <= 1'b0;
	else if(LAST_STAGE & EOF_STAGE) rdy <= 1'b1;
end

always@(posedge iCLK or negedge iRESET) begin
	if(!iRESET) source_data <= 1'b0;
	else if(rdy) source_data <= 1'b0;
	else if(EOF_STAGE) source_data <= ~source_data;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) source_cont <= 1'b0;
	else if(iSTART) source_cont <= 1'b0;
	else source_cont <= rdy;
end

// ************ output ports: ************ //

assign oST_ZERO =				ZERO_STAGE; // mb required reg
assign oST_LAST = 			LAST_STAGE;
assign o2ND_PART_SUBSEC =	SEC_PART_SUBSEC;

assign oSECTOR = cnt_sector;

assign oADDR_RD_0 = addr_rd;
assign oADDR_RD_1 = addr_rd_bias;
assign oADDR_RD_2 = addr_rd;
assign oADDR_RD_3 = addr_rd_bias;

assign oSOURCE_DATA = source_data;
assign oSOURCE_CONT = source_cont;

assign oRDY = rdy;

endmodule 