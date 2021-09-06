`timescale 1ns/1ns
`include "../fht_defines.v"

package fli;
	import "DPI-C" function mti_Cmd(input string cmd);
endpackage

module fht_control_tb;

import fli::*;

reg clk;
reg reset;

reg start;

wire [`A_BIT - 1 : 0] ADDR_RD [0 : 3];
wire [`A_BIT - 1 : 0] ADDR_WR [0 : 3];
wire [`A_BIT - 1 : 0] ADDR_COEF;

int f_addr_rd, f_addr_wr;
int cnt_er_rd, cnt_er_wr;
int cnt_er;

string str_temp;

wire WE_A, WE_B;
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
	
	cnt_er_rd = 0;
	cnt_er_wr = 0;
	cnt_er = 0;
	
	#(100*`TACT);
	$display("\n\n\t\t\tSTART TEST CONTROL FHT\n");
	
	`ifdef COMPARE_WITH_MATLAB
		$display("\tread and write address compare with 'txt' file from matlab");
		$display("\terror marking by '***', r/w = 0 => addr_rd, r/w = 1 => addr_wr\n");
	`endif
	
	f_addr_rd = $fopen(`MATLAB_ADDR_RD, "r");
	f_addr_wr = $fopen(`MATLAB_ADDR_WR, "r");
	
		// #1; // if "sdf" is turn off
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		// #(`TACT - 1);
		
	wait(!RDY);	
	$display("\t 0 stage FHT, time: %t\n", $time);
	
// wait the end of conversion:
	wait(RDY);
	$fclose(f_addr_rd);
	$fclose(f_addr_wr);
	
	`ifdef COMPARE_WITH_MATLAB
		$display("\n\t\tnumber of errors in addr_rd this stage: %d", cnt_er_rd);
		$display("\t\tnumber of errors in addr_wr this stage: %d\n", cnt_er_wr);
			cnt_er_rd = 0;
			cnt_er_wr = 0;
	
		$display("\n\t\ttotal amount of errors: %d", cnt_er);
	`endif
	
	#(100*`TACT);
	$display("\n\t\t\tCOMPLETE\n");
	void'(mti_Cmd("stop -sync"));
end

`ifdef COMPARE_WITH_MATLAB
	always@(posedge clk)begin
		if(!RDY & (CONTROL.cnt_stage_time < `BANK_SIZE))
			COMPARE_MATLAB_ADDR(f_addr_rd, 0, ADDR_RD[0], ADDR_RD[1], ADDR_RD[2], ADDR_RD[3]);
	end

	always@(posedge CONTROL.clk_2)begin
		if(!RDY & (WE_A | WE_B))
			COMPARE_MATLAB_ADDR(f_addr_wr, 1, ADDR_WR[0], ADDR_WR[1], ADDR_WR[2], ADDR_WR[3]);
	end
`endif
	
always@(CONTROL.cnt_stage)begin
	if(!RDY)
		begin
			`ifdef COMPARE_WITH_MATLAB
				$display("\n\t\tnumber of errors in addr_rd this stage: %d", cnt_er_rd);
				$display("\t\tnumber of errors in addr_wr this stage: %d\n", cnt_er_wr);
					cnt_er_rd = 0;
					cnt_er_wr = 0;
			`endif
			
			`ifdef EN_BREAKPOINT
				$display("\n\t\t\tpress 'run' to continue\n");
				void'(mti_Cmd("stop -sync"));
			`endif
			
			$display("\n\t%2d stage FHT, time: %t\n", CONTROL.cnt_stage, $time);
		end
end

task COMPARE_MATLAB_ADDR(
	input int file,
	
	input bit rd_wr, // '0' - addr_rd, '1' - addr_wr
	
	input [`A_BIT - 1 : 0] iADDR_0,
	input [`A_BIT - 1 : 0] iADDR_1,
	input [`A_BIT - 1 : 0] iADDR_2,
	input [`A_BIT - 1 : 0] iADDR_3
);
	int temp_ref [4];
	int temp;

	temp = $fscanf(file, "%d\t%d\t%d\t%d\n", temp_ref[0], temp_ref[1], temp_ref[2], temp_ref[3]);
			
	if((temp_ref[0] == iADDR_0) & (temp_ref[1] == iADDR_1) & 
	   (temp_ref[2] == iADDR_2) & (temp_ref[3] == iADDR_3))
		$display("\t\tr/w: %1d, addr_0: %4d, addr_1: %4d, addr_2: %4d, addr_3: %4d, time: %t", 
					rd_wr, iADDR_0, iADDR_1, iADDR_2, iADDR_3, $time);
	else
		begin
			if(rd_wr) cnt_er_wr = cnt_er_wr + 1;
			else cnt_er_rd = cnt_er_rd + 1;
			
			cnt_er = cnt_er + 1;
			
			$display(" ***\tREF:\tr/w: %1d,\taddr_0: %4d, addr_1: %4d, addr_2: %4d, addr_3: %4d, time: %t", 
									rd_wr, temp_ref[0], temp_ref[1], temp_ref[2], temp_ref[3], $time);
			$display(" ***\t\t\taddr_0: %4d, addr_1: %4d, addr_2: %4d, addr_3: %4d", 
									iADDR_0, iADDR_1, iADDR_2, iADDR_3);
		end
endtask

fht_control #(.A_BIT(`A_BIT)) CONTROL(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.oST_ZERO(), 
	.oST_LAST(),
	.o2ND_PART_SUBSEC(),
	.oSECTOR(), 
	
	.oADDR_RD_0(ADDR_RD[0]),
	.oADDR_RD_1(ADDR_RD[1]),
	.oADDR_RD_2(ADDR_RD[2]),
	.oADDR_RD_3(ADDR_RD[3]),
	
	.oADDR_WR_0(ADDR_WR[0]),
	.oADDR_WR_1(ADDR_WR[1]),
	.oADDR_WR_2(ADDR_WR[2]),
	.oADDR_WR_3(ADDR_WR[3]),
	
	.oADDR_COEF(),
	
	.oWE_A(WE_A),
	.oWE_B(WE_B),
	
	.oSOURCE_DATA(),
	.oSOURCE_CONT(),
	
	.oRDY(RDY)
);

endmodule