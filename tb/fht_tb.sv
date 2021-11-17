`include "./fht_defines.v"

module fht_tb;

import common_types_pkg::*;
import fht_classes_pkg::*;

bit clk;
bit reset;

bit start;

bit signed [`D_BIT - 1 : 0] data;
bit	[`A_BIT - 1 : 0] addr_rd, addr_wr;
bit	[3 : 0] we;

bit flag_cp_matlab = 1; // for turn off compare RAM with ref file on IFHT stage
bit ram_sel; // select which RAM is saving A/B

wire RDY_FHT;

float32_t min_data, max_data, mean_data;

TransformRAM #(`D_BIT, `ADC_WIDTH, `BANK_SIZE, `A_BIT, 4, 2) ram_imit;

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
	bit signed [`D_BIT - 1 : 0] disp_fht, disp_ifht; // display RAM data in wave
	
	`ifdef TEST_MIXER
		$display("\n\n\t\t\tSTART TEST DATA MIXERS WITH CONTROL\n");
	`else
		$display("\n\n\t\t\t\tSTART TEST FHT\n");
		
		$display("\tError between reference signal and result must be less then `ACCURACY defines: %f", `ACCURACY);
		$display("\tIf error too big - in console its marked by '***'\n");
	`endif
	
	`ifdef COMPARE_WITH_MATLAB
		$display("\tEnable RAM compare with 'txt' file from matlab");
	`endif
	
	disp_fht	= 0;
	disp_ifht	= 0;
	
	data		= 0;
	addr_rd		= 0;
	addr_wr		= 0;
	we			= 0;
	
	ram_sel = 1'b1;
	start	= 1'b0;
	
	ram_imit = new();
	ram_imit.SetPeriod(`TACT);

// init DUT by ADC data:
	#(10*`TACT);
	ram_imit.InitRAM(`INIT_FHT_RAM, 1, 1, data, addr_wr, we);
	ram_imit.SaveRAMdata("init_ram_a.txt");
	
	ram_imit.DisplayAsWaveRAM(disp_fht);
	disp_fht = 0;
	
// FHT:
	$display("\tStart FHT, time: %t\n", $time);
	
		// #1; // if "sdf" is turn off
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		#(`TACT);
	wait(RDY_FHT);
		#(`TACT);
	
	$display("\tFinish FHT, time: %t\n", $time);
	
	`ifdef LAST_STAGE_ODD
		UpdClassRAM_A;
	`elsif LAST_STAGE_EVEN
		UpdClassRAM_B;
	`endif
	
	ram_imit.SaveRAMdata(`FPGA_FHT_RAM);
	
	`ifdef COMPARE_WITH_MATLAB
		void'(ram_imit.CompareWithFile(`MATH_FHT_RAM, `ACCURACY));
		flag_cp_matlab = 0;
	`endif
	
	min_data = ram_imit.GetMinDataRam();
	max_data = ram_imit.GetMaxDataRam();
	mean_data = ram_imit.GetMeanDataRam();
	
	`ifdef EN_BREAKPOINT
		$display("\n\t\t\tpress 'run' to continue");
		$stop;
	`endif
	
// IFHT:
	ram_imit.Bitrev2NormalRAM();
	ram_imit.InitRAM("", 0, 0, data, addr_wr, we);
	
	$display("\tStart IFHT, time: %t...\n", $time);
	
	start = 1'b1;
		#(`TACT);
	start = 1'b0;
		#(`TACT);
	wait(RDY_FHT);
		#(`TACT);
	
	$display("\tFinish IFHT, time: %t\n", $time);
		
	`ifdef LAST_STAGE_ODD
		UpdClassRAM_A;
	`elsif LAST_STAGE_EVEN
		UpdClassRAM_B;
	`endif
	
	ram_imit.Bitrev2NormalRAM();
	ram_imit.DisplayAsWaveRAM(disp_ifht);
	disp_ifht = 0;
	
	$finish;
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
				void'(ram_imit.CompareWithFile(str_temp_ref, `ACCURACY));
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
	$display();
endtask

task UpdClassRAM_B;
	ram_imit.UpdBankRAM(0, FHT.FHT_RAM_B.ram_bank[0].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(1, FHT.FHT_RAM_B.ram_bank[1].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(2, FHT.FHT_RAM_B.ram_bank[2].RAM_BANK.`RAM_ACCESS_TB);
	ram_imit.UpdBankRAM(3, FHT.FHT_RAM_B.ram_bank[3].RAM_BANK.`RAM_ACCESS_TB);
	$display();
endtask

final begin
 	$display("\n===========================================================================================\n");
 	$display("\tStatistics about all transform, %t:\n", $time);
 	$display("\tData range in transform is: %6.6f ... %6.6f", min_data, max_data);
 	$display("\tMean data: %6.6f\n", mean_data);
 	$display("\tMax error: %6.6f", ram_imit.GetMaxErr());
	$display("\tAvarage error: %6.6f", ram_imit.GetAvErr());
	$display("\tTotal amount of errors: %d", ram_imit.GetAllErr());
	$display("\n===========================================================================================\n");
	
	ram_imit = null;
end
	
fht_top #(.D_BIT(`D_BIT), .A_BIT(`A_BIT), .W_BIT(`W_BIT), 
			.MIF_SIN(`MIF_SIN), .MIF_COS(`MIF_COS)) FHT(
	.iCLK(clk),
	.iRESET(reset),
	
	.iSTART(start),
	
	.iWE(we),
	
	.iDATA_0(data),
	.iDATA_1(data),
	.iDATA_2(data),
	.iDATA_3(data),
	
	.iADDR_WR_0(addr_wr),
	.iADDR_WR_1(addr_wr),
	.iADDR_WR_2(addr_wr),
	.iADDR_WR_3(addr_wr),
	
	.iADDR_RD_0(addr_rd),
	.iADDR_RD_1(addr_rd),
	.iADDR_RD_2(addr_rd),
	.iADDR_RD_3(addr_rd),
	
	.oDATA_0(),
	.oDATA_1(),
	.oDATA_2(),
	.oDATA_3(),
	
	.oRDY(RDY_FHT)
);

endmodule