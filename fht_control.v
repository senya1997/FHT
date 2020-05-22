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

reg [3 : 0] stage_num; // = log(N)/log(2) - 1
reg [8 : 0] sector_num;
reg [8 : 0] subsector_num;

reg [9 : 0] cnt_stage_time; // length of bank RAM * 2 (because butterfly performed in 2 tact) + reserve (for wait time end of writing in RAM)

reg [7 : 0] div;

reg [A_BIT - 1 : 0] addr_rd;
reg [A_BIT - 1 : 0] addr_rd_bias;

reg [A_BIT - 1 : 0] addr_wr;
reg [A_BIT - 1 : 0] addr_wr_bias;

reg [A_BIT - 1 : 0] addr_coef;

reg we_a;
reg we_b;

reg rdy;

wire EOF_STAGE = (cnt_stage_time == 8'd511);

wire LAST_STAGE = (stage_num == 4'd10);

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET) cnt_stage_time <= 9'd0;
	else if(!rdy) cnt_stage_time <= cnt_stage_time + 1'b1;
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