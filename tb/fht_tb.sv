`timescale 1ns/1ns
`include "../fht_defines.v"
`include "../fht_defines_tb.v"

`define N 1024
`define BANK_SIZE (`N/4) // cause Radix-4 

`ifdef TEST_MIXER
	`define NUM
`else
// choose test signal:
	// `define SIN
	// `define AUDIO // from '.wav' file 
	// `define BIAS // integer const 
	`define NUM // default test signal, numbers 0..N (function 'y = x', x > 0)
`endif

`ifdef SIN
	`undef AUDIO
	`undef BIAS
	`undef NUM
	
	// SIN spec:
		`define AMP_1 10000 // integer [`D_BIT - 2 : 0]
		`define AMP_2 5000
		`define AMP_NOISE 15000
		
		`define FREQ_D 44100
		`define FREQ_1 9000 // integer Hz
		`define FREQ_2 4500
		
		`define PHASE_1 0 // float Rad
		`define PHASE_2 0.645
		
		`define BIAS 0 // integer ~ MAX_AMP/2 if use unsigned (by default - decimal format)
`elsif AUDIO
	`undef BIAS
	`undef NUM
	
	`define AUDIO_PATH "../../fht/matlab/impulses/g.wav"
`elsif BIAS
	`undef NUM
	
	`define CONST 100
`endif

module fht_tb;

bit clk, clk_2;
bit reset;

bit [2 : 0] i;
shortint j;

real temp;

bit start;
bit ram_sel;

`ifdef SIN
	real time_s = 0;
	real noise = 0;
`endif

`ifdef NUM
	shortint k = 0;
	// shortint k = 1;
`endif
	
bit signed [`D_BIT - 2 : 0] data_adc; // '-2' because data from ADC don't have bit expansion
bit [`A_BIT - 1 : 0] addr_rd [0 : 3];
bit [`A_BIT - 1 : 0] addr_wr;
bit [3 : 0] we;

wire RDY;

import "DPI-C" function real signal(input real f, input real t, input real p);

initial begin
	$timeformat(-6, 3, " us", 6);
	clk = 1;
	forever	#(`HALF_TACT) clk = ~clk;
end

initial begin
	clk_2 = 1;
	forever	#(`TACT) clk_2 = ~clk_2;
end

initial begin
 	reset = 1'b1; #(2*`TACT);
	reset = 1'b0; #(`TACT);
	reset = 1'b1;
end

initial begin
	`ifdef TEST_MIXER
		$display("\n\n\t\t\tSTART TEST DATA MIXERS WITH CONTROL\n");
	`else
		$display("\n\n\t\t\t\tSTART TEST FHT\n");
	`endif
	
	start = 1'b0;
	
	#(10*`TACT);
	
	`ifdef SIN
		$display("\ttest signal: sine wave with next config:");
		$display("\t  amp\t=\t%6d, %6d\n\t  freq\t=\t%6d, %6d Hz\n\t  phase\t=\t%6.3f, %6.3f Rad\n\t  bias\t=\t%6d\n\t  noise\t=\t%6d\n", 
				 `AMP_1, `AMP_2, `FREQ_1, `FREQ_2, `PHASE_1, `PHASE_2, `BIAS, `AMP_NOISE);
	`elsif AUDIO
		$display("\ttest signal: audio from path - ", `AUDIO_PATH, "\n");
	`elsif BIAS
		$display("\ttest signal: const = %d\n", `CONST);
	`elsif NUM
		$display("\ttest signal: numbers (function 'y = x')\n");
	`endif
	
	$display("\twrite ADC data point in RAM, time: %t\n", $time);
	
	for(i = 0; i < 4; i = i + 1)
		for(j = 0; j < `BANK_SIZE; j = j + 1) 
			begin
				`ifdef SIN
					noise = $unsigned($random)%(`AMP_NOISE);

					temp = `BIAS + `AMP_1*(signal(`FREQ_1, time_s, `PHASE_1)) + 
								   `AMP_2*(signal(`FREQ_2, time_s, `PHASE_2)) + noise;
								   
					time_s = time_s + 1.0/`FREQ_D;
				`elsif AUDIO
				
				`elsif BIAS
					temp = `CONST;
				`elsif NUM
					temp = k;
					k = k + 1;
				`endif
				
				data_adc = temp;
				
				addr_wr = j;
				
			// save input data from ADC required bitreverse bank counter
				we[{i[0], i[1]}] = 1'b1;
					#(`TACT);
				we[{i[0], i[1]}] = 1'b0;
			end
		
	#(10*`TACT);
	
	SAVE_RAM_DATA("init_ram_a.txt", 0);
	ram_sel = 1'b1;
	
	$display("\n\tstart FHT, time: %t\n", $time);
		#1; // if "sdf" is turn off
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		#(2*`TACT);
	wait(RDY);
	$display("\n\tfinish FHT, time: %t\n", $time);
	
	#(100*`TACT);
	SAVE_RAM_DATA("ram_a.txt", 0); // name must not change, this use in matlab 'analys'
	SAVE_RAM_DATA("ram_b.txt", 1);
	
	$display("\n\t\t\t\tCOMPLETE\n");
	mti_fli::mti_Cmd("stop -sync");
end

always@(FHT.CONTROL.cnt_stage)begin
	string str_temp, str_stage;
	integer int_stage;
	
	if(!RDY)
		begin
			int_stage = FHT.CONTROL.cnt_stage;
			str_stage.itoa(int_stage);
			
			if(ram_sel == 0)
				str_temp = {"before_", str_stage, "st_ram_a.txt"};
			else if(ram_sel)
				str_temp = {"before_", str_stage, "st_ram_b.txt"};
				
			#(2*`TACT) SAVE_RAM_DATA(str_temp, ram_sel);
			ram_sel = ~ram_sel;		
		end
end

task SAVE_RAM_DATA(string name, bit ram_sel); // 0 - RAM(A), 1 - RAM(B)
	bit signed [`D_BIT - 1 : 0] buf_signed [0 : 3];
	int f_ram;
	shortint cnt_bank, cnt_data;
	
	$display("\t\tsave RAM in files: '%s', time: %t", name, $time);
	
	f_ram = $fopen(name, "w");
	
	for(cnt_data = 0; cnt_data < `BANK_SIZE; cnt_data = cnt_data + 1)
		begin
		// cycle 'for' impossible to use because expression
		// '...FHT_RAM_A.ram_bank[i].RAM_BANK...' provide to error in modelsim
		// number of bank memory must be the 'integer number', not a 'variable'
			if(ram_sel == 0)
				begin
					buf_signed[0] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					buf_signed[1] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					buf_signed[2] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					buf_signed[3] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
				end
			else if(ram_sel == 1)
				begin
					buf_signed[0] = FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					buf_signed[1] = FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					buf_signed[2] = FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
					buf_signed[3] = FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.altsyncram_component.m_non_arria10.altsyncram_inst.mem_data[cnt_data];
				end
			
			for(cnt_bank = 0; cnt_bank < 4; cnt_bank = cnt_bank + 1) 
				begin
					$fwrite(f_ram, "%d", buf_signed[cnt_bank], "\t\t");
				end
				
			$fwrite(f_ram, "\n");
		end
		
	$fclose(f_ram);
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

fht_top FHT(
	.iCLK(clk),
	.iCLK_2(clk_2),
	
	.iRESET(reset),
	
	.iSTART(start),
	
	.iDATA(data_adc),
	.iADDR_WR(addr_wr),
	
	.iWE_0(we[0]),
	.iWE_1(we[1]),
	.iWE_2(we[2]),
	.iWE_3(we[3]),	
	
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