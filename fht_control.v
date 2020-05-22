module fht_control #(parameter A_BIT = 8, SEC_BIT = 4)(
	input iCLK,
	input iRESET,
	
	input iSTART,
	
	output oST_ZERO, // "0" stage - without multipliers
	output oST_LAST, // on last stage output bank mixer save data in direct order
	output o2ND_PART_SUBSECTOR, // on 1st and 2nd part of subsector point save in different bank order on output bank mixer
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
	
	output oRDY
);

reg [3 : 0] stage; // = log(N)/log(2) - 1
reg [8 : 0] div;
reg [8 : 0] sector;
reg [] subsector_size;

reg [9 : 0] cnt_stage_time; // length of bank RAM * 2 (because butterfly performed in 2 tact) + reserve (for wait time end of writing in RAM)
reg [] cnt_sector_time;
reg [] cnt_subsector_time;

reg [A_BIT - 1 : 0] addr_rd;
reg [A_BIT - 1 : 0] addr_rd_bias;

reg [A_BIT - 1 : 0] addr_wr;
reg [A_BIT - 1 : 0] addr_wr_bias;

reg [A_BIT - 1 : 0] addr_coef;

reg we_a;
reg we_b;

reg rdy;

wire EOF_STAGE = (cnt_stage_time == 10'd517);

wire AFTER_ZERO_STAGE = (stage > 4'd0);
wire LAST_STAGE = (stage == 4'd10);

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET)
		begin
			div <= 8'128; // required to add in defines div = N/(2*N_bank)
			sector <= 9'd1;
		end
	else if(rdy) 
		begin
			div <= 8'd128;
			sector <= 9'd1;
		end
	else if(EOF_STAGE & AFTER_ZERO_STAGE) 
		begin
			div <= (div >> 1);
			sector <= (sector << 1);
		end
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) stage <= 4'd0;
	else if(rdy) stage <= 4'd0;
	else if(EOF_STAGE) stage <= stage + 1'b1;
end

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) cnt_stage_time <= 10'd0;
	else if(!rdy) 
		begin
			if(EOF_STAGE) cnt_stage_time <= 10'd0;
			else cnt_stage_time <= cnt_stage_time + 1'b1;
		end
	else cnt_stage_time <= 10'd0;
end

/*
always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET)
		begin
			addr_rd <= 0;
			addr_rd_bias <= 0;
		end
	else if()
	
end
*/

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) rdy <= 1'b1;
	else if(iSTART) rdy <= 1'b0;
	else if(LAST_STAGE & EOF_STAGE) rdy <= 1'b1;
end

endmodule 