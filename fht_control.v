module fht_control #(parameter A_BIT = 8, SEC_BIT = 9)(
	input iCLK,
	input iCLK_2,
	
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
	
	output [A_BIT - 1 : 0] oADDR_WR_0,
	output [A_BIT - 1 : 0] oADDR_WR_1,
	output [A_BIT - 1 : 0] oADDR_WR_2,
	output [A_BIT - 1 : 0] oADDR_WR_3,
	
	output [A_BIT - 1 : 0] oADDR_COEF,
	
	output oWE_A,
	output oWE_B,
	
	output oSOURCE_DATA,
	output oSOURCE_CONT,
	
	output oRDY
);

reg clk_2;

reg [3 : 0] cnt_stage; // max = log(N)/log(2) - 1
reg [9 : 0] cnt_stage_time; // length of bank + reserve (for wait time end of writing in RAM)

reg [8 : 0] div; // this 'div' = '2*div' from matlab model
reg [3 : 0] div_2; // replacement mult on 'div' in calc bias by shift on 'div_2'

reg [SEC_BIT - 1 : 0] cnt_sector;
reg [SEC_BIT - 1 : 0] cnt_sector_d;
reg [8 : 0] cnt_sector_time;

reg [8 : 0] size_bias_rd;
reg signed [8 : 0] cnt_bias_rd; // required to go [7 : 0], beacuse max 'size_bias_rd' = 256 => max 'cnt_bias_rd' = 255

reg [A_BIT - 1 : 0] addr_rd_cnt; // addr_rd never swap, this reg is always 0-255 counter
reg [A_BIT - 1 : 0] addr_rd_bias; // 0-255 on 0,1 sector, after - is added bias

reg [A_BIT - 1 : 0] addr_wr_cnt, addr_wr_cnt_d; // analog 'addr_rd_cnt'
reg [A_BIT - 1 : 0] addr_wr_bias; // bias on write addr swap every half subsector from this reg on another

reg [A_BIT - 3 : 0] addr_coef_cnt;
reg [A_BIT - 3 : 0] addr_coef;

reg [4 : 0] sec_part_subsec_d;

reg we_a;
reg we_b;

reg source_data;
reg source_cont;

reg rdy;

wire ZERO_STAGE =	(cnt_stage == 4'd0 & !rdy); // to aviod "1" on output when FHT is not started
wire LAST_STAGE =	(cnt_stage == 4'd9);

wire WE_EN =			(cnt_stage_time >= 10'd2);
wire COEF_EN =			(cnt_stage_time >= 10'd1);

wire EOF_READ =		(cnt_stage_time >= 10'd255);
wire EOF_COEF =		(cnt_stage_time >= 10'd256);

wire EOF_STAGE =		(cnt_stage_time == 10'd258);
wire EOF_STAGE_1 =	(cnt_stage_time == 10'd257); // behind 'EOF_STAGE'

wire EOF_SECTOR =		(cnt_sector_time == div - 9'd1);
wire EOF_SECTOR_1 =	(cnt_sector_time == div - 9'd2); // behind 'EOF_SECTOR'

wire SEC_PART_SUBSEC =		(cnt_sector_time >= (div >> 1));
wire SEC_PART_SUBSEC_D =	(sec_part_subsec_d[3]); // delayed

wire RESET_CNT_RD = 	 (rdy | EOF_READ);
wire RESET_CNT_WR = 	 (rdy | EOF_STAGE);
wire RESET_CNT_COEF = (rdy | EOF_COEF);

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) clk_2 <= 1'b0;
	else clk_2 <= ~clk_2;
end

// *********** stage counters: *********** //

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) cnt_stage <= 4'd0;
	else if(rdy) cnt_stage <= 4'd0;
	else if(EOF_STAGE) cnt_stage <= cnt_stage + 1'b1;
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) cnt_stage_time <= 10'd0;
	else if(rdy | EOF_STAGE) cnt_stage_time <= 10'd0;
	else cnt_stage_time <= cnt_stage_time + 1'b1;
end

// *********** sector counters: *********** //

always@(posedge iCLK_2 or negedge iRESET)begin
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

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) cnt_sector <= 0;
	else if(RESET_CNT_RD | EOF_STAGE ) cnt_sector <= 0;
	else if(EOF_SECTOR) cnt_sector <= cnt_sector + 1'b1;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) cnt_sector_d <= 0;
	else cnt_sector_d <= cnt_sector;
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) cnt_sector_time <= 9'd0;
	else if(RESET_CNT_RD | EOF_SECTOR ) cnt_sector_time <= 9'd0;
	else cnt_sector_time <= cnt_sector_time + 1'b1;
end

// ************* choose addr: ************* //

wire STAGE_ODD	=	(cnt_stage[0] == 1'b1);
wire STAGE_EVEN = (cnt_stage[0] == 1'b0);

wire [A_BIT - 1 : 0] INC_ADDR_RD = (addr_rd_cnt + 1'b1);

wire signed [9 : 0] BIAS_RD = INC_ADDR_RD + (cnt_bias_rd << div_2);
wire signed [A_BIT - 1 : 0] BIAS_WR = SEC_PART_SUBSEC_D ? (addr_wr_cnt - (div >> 1)) : (addr_wr_cnt + (div >> 1));

wire NEW_BIAS_RD = ((cnt_bias_rd == -(size_bias_rd - 1'b1)) & (LAST_STAGE ? 1'b1 : (cnt_sector >= 1)));
wire CHOOSE_EN_NEW_BIAS_RD = (LAST_STAGE ? 1'b1 : EOF_SECTOR_1);

wire EN_BIAS = ~clk_2 & (cnt_sector > 1);

wire EN_BIAS_EVEN =	(EN_BIAS & (cnt_sector[0] == 0));
wire EN_BIAS_ODD =	(EN_BIAS & (cnt_sector[0] == 1));

// read:
always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) size_bias_rd <= 9'd0;
	else if(EOF_STAGE_1) size_bias_rd <= 9'd1;
	else if(CHOOSE_EN_NEW_BIAS_RD & NEW_BIAS_RD) size_bias_rd = (size_bias_rd << 1);
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) cnt_bias_rd <= 9'd0;
	else if(EOF_STAGE_1) cnt_bias_rd <= 9'd2;
	else if(CHOOSE_EN_NEW_BIAS_RD)
		begin
			if(NEW_BIAS_RD) cnt_bias_rd = size_bias_rd - 1'b1;
			else cnt_bias_rd = cnt_bias_rd - 9'd2;
		end
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) addr_rd_cnt <= 0;
	else if(RESET_CNT_RD) addr_rd_cnt <= 0;
	else addr_rd_cnt <= INC_ADDR_RD;
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) addr_rd_bias <= 0;
	else if(RESET_CNT_RD) addr_rd_bias <= 0;
	else addr_rd_bias <= BIAS_RD[7 : 0];
end

// write:
always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) sec_part_subsec_d <= 5'd0;
	else sec_part_subsec_d <= {sec_part_subsec_d[3 : 0], SEC_PART_SUBSEC};
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) addr_wr_cnt <= 0;
	else if(RESET_CNT_WR) addr_wr_cnt <= 0;
	else if(WE_EN) addr_wr_cnt <= addr_wr_cnt + 1'b1;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) addr_wr_cnt_d <= 0;
	else addr_wr_cnt_d <= addr_wr_cnt;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) addr_wr_bias <= 0;
	else if(WE_EN)
		begin
			if(ZERO_STAGE | LAST_STAGE) addr_wr_bias <= addr_wr_cnt;
			else addr_wr_bias <= BIAS_WR; // attention overflow
		end
	else addr_wr_bias <= 0;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) we_a <= 1'b0;
	else if(RESET_CNT_WR | clk_2) we_a <= 1'b0;
	else if(WE_EN & STAGE_ODD) we_a <= 1'b1;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) we_b <= 1'b0;
	else if(RESET_CNT_WR | clk_2) we_b <= 1'b0;
	else if(WE_EN & STAGE_EVEN) we_b <= 1'b1;
end

// coef:
function [A_BIT - 3 : 0] F_BIT_REV(input [A_BIT - 3 : 0] iDATA);
integer i;
	begin
		for (i = 0; i < A_BIT - 2; i = i + 1) F_BIT_REV[A_BIT - 3 - i] = iDATA[i];
	end
endfunction

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) addr_coef_cnt <= 0;
	else if(RESET_CNT_COEF) addr_coef_cnt <= 0;
	else if(EOF_SECTOR_1) addr_coef_cnt <= addr_coef_cnt + 1'b1;
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) addr_coef <= 0;
	else if(RESET_CNT_COEF) addr_coef <= 0;
	else if(COEF_EN) addr_coef <= F_BIT_REV(addr_coef_cnt);
end

// ************** others: ************** //

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) rdy <= 1'b1;
	else if(iSTART) rdy <= 1'b0;
	else if(LAST_STAGE & EOF_STAGE) rdy <= 1'b1;
end

always@(posedge iCLK_2 or negedge iRESET) begin
	if(!iRESET) source_data <= 1'b0;
	else if(rdy) source_data <= 1'b0;
	else if(EOF_STAGE) source_data <= ~source_data;
end

always@(posedge iCLK_2 or negedge iRESET)begin
	if(!iRESET) source_cont <= 1'b0;
	else if(iSTART) source_cont <= 1'b0;
	else source_cont <= rdy;
end

// ************ output ports: ************ //

assign oST_ZERO =				ZERO_STAGE; // mb required reg
assign oST_LAST = 			LAST_STAGE;
assign o2ND_PART_SUBSEC =	SEC_PART_SUBSEC_D & !ZERO_STAGE;

assign oSECTOR = cnt_sector_d;

assign oADDR_RD_0 = EN_BIAS_EVEN ?	addr_rd_bias : addr_rd_cnt;
assign oADDR_RD_1 = EN_BIAS_ODD ?	addr_rd_bias : addr_rd_cnt;
assign oADDR_RD_2 = EN_BIAS_EVEN ?	addr_rd_bias : addr_rd_cnt;
assign oADDR_RD_3 = EN_BIAS_ODD ?	addr_rd_bias : addr_rd_cnt;

assign oADDR_WR_0 = addr_wr_cnt_d;
assign oADDR_WR_1 = addr_wr_bias;
assign oADDR_WR_2 = addr_wr_cnt_d;
assign oADDR_WR_3 = addr_wr_bias;

assign oADDR_COEF = addr_coef;

assign oSOURCE_DATA = source_data;
assign oSOURCE_CONT = source_cont;

assign oWE_A = we_a;
assign oWE_B = we_b;

assign oRDY = rdy;

endmodule 