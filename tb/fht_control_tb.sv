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

int addr_rd_file;
int addr_rd_bias_file;

string str_temp;

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
	$display("\n\n\t\t\t\tSTART TEST CONTROL FHT\n");
	$display("\t'addr_rd' compare with 'txt' file from matlab, error marking by '***'\n");
	
		#1; // if "sdf" is turn off
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
	
	wait(!RDY);	
	$display("\t 0 stage FHT, time: %t", $time);
	
	// open and 1st read matlab file:
	f_addr_rd = $fopen("D:/SS/fpga/fht/matlab/addr_rd.txt", "r");
	$fscanf (f_addr_rd, "%4d\t%4d\n", addr_rd_file, addr_rd_bias_file);
	if((addr_rd_file == CONTROL.addr_rd) & (addr_rd_bias_file == CONTROL.addr_rd_bias))
		$display("\t\taddr_rd: %4d, addr_rd_bias: %4d, time: %t", 
					CONTROL.addr_rd, CONTROL.addr_rd_bias, $time);
	else
		$display(" ***\tREF:\taddr_rd: %4d, addr_rd_bias: %4d, time: %t\n ***\t\taddr_rd: %4d, addr_rd_bias: %4d", 
					addr_rd_file, addr_rd_bias_file, $time, CONTROL.addr_rd, CONTROL.addr_rd_bias);
	
	// wait end conversion:
	wait(RDY);
	
	$fclose(f_addr_rd);
	#(100*`TACT);
	$display("\n\t\t\tCOMPLETE\n");
	mti_fli::mti_Cmd("stop -sync");
end

always@(CONTROL.addr_rd or negedge CONTROL.EOF_READ)begin
	if(!RDY & !CONTROL.EOF_READ)
		begin
			$fscanf (f_addr_rd, "%4d\t%4d\n", addr_rd_file, addr_rd_bias_file);
			
			if((addr_rd_file == CONTROL.addr_rd) & (addr_rd_bias_file == CONTROL.addr_rd_bias))
				$display("\t\taddr_rd: %4d, addr_rd_bias: %4d, time: %t", 
							CONTROL.addr_rd, CONTROL.addr_rd_bias, $time);
			else
				$display(" ***\tREF:\taddr_rd: %4d, addr_rd_bias: %4d, time: %t\n ***\t\taddr_rd: %4d, addr_rd_bias: %4d", 
							addr_rd_file, addr_rd_bias_file, $time, CONTROL.addr_rd, CONTROL.addr_rd_bias);
		end
end

always@(CONTROL.stage)begin
	if(!RDY)
		begin
			$display("\n\t\tpress 'run' to continue\n");
			$stop;
			$display("\n\t%2d stage FHT, time: %t", CONTROL.stage, $time);
		end
end

fht_control CONTROL(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.oST_ZERO(), 
	.oST_LAST(),
	.o2ND_PART_SUBSEC(),
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
	
	.oSOURCE_DATA(),
	.oSOURCE_CONT(),
	
	.oRDY(RDY)
);

endmodule