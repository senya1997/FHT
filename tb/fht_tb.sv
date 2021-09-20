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

bit start;
bit ram_sel;
	
bit signed [`ADC_WIDTH - 1 : 0] data_buf; // '-2' because data from ADC don't have bit expansion
bit signed [`D_BIT - 1 : 0] data_fixp;

bit signed [`ADC_WIDTH - 1 : 0] disp_data;

bit [`A_BIT - 1 : 0] addr_rd [0 : 3];
bit [`A_BIT - 1 : 0] addr_wr;
bit [3 : 0] we;

wire RDY_FHT, RDY_IFHT;

int i, j;
int cnt_all_er; // counters of stage and all errors

real temp;
real max_er, av_er; // max and avarage error

function [`A_BIT - 1 : 0] F_BIT_REV(input [`A_BIT - 1 : 0] iDATA);
integer i;
	begin
		for (i = 0; i < `A_BIT; i = i + 1) F_BIT_REV[`A_BIT - 1 - i] = iDATA[i];
	end
endfunction

// convert from type 'reg' with fixed point to 'real':
function real F_REG_TO_REAL(input bit signed [`D_BIT - 1 : 0] iDATA);
	bit signed [`ADC_WIDTH - 1 : 0] data_int;
	real temp;
	shortint k;
begin
	temp = 0;
	for (k = 0; k < (`D_BIT - `ADC_WIDTH); k = k + 1) 
		temp = temp + iDATA[`D_BIT - `ADC_WIDTH -(k+1)]*1.0/(2**(k+1));
	
	data_int = iDATA[`D_BIT - 1 : `D_BIT - `ADC_WIDTH];
	F_REG_TO_REAL = data_int + temp;
end
endfunction

function real F_ABS(input real data);
	if(data < 0) F_ABS = -data;
	else F_ABS = data;
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
	int file_data, scan_data;
	int temp_data[4];
	
// buf RAM for transmit data from bit rev order to norm before start IFHT:
	logic signed [`D_BIT - 1 : 0] ram_buf_0 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_1 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_2 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_3 [0 : `BANK_SIZE - 1];
	
	logic signed [`D_BIT - 1 : 0] ram_buf_0_ext [0 : `BANK_SIZE - 1];
	
	bit [`A_BIT - 1 : 0] cnt_rev;
	
	`ifdef TEST_MIXER
		$display("\n\n\t\t\tSTART TEST DATA MIXERS WITH CONTROL\n");
	`else
		$display("\n\n\t\t\t\tSTART TEST FHT\n");
	`endif
	
	$display("\terror between reference signal and result must be less then `ACCURACY defines: %6.6f", `ACCURACY);
	$display("\tif error too big - in console its marked by '***'");
	
	`ifdef COMPARE_WITH_MATLAB
		$display("\n\tRAM compare with 'txt' file from matlab");
	`endif
	
	cnt_all_er = 0;
	max_er = 0;
	av_er = 0;
	
	ram_sel = 1'b1;
	start = 1'b0;
	
	#(10*`TACT);

// save ADC data line by line (row by row):	
	$display("\n\twrite ADC data point in RAM, time: %t\n", $time);
	file_data = $fopen(`INIT_FHT_RAM, "r");
	disp_data = 0;
	
	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			scan_data = $fscanf(file_data, "%f\t%f\t%f\t%f\n", temp_data[0], temp_data[1], temp_data[2], temp_data[3]);
			
			disp_data = temp_data[0];
			
			for(i = 0; i < 4; i = i + 1)
				begin
					data_buf = temp_data[i];
					data_fixp = {data_buf, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					
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

	wait(RDY_FHT);
	#(`TACT);
	
	$display("\n\tfinish FHT, time: %t\n", $time);
	
	`ifdef EN_BREAKPOINT
		$display("\n\t\t\tpress 'run' to continue\n");
		void'(mti_Cmd("stop -sync"));
	`endif
	
	`ifdef LAST_STAGE_ODD
		SAVE_RAM_DATA(`FPGA_FHT_RAM, 0);
		`ifdef COMPARE_WITH_MATLAB
			COMPARE_MATLAB_RAM(`MATH_FHT_RAM, `FPGA_FHT_RAM);
		`endif
	`elsif LAST_STAGE_EVEN
		SAVE_RAM_DATA(`FPGA_FHT_RAM, 1);
		`ifdef COMPARE_WITH_MATLAB
			COMPARE_MATLAB_RAM(`MATH_FHT_RAM, `FPGA_FHT_RAM);
		`endif
	`endif
	
	`ifdef COMPARE_WITH_MATLAB
		$display("\n\tmax error (compared RAM with matlab) in all transfer: %6.6f", max_er);
		
		if(cnt_all_er == 0) $display("\tavarage error in all transfer: 0.000000\n");
		else $display("\tavarage error in all transfer: %6.6f\n", av_er/cnt_all_er);
		
		$display("\ttotal amount of errors: %d", cnt_all_er);
	`endif
	
	`ifdef EN_BREAKPOINT
		$display("\n\t\t\tpress 'run' to continue");
		void'(mti_Cmd("stop -sync"));
	`endif
	
// IFHT:
	#(`TACT);
	$display("\n\tRewrite RAM data from bit rev to norm order for IFHT, time: %t\n", $time);
	
	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			`ifdef LAST_STAGE_ODD
				ram_buf_0[j] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_1[j] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_2[j] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_3[j] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB[j];
			`elsif LAST_STAGE_EVEN
				ram_buf_0[j] = FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_1[j] = FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_2[j] = FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB[j];
				ram_buf_3[j] = FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB[j];
			`endif
		end	

	cnt_rev = 0;
	
	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			temp_data[0] = ram_buf_0[F_BIT_REV(cnt_rev)];
			temp_data[1] = ram_buf_1[F_BIT_REV(cnt_rev)];
			temp_data[2] = ram_buf_2[F_BIT_REV(cnt_rev)];
			temp_data[3] = ram_buf_3[F_BIT_REV(cnt_rev)];
				
			//$display("\tLine %3d:\tdata_0: %6.6f,\t\t\t\tdata_1: %6.6f,\t\t\t\tdata_2: %6.6f,\t\t\t\tdata_3: %6.6f", 
			//				j, F_REG_TO_REAL(temp_data[0]), F_REG_TO_REAL(temp_data[1]), F_REG_TO_REAL(temp_data[2]), F_REG_TO_REAL(temp_data[3]));
				
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
	
	$display("\n\tstart IFHT, time: %t\n", $time);
	flag_cp_matlab = 0;
	
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		#(`TACT);

	wait(RDY_IFHT);
	$display("\tfinish IFHT, time: %t\n", $time);
	
	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			`ifdef LAST_STAGE_ODD
				ram_buf_0_ext[j] = IFHT.FHT_RAM_A.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB[j];
			`elsif LAST_STAGE_EVEN
				ram_buf_0_ext[j] = IFHT.FHT_RAM_B.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB[j];
			`endif
		end	

	cnt_rev = 0;
	
	for(j = 0; j < `BANK_SIZE; j = j + 1) 
		begin
			disp_data = ram_buf_0_ext[F_BIT_REV(cnt_rev)][`ADC_WIDTH - 1 : 0]; // width of 'disp_data' => cut RAM data ? 
			cnt_rev = cnt_rev + 1;
			
			#(4*`TACT);
		end
		
	disp_data = 0;
	
	$display("\n\t\t\t\tCOMPLETE\n");
	void'(mti_Cmd("stop -sync"));
end

always@(FHT.CONTROL.cnt_stage)begin
	string str_temp, str_temp_ref;
	string str_stage;
	integer int_stage;
	
	if(!RDY_FHT & flag_cp_matlab)
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
	
			`ifdef EN_BREAKPOINT
				$display("\n\t\t\tpress 'run' to continue\n");
				void'(mti_Cmd("stop -sync"));
			`endif
		end
end

task SAVE_RAM_DATA(string name, bit ram_sel); // 0 - RAM(A), 1 - RAM(B)
	bit signed [`D_BIT - 1 : 0] buf_signed [0 : 3];
	
	string str_temp;
	
	int f_ram, f_ram_reg;
	shortint cnt_bank, cnt_data;
	
	$display("\tsave RAM in files: '%s', time: %t\n", name, $time);
	
	str_temp = {"reg_", name};
	
	f_ram = $fopen(name, "w");
	f_ram_reg = $fopen(str_temp, "w"); // data for convolution
	
	for(cnt_data = 0; cnt_data < `BANK_SIZE; cnt_data = cnt_data + 1)
		begin
		// cycle 'for' impossible to use because expression
		// '...FHT_RAM_A.ram_bank[i].RAM_BANK...' provide to error in modelsim
		// number of bank memory must be the 'integer number', not a 'variable'
			if(ram_sel == 0)
				begin
					buf_signed[0] = FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
					buf_signed[1] = FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
					buf_signed[2] = FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
					buf_signed[3] = FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
				end
			else if(ram_sel == 1)
				begin
					buf_signed[0] = FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
					buf_signed[1] = FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
					buf_signed[2] = FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
					buf_signed[3] = FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB[cnt_data];
				end
			
			for(cnt_bank = 0; cnt_bank < 4; cnt_bank = cnt_bank + 1) 
				begin
					// $fwrite(f_ram, "%6.6f", F_REG_TO_REAL(buf_signed[cnt_bank]), "\t\t");
					$fwrite(f_ram, "%6.6f", F_REG_TO_REAL(buf_signed[cnt_bank]), "\t");
					$fwrite(f_ram_reg, "%d", buf_signed[cnt_bank], "\t");
				end
				
			$fwrite(f_ram, "\n");
			$fwrite(f_ram_reg, "\n");
		end
		
	$fclose(f_ram);
	$fclose(f_ram_reg);
endtask

task automatic COMPARE_MATLAB_RAM(input string name_ref, name);
	int file_ref, file;
	int scan;
	
	shortint ik, jk;
	shortint cnt_st_er = 0;
	
	real temp [4];
	real temp_ref [4];
	real temp_er [4];
	
	real max_row_er; // max error on this row
	
	file_ref	= $fopen(name_ref, "r");
	file		= $fopen(name, "r");
	
	for(jk = 0; jk < `BANK_SIZE; jk = jk + 1)
		begin
			scan = $fscanf(file_ref, "%f\t%f\t%f\t%f\n", temp_ref[0], temp_ref[1], temp_ref[2], temp_ref[3]);
			scan = $fscanf(file, "%f\t%f\t%f\t%f\n", temp[0], temp[1], temp[2], temp[3]);

			max_row_er = 0;

			for(ik = 0; ik < 4; ik = ik + 1)
				begin
					temp_er[ik] = F_ABS(temp_ref[ik] - temp[ik]);
					if(temp_er[ik] > max_row_er) max_row_er = temp_er[ik];
				end

			if((temp_er[0] < `ACCURACY) & (temp_er[1] < `ACCURACY) & (temp_er[2] < `ACCURACY) & (temp_er[3] < `ACCURACY))
				$display("\tLine %3d:\tdata_0: %6.6f,\t\t\t\tdata_1: %6.6f,\t\t\t\tdata_2: %6.6f,\t\t\t\tdata_3: %6.6f", 
							jk, temp[0], temp[1], temp[2], temp[3]);
			else
				begin
					for(ik = 0; ik < 4; ik = ik + 1)
						if(temp_er[ik] > max_er) max_er = temp_er[ik];
					
					av_er = av_er + max_row_er;
					
					cnt_st_er = cnt_st_er + 1;
					$display(" ***\tLine %3d:\tdata_0: %6.6f,\t\t\t\tdata_1: %6.6f,\t\t\t\tdata_2: %6.6f,\t\t\t\tdata_3: %6.6f", 
								jk, temp[0], temp[1], temp[2], temp[3]);
					$display(" ***\t     REF:\tdata_0: %6.6f,\t\t\t\tdata_1: %6.6f,\t\t\t\tdata_2: %6.6f,\t\t\t\tdata_3: %6.6f", 
								temp_ref[0], temp_ref[1], temp_ref[2], temp_ref[3]);
				end			
		end
	
	$fclose(file_ref);
	$fclose(file);
	
	$display("\n\tnumber of errors compare RAM with matlab in this stage: %4d, time: %t", cnt_st_er, $time);
	
	cnt_all_er = cnt_all_er + cnt_st_er;
endtask

fht_top #(.D_BIT(`D_BIT), .A_BIT(`A_BIT), .W_BIT(`W_BIT), 
			.MIF_SIN(`MIF_SIN), .MIF_COS(`MIF_COS)) FHT(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.iWE(we),
	
	.iDATA_0(data_fixp),
	.iDATA_1(data_fixp),
	.iDATA_2(data_fixp),
	.iDATA_3(data_fixp),
	
	.iADDR_WR_0(addr_wr),
	.iADDR_WR_1(addr_wr),
	.iADDR_WR_2(addr_wr),
	.iADDR_WR_3(addr_wr),
	
	.iADDR_RD_0(addr_rd[0]),
	.iADDR_RD_1(addr_rd[1]),
	.iADDR_RD_2(addr_rd[2]),
	.iADDR_RD_3(addr_rd[3]),
	
	.oDATA_0(),
	.oDATA_1(),
	.oDATA_2(),
	.oDATA_3(),
	
	.oRDY(RDY_FHT)
);

fht_top #(.D_BIT(`D_BIT), .A_BIT(`A_BIT), .W_BIT(`W_BIT), 
			.MIF_SIN(`MIF_SIN), .MIF_COS(`MIF_COS)) IFHT(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.iWE(we),

	.iDATA_0(data_fixp),
	.iDATA_1(data_fixp),
	.iDATA_2(data_fixp),
	.iDATA_3(data_fixp),
	
	.iADDR_WR_0(addr_wr),
	.iADDR_WR_1(addr_wr),
	.iADDR_WR_2(addr_wr),
	.iADDR_WR_3(addr_wr),
	
	.iADDR_RD_0(addr_rd[0]),
	.iADDR_RD_1(addr_rd[1]),
	.iADDR_RD_2(addr_rd[2]),
	.iADDR_RD_3(addr_rd[3]),
	
	.oDATA_0(),
	.oDATA_1(),
	.oDATA_2(),
	.oDATA_3(),
	
	.oRDY(RDY_IFHT)
);

endmodule