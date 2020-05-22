`timescale 1ns/1ns
`include "../fht_defines.v"
`include "../fht_defines_tb.v" 

module fht_control_tb;
 
reg clk;
reg reset;

reg start;

wire [`A_BIT - 1 : 0] ADDR_RD_DUT [0 : 3];
wire [`A_BIT - 1 : 0] ADDR_WR_DUT;
wire [`A_BIT - 1 : 0] ADDR_COEF;

int f_addr_rd;

// wire WE_A,
// wire WE_B,

// wire SOURCE_DATA,
// wire SOURCE_CONT,
	
wire RDY;

initial begin
	$timeformat(-6, 3, " us", 6);
	clk = 1;
	forever	#(`HALF_TACT) clk = ~clk;
end

initial begin
	reset = 1'b1; #(2*`TACT);
	reset = 1'b0; #(`TACT);
	reset = 1'b1;
end

initial begin
	start = 1'b0;
	
	#(100*`TACT);
	$display("\n\n\t\t\tSTART TEST CONTROL FHT\n");
	$display("\t\t'addr_rd' save like array in 'txt' file\n");
	
		//#1; // if "sdf" is turn off
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		
	$display("\t0 stage FFT, time: %t", $time);
	
	f_addr_rd = $fopen("addr_rd.txt", "w");
	$fwrite(f_addr_rd, "\t\tSTAGE: 0\n");
	$fclose(f_addr_rd);
	
	while(!RDY);
	
	#(100*`TACT);
		
	// $display("\n\t\t\t\tCOMPLETE\n");
	// mti_fli::mti_Cmd("stop -sync");
end

always@(CONTROL.stage_num)begin
	if(!RDY)
		begin
			$display("\t%d stage FHT, time: %t", CONTROL.stage_num, $time);
			
			f_addr_rd = $fopen("addr_rd.txt", "a");
			$fwrite(f_addr_rd, "\t\tSTAGE: %d\n", CONTROL.stage_num);
			$fclose(f_addr_rd);
		end
end

always@(posedge clk)begin
	if(!RDY & (CONTROL.cnt_stage_time <= 512))
		begin
			#(`TACT);
			
			f_addr_rd = $fopen("addr_rd.txt", "a");
			$fwrite(f_addr_rd, "%d\t%d\t%d\t%d\n", ADDR_RD_DUT[0], ADDR_RD_DUT[1], ADDR_RD_DUT[2], ADDR_RD_DUT[3]);
			$fclose(f_addr_rd);
		end
end

fht_control CONTROL(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.oST_ZERO(), 
	.oST_LAST(),
	.o2ND_PART_SUBSECTOR(),
	.oSECTOR(), 
	
	.oADDR_RD_0(),
	.oADDR_RD_1(),
	.oADDR_RD_2(),
	.oADDR_RD_3(),
	
	.oADDR_WR(),
	.oADDR_WR_BIAS(),
	
	.oADDR_COEF(),
	
	.oWE_A(),
	.oWE_B(),
	
	.oRDY(RDY)
);

endmodule