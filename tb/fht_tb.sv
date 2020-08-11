`timescale 1ns/1ns
`include "../fht_defines.v"

package fli;
	import "DPI-C" function mti_Cmd(input string cmd);
endpackage

module fht_tb;

import fli::*;

bit clk;
bit reset;

bit flag_cp_matlab = 1; // for turn off COMPARE_MATLAB_RAM on IFHT stage

int i, j;
int cnt_er;

real temp;

bit start;
bit ram_sel;
	
bit signed [`ADC_WIDTH - 1 : 0] data_buf; // '-2' because data from ADC don't have bit expansion
bit signed [`D_BIT - 1 : 0] data_fixp;

bit signed [`ADC_WIDTH - 1 : 0] disp_data;

bit [`A_BIT - 1 : 0] addr_rd [0 : 3];
bit [`A_BIT - 1 : 0] addr_wr;
bit [3 : 0] we;

wire RDY;

function [`A_BIT - 1 : 0] F_BIT_REV(input [`A_BIT - 1 : 0] iDATA);
integer i;
	begin
		for (i = 0; i < `A_BIT; i = i + 1) F_BIT_REV[`A_BIT - 1 - i] = iDATA[i];
	end
endfunction

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
	int file_data, scan_data, temp_data[4];
	
	`ifdef TEST_MIXER
		$display("\n\n\t\t\tSTART TEST DATA MIXERS WITH CONTROL\n");
	`else
		$display("\n\n\t\t\t\tSTART TEST FHT\n");
	`endif
	
	`ifdef COMPARE_WITH_MATLAB
		$display("\t\tRAM compare with 'txt' file from matlab");
	`endif
	
	ram_sel = 1'b1;
	start = 1'b0;
	
	#(10*`TACT);

// save ADC data line by line (row by row):	
	$display("\twrite ADC data point in RAM, time: %t\n", $time);
	file_data = $fopen("../../fht/matlab/init_ram.txt", "r");
	disp_data = 0;
	
	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			scan_data = $fscanf(file_data, "%d\t%d\t%d\t%d\n", temp_data[0], temp_data[1], temp_data[2], temp_data[3]);
			
			disp_data = temp_data[0];
			
			for(i = 0; i < 4; i = i + 1)
				begin
					data_buf = temp_data[i];
					data_fixp = {data_buf[`ADC_WIDTH - 1], data_buf, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					
					addr_wr = j;
					
				// save input data from ADC require bitreverse bank counter
					we[i] = 1'b1;
						#(`TACT);
					we[i] = 1'b0;
				end
		end
		
	disp_data = 0;
	$fclose(file_data);
	
	#(10*`TACT);
	
// init data always saving in A RAM from external module	
	SAVE_RAM_DATA("init_ram_a.txt", 0);
	
	$display("\n\tstart FHT, time: %t\n", $time);
		// #1; // if "sdf" is turn off
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		#(`TACT);

	wait(RDY);
	$display("\n\tfinish FHT, time: %t\n", $time);
	
	$display("\n\t\t\tpress 'run' to continue\n");
	void'(mti_Cmd("stop -sync"));
	
	`ifdef LAST_STAGE_ODD
		SAVE_RAM_DATA("ram_a.txt", 0);
		`ifdef COMPARE_WITH_MATLAB
			COMPARE_MATLAB_RAM("../../fht/matlab/ram.txt", "ram_a.txt");
		`endif
	`elsif LAST_STAGE_EVEN
		SAVE_RAM_DATA("ram_b.txt", 1);
		`ifdef COMPARE_WITH_MATLAB
			COMPARE_MATLAB_RAM("../../fht/matlab/ram.txt", "ram_b.txt");
		`endif
	`endif
	
	$display("\n\t\t\t\tCOMPLETE\n");
	void'(mti_Cmd("stop -sync"));
	
// IFHT:
	#(`TACT);
	$display("\tRewrite RAM data from bit rev to norm order for IFHT, time: %t\n", $time);
	BIT_REV_TO_NORM(0);

	$display("\n\tstart IFHT, time: %t\n", $time);
	flag_cp_matlab = 0;
	
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		#(`TACT);

	wait(RDY);
	$display("\tfinish IFHT, time: %t\n", $time);
	
	BIT_REV_TO_NORM(1);
	
	`ifdef LAST_STAGE_ODD
		SAVE_RAM_DATA("ram_ia.txt", 0);
	`elsif LAST_STAGE_EVEN
		SAVE_RAM_DATA("ram_ib.txt", 1);
	`endif
	
	$display("\n\t\t\t\tCOMPLETE\n");
	void'(mti_Cmd("stop -sync"));
end

always@(FHT.CONTROL.cnt_stage)begin
	string str_temp, str_temp_ref;
	string str_stage;
	integer int_stage;
	
	if(!RDY & flag_cp_matlab)
		begin
			$display("\n\t\t\t\t%2d stage FHT\n", FHT.CONTROL.cnt_stage);
			
			int_stage = FHT.CONTROL.cnt_stage;
			str_stage.itoa(int_stage);
			
			if(~ram_sel)
				str_temp = {"before_", str_stage, "st_ram_a.txt"};
			else
				str_temp = {"before_", str_stage, "st_ram_b.txt"};
				
			#(2*`TACT) SAVE_RAM_DATA(str_temp, ram_sel);
			ram_sel = ~ram_sel;
			
			`ifdef COMPARE_WITH_MATLAB
				str_temp_ref = {"../../fht/matlab/before_", str_stage, "st_ram.txt"};
				COMPARE_MATLAB_RAM(str_temp_ref, str_temp);
			`endif
	
			$display("\n\t\t\tpress 'run' to continue\n");
			void'(mti_Cmd("stop -sync"));
		end
end

task SAVE_RAM_DATA(string name, bit ram_sel); // 0 - RAM(A), 1 - RAM(B)
	bit signed [`D_BIT - 1 : 0] buf_signed [0 : 3];
	int f_ram;
	shortint cnt_bank, cnt_data;
	
	$display("\tsave RAM in files: '%s'\n", name);
	
	f_ram = $fopen(name, "w");
	
	for(cnt_data = 0; cnt_data < `BANK_SIZE; cnt_data = cnt_data + 1)
		begin
		// cycle 'for' impossible to use because expression
		// '...FHT_RAM_A.ram_bank[i].RAM_BANK...' provide to error in modelsim
		// number of bank memory must be the 'integer number', not a 'variable'
			if(ram_sel == 0)
				begin
					`ifdef RAM_BUG
						buf_signed[0] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.altsyncram_component.mem_data[cnt_data];
						buf_signed[1] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.altsyncram_component.mem_data[cnt_data];
						buf_signed[2] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.altsyncram_component.mem_data[cnt_data];
						buf_signed[3] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.altsyncram_component.mem_data[cnt_data];
					`else
						buf_signed[0] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
						buf_signed[1] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
						buf_signed[2] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
						buf_signed[3] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					`endif
				end
			else if(ram_sel == 1)
				begin
					`ifdef RAM_BUG
						buf_signed[0] = FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.altsyncram_component.mem_data[cnt_data];
						buf_signed[1] = FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.altsyncram_component.mem_data[cnt_data];
						buf_signed[2] = FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.altsyncram_component.mem_data[cnt_data];
						buf_signed[3] = FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.altsyncram_component.mem_data[cnt_data];
					`else
						buf_signed[0] = FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
						buf_signed[1] = FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
						buf_signed[2] = FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
						buf_signed[3] = FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					`endif
				end
			
			for(cnt_bank = 0; cnt_bank < 4; cnt_bank = cnt_bank + 1) 
				begin
					$fwrite(f_ram, "%d", buf_signed[cnt_bank], "\t\t");
				end
				
			$fwrite(f_ram, "\n");
		end
		
	$fclose(f_ram);
endtask

task COMPARE_MATLAB_RAM(input string name_ref, name);
	int file_ref, file;
	int temp_ref [4];
	int temp [4];
	int scan [2];
	
	file_ref =	$fopen(name_ref, "r");
	file = 		$fopen(name, "r");
	
	for(j = 0; j < `BANK_SIZE; j = j + 1)
		begin
			scan[0] = $fscanf(file_ref, "%d\t%d\t%d\t%d\n", temp_ref[0], temp_ref[1], temp_ref[2], temp_ref[3]);
			scan[1] = $fscanf(file, "%d\t%d\t%d\t%d\n", temp[0], temp[1], temp[2], temp[3]);

			if((temp_ref[0] == temp[0]) & (temp_ref[1] == temp[1]) &
			   (temp_ref[2] == temp[2]) & (temp_ref[3] == temp[3]))
				$display("\tLine %3d: data_0: %4d, data_1: %4d, data_2: %4d, data_3: %4d", 
							j, temp[0], temp[1], temp[2], temp[3]);
			else
				begin
					cnt_er = cnt_er + 1;
					$display(" ***\tLine %3d: data_0: %4d, data_1: %4d, data_2: %4d, data_3: %4d", 
								j, temp[0], temp[1], temp[2], temp[3]);
					$display(" ***\t     REF: data_0: %4d, data_1: %4d, data_2: %4d, data_3: %4d", 
								temp_ref[0], temp_ref[1], temp_ref[2], temp_ref[3]);
				end			
		end
	
	$display("\n\tnumber of errors compare RAM with matlab in this stage: %4d, time: %t", cnt_er, $time);
	cnt_er = 0;
endtask

task BIT_REV_TO_NORM(input bit iSIG); // choose signal type: FHT (0) or signal after IFHT (1)
	int temp_data[4];
	bit signed [`D_BIT - 1 : 0] data_ext_buf;
	
// buf RAM for transmit data from bit rev order to norm before start IFHT:
	logic signed [`D_BIT - 1 : 0] ram_buf_0 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_1 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_2 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_3 [0 : `BANK_SIZE - 1];
	
	bit [`A_BIT - 1 : 0] cnt_rev;

	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			`ifdef LAST_STAGE_ODD
				`ifdef RAM_BUG
					ram_buf_0[j] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.altsyncram_component.mem_data[j];
					ram_buf_1[j] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.altsyncram_component.mem_data[j];
					ram_buf_2[j] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.altsyncram_component.mem_data[j];
					ram_buf_3[j] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.altsyncram_component.mem_data[j];
				`else
					ram_buf_0[j] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
					ram_buf_1[j] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
					ram_buf_2[j] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
					ram_buf_3[j] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
				`endif
			`elsif LAST_STAGE_EVEN
				`ifdef RAM_BUG
					ram_buf_0[j] = FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.altsyncram_component.mem_data[j];
					ram_buf_1[j] = FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.altsyncram_component.mem_data[j];
					ram_buf_2[j] = FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.altsyncram_component.mem_data[j];
					ram_buf_3[j] = FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.altsyncram_component.mem_data[j];
				`else
					ram_buf_0[j] = FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
					ram_buf_1[j] = FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
					ram_buf_2[j] = FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
					ram_buf_3[j] = FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[j];
				`endif
			`endif
		end	

	cnt_rev = 0;
	
	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			if(iSIG)
				begin
					temp_data[0] = ram_buf_0[F_BIT_REV(cnt_rev)] << (`LAST_STAGE + 1);
					temp_data[1] = ram_buf_1[F_BIT_REV(cnt_rev)] << (`LAST_STAGE + 1);
					temp_data[2] = ram_buf_2[F_BIT_REV(cnt_rev)] << (`LAST_STAGE + 1);
					temp_data[3] = ram_buf_3[F_BIT_REV(cnt_rev)] << (`LAST_STAGE + 1);
					
					data_ext_buf = temp_data[0];
					disp_data = data_ext_buf[`D_BIT - 1 : `D_BIT - `ADC_WIDTH];
				end
			else
				begin
					temp_data[0] = ram_buf_0[F_BIT_REV(cnt_rev)];
					temp_data[1] = ram_buf_1[F_BIT_REV(cnt_rev)];
					temp_data[2] = ram_buf_2[F_BIT_REV(cnt_rev)];
					temp_data[3] = ram_buf_3[F_BIT_REV(cnt_rev)];
				end
				
			for(i = 0; i < 4; i = i + 1)
				begin
					data_fixp = temp_data[i];
					addr_wr = j;
					
					we[i] = 1'b1;
						#(`TACT);
					we[i] = 1'b0;
				end
				
			cnt_rev = cnt_rev + 1;
		end
		
	disp_data = 0;
endtask

/*
real f, t, h_t; //frequency, time, time step 
real fmin,fmax,h; //minimum frequency, maximum frequency, frequency step
real out;

initial begin

	fmin = 50_000; //Hz
	fmax = 1_000_000; //Hz
	h = 1_000; //Hz
	h_t = 0.000_000_01; //step time = 1/(time scale) (sec)
	
	for (f = fmin; f <= fmax; f = f + h) begin
		for (t = 0; t <= 1/f; t = t + h_t) begin
			#10 out = signal(f,t);
			//$display (signal(f,t));			
		end
	end
end
*/

/*
package math_pkg;
  // import dpi task      C Name = SV function name
  import "DPI" pure function real cos (input real rTheta);
  import "DPI" pure function real sin (input real rTheta);
  import "DPI" pure function real log (input real rVal);
  import "DPI" pure function real log10 (input real rVal);
endpackage : math_pkg

function real GET_SIN(input real time_s);
  import math_pkg::*;
  
  GET_SIN = `OFFSET + (`AMPL * sin(2*`PI*`FREQ*time_s));
endfunction
*/

fht_top #(.D_BIT(`D_BIT), .A_BIT(`A_BIT), .W_BIT(`W_BIT), 
			.MIF_SIN(`MIF_SIN), .MIF_COS(`MIF_COS)) FHT(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.iWE(we),
	.iDATA(data_fixp),
	.iADDR_WR(addr_wr),
	
	.iADDR_RD_0(addr_rd[0]),
	.iADDR_RD_1(addr_rd[1]),
	.iADDR_RD_2(addr_rd[2]),
	.iADDR_RD_3(addr_rd[3]),
	
	.oDATA_0(),
	.oDATA_1(),
	.oDATA_2(),
	.oDATA_3(),
	
	.oRDY(RDY)
);

endmodule