`include "./fht_defines.v"

module fht_tb;

import common_types_pkg::*;
import fht_classes_pkg::*;

bit clk;
bit reset;

bit start;

bit signed [`D_BIT - 1 : 0] data_fixp;
bit [`A_BIT - 1 : 0] addr_wr;
bit [3 : 0] we;

bit signed [`D_BIT - 1 : 0] fht_data;
bit	[`A_BIT - 1 : 0] fht_addr;
bit	[3 : 0] fht_we;

bit flag_cp_matlab = 1; // for turn off COMPARE_MATLAB_RAM on IFHT stage !!! mb replace by RDY_FHT signal ???
bit ram_sel;

wire RDY_FHT, RDY_IFHT;

TransformRAM #(`D_BIT, `ADC_WIDTH, `A_BIT, `BANK_SIZE, 4) ram_imit;

int i, j;

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
	int temp_data[4];
	
// buf RAM for transmit data from bit rev order to norm before start IFHT:
	logic signed [`D_BIT - 1 : 0] ram_buf_0 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_1 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_2 [0 : `BANK_SIZE - 1];
	logic signed [`D_BIT - 1 : 0] ram_buf_3 [0 : `BANK_SIZE - 1];
	
	bit [`A_BIT - 1 : 0] cnt_rev;
	
	`ifdef TEST_MIXER
		$display("\n\n\t\t\tSTART TEST DATA MIXERS WITH CONTROL\n");
	`else
		$display("\n\n\t\t\t\tSTART TEST FHT\n");
	`endif
	
	$display("\tError between reference signal and result must be less then `ACCURACY defines: %f", `ACCURACY);
	$display("\tIf error too big - in console its marked by '***'");
	
	`ifdef COMPARE_WITH_MATLAB
		$display("\tRAM compare with 'txt' file from matlab");
	`endif
	
	fht_data = 0; 
	fht_addr = 0;
	fht_we = 0;
	
	ram_sel = 1'b1;
	start = 1'b0;
	
	ram_imit = new();
	ram_imit.SetPeriod(`TACT);
	
	#(100*`TACT);

	$display("\n\twrite ADC data point in RAM, time: %t\n", $time);
	
	ram_imit.InitRAM(`INIT_FHT_RAM, 1, 1, fht_data, fht_addr, fht_we);
	ram_imit.SaveRAMdata("init_ram_a.txt");
	
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
		$stop;
	`endif
	
	`ifdef LAST_STAGE_ODD
		UpdClassRAM_A;
	`elsif LAST_STAGE_EVEN
		UpdClassRAM_B;
	`endif
	
	ram_imit.SaveRAMdata(`FPGA_FHT_RAM);
	
	`ifdef COMPARE_WITH_MATLAB
		ram_imit.CompareWithFile(`MATH_FHT_RAM, `ACCURACY);
		
		$display("\n\tMax error in all transfer: %6.6f", ram_imit.GetMaxErr());
		$display("\tAvarage error in all transfer: %6.6f", ram_imit.GetAvErr());
		$display("\tTotal amount of errors: %d", ram_imit.GetAllErr());
	`endif
	
	`ifdef EN_BREAKPOINT
		$display("\n\t\t\tpress 'run' to continue");
		$stop;
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
	
	for(uint16_t j = 0; j < `BANK_SIZE; j++) 
		begin
			temp_data[0] = ram_buf_0[F_BIT_REV(cnt_rev)];
			temp_data[1] = ram_buf_1[F_BIT_REV(cnt_rev)];
			temp_data[2] = ram_buf_2[F_BIT_REV(cnt_rev)];
			temp_data[3] = ram_buf_3[F_BIT_REV(cnt_rev)];
				
			for(uchar_t i = 0; i < 4; i++)
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
	
	ram_imit = null;
	
	$display("\tfinish IFHT, time: %t\n", $time);

	$display("\n\t\t\t\tCOMPLETE\n");
	$stop;
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
			
			if(~ram_sel)	str_temp = {"before_", str_stage, "st_ram_a.txt"};
			else 			str_temp = {"before_", str_stage, "st_ram_b.txt"};
			
				#(2*`TACT);
				
			if(ram_sel)	UpdClassRAM_B;
			else		UpdClassRAM_A;
				
			ram_imit.SaveRAMdata(str_temp);
			ram_sel = ~ram_sel;
			
			`ifdef COMPARE_WITH_MATLAB
				str_temp_ref = {"../../fht/matlab/before_", str_stage, "st_ram.txt"};
				ram_imit.CompareWithFile(str_temp_ref, `ACCURACY);
			`endif
	
			`ifdef EN_BREAKPOINT
				$display("\n\t\t\tpress 'run' to continue\n");
				$stop;
			`endif
		end
end

task UpdClassRAM_A;
	ram_imit.UpdBankRAM(0, FHT.FHT_RAM_A.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(1, FHT.FHT_RAM_A.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(2, FHT.FHT_RAM_A.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(3, FHT.FHT_RAM_A.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB);
endtask

task UpdClassRAM_B;
	ram_imit.UpdBankRAM(0, FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(1, FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(2, FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(3, FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB);
endtask

fht_top #(.D_BIT(`D_BIT), .A_BIT(`A_BIT), .W_BIT(`W_BIT), 
			.MIF_SIN(`MIF_SIN), .MIF_COS(`MIF_COS)) FHT(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.iWE(fht_we),
	
	.iDATA_0(fht_data),
	.iDATA_1(fht_data),
	.iDATA_2(fht_data),
	.iDATA_3(fht_data),
	
	.iADDR_WR_0(fht_addr),
	.iADDR_WR_1(fht_addr),
	.iADDR_WR_2(fht_addr),
	.iADDR_WR_3(fht_addr),
	
	.iADDR_RD_0(),
	.iADDR_RD_1(),
	.iADDR_RD_2(),
	.iADDR_RD_3(),
	
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

	.iADDR_RD_0(),
	.iADDR_RD_1(),
	.iADDR_RD_2(),
	.iADDR_RD_3(),

	.oDATA_0(),
	.oDATA_1(),
	.oDATA_2(),
	.oDATA_3(),

	.oRDY(RDY_IFHT)
);

endmodule