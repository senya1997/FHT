`include "./fht_defines.v"

module fht_but_tb;

import common_types_pkg::*;
import fht_classes_pkg::*;

typedef bit signed [`D_BIT - 1 : 0] data_t;
typedef bit signed [`W_BIT - 1 : 0] ang_t;

typedef struct {
	data_t data [0 : 2];
	ang_t sin;
	ang_t cos;
} stButPack_t;

class ButRandPacket;
	rand data_t data [0 : 2];
	rand ang_t sin, cos;
	
	constraint ValidValue {
		sin >= -`MAX_W;
		sin <=  `MAX_W;
		
		cos == GetCos(sin);
	}

	protected function ang_t GetCos(ang_t sin);
		return ang_t'($sqrt(`MAX_W * `MAX_W - sin * sin));
	endfunction
	
	function new();
		data[0] = 0;
		data[1] = 0;
		data[2] = 0;
		
		sin = `MAX_W;
		cos = 0;
	endfunction
endclass

bit clk;
bit reset;

wire signed [`D_BIT - 1 : 0] RESULT [0 : 1];

stButPack_t dut_pack; // go on DUT

uint16_t cnt_er, cnt_of; // counters errors and overflows
float32_t max_er, sum_er; // max and average error

TransformRAM #(`D_BIT, `ADC_WIDTH, `BANK_SIZE, `A_BIT, 4, 2) ram_imit; // for use static methods

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
	ButRandPacket but_rand;
	
	float32_t sin_buf, cos_buf;
	bit [1 : 0] cnt;
	
	but_rand = new();
	
	dut_pack.data[0] = 0;
	dut_pack.data[1] = 0;
	dut_pack.data[2] = 0;
	
	dut_pack.sin = `MAX_W;
	dut_pack.cos = 0;

	cnt_of = 0;
	cnt_er = 0;
	max_er = 0;
	sum_er = 0;

	$display("\n\n\t\tSTART TEST FHT BUTTERFLY");
	
`ifdef TEST_MIXER
	$display("\n\tTest mix data is enabled\n");
	
	dut_pack.data[0] = 1;
	dut_pack.data[1] = 2;
	#(`TACT);
	
	if((RESULT[0] != 1) | (RESULT[1] != 2))
		$display(" ***\t\tError: Mixer in but working wrong\n");
	else
		$display("\tMix data in but are correct\n");
	
	$finish;
`endif
	
	$display("\n\tError between reference signal and result must be less then `ACCURACY defines: %f", `ACCURACY);
	$display("\tIf error too big or there is overflow - in console its marked by '***'");
	
	#(4*`TACT); // pause before start
	
	repeat(`NUM_OF_RPT)
		begin
			void'(but_rand.randomize());

			dut_pack.data[1] = but_rand.data[1];
			dut_pack.data[2] = but_rand.data[2];

			dut_pack.sin = but_rand.sin;
			dut_pack.cos = but_rand.cos;

			dut_pack.data[0] = #(`TACT) but_rand.data[0];

			DispInput;
			#(`TACT);
			DispResult;
		end
	
	$display("\n\n\n\t\tTEST ON SPEC ANGLES\n");
	
	#(4*`TACT);
	
	cnt = 0;
	dut_pack.data[0] = 0; // max value of data receive on '0' stage, on this stage 'X(0) = 0'
	
	for(uint16_t i = 0; i < 4; i++)
		begin
			for(uint16_t j = 0; j < 8; j++)
				begin
					if(cnt[0])	dut_pack.data[1] = {1'b0, {(`ADC_WIDTH - 1){1'b1}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					else		dut_pack.data[1] = {1'b1, {(`ADC_WIDTH - 1){1'b0}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					
					if(cnt[1])	dut_pack.data[2] = {1'b0, {(`ADC_WIDTH - 1){1'b1}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					else		dut_pack.data[2] = {1'b1, {(`ADC_WIDTH - 1){1'b0}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
			
					GetSpecAngle(j, `MAX_W, cos_buf, sin_buf);
					
					dut_pack.sin = sin_buf;
					dut_pack.cos = cos_buf;
					
					#(`TACT) DispInput;
					#(`TACT) DispResult;
				end
				
			cnt = cnt + 1;
		end
		
	but_rand = null;
	#(4*`TACT);
	
	$finish;
end

task DispInput;
	$display("\n\n\tInput signals, time: %t", $time);
	$display("\t\tData: x[0] = %9.6f,\tx[1] = %9.6f,\tx[2] = %9.6f",	ram_imit.Reg2Float(dut_pack.data[0]), 
																		ram_imit.Reg2Float(dut_pack.data[1]), 
																		ram_imit.Reg2Float(dut_pack.data[2]));
	$display("\t\tCoef: sin = %6d,\tcos = %6d", dut_pack.sin, dut_pack.cos);
endtask

task DispResult;
	float32_t temp;
	float32_t ref_res [2];
	float32_t err [2];
	float32_t res [2];
	
	temp = float32_t'(dut_pack.cos * ram_imit.Reg2Float(dut_pack.data[1]) +
					  dut_pack.sin * ram_imit.Reg2Float(dut_pack.data[2]))/`MAX_W; // required convert data from reg to float, cause data on input contain fract part

	ref_res[0] = (ram_imit.Reg2Float(dut_pack.data[0]) + temp)/2;
	ref_res[1] = (ram_imit.Reg2Float(dut_pack.data[0]) - temp)/2;
	
	res[0] = ram_imit.Reg2Float(RESULT[0]);
	res[1] = ram_imit.Reg2Float(RESULT[1]);
	
	err[0] = ram_imit.AbsData(res[0] - ref_res[0]);
	err[1] = ram_imit.AbsData(res[1] - ref_res[1]);
	
	$display("\tReference/output signals:");
	
//	$display("\t\tnormalize mult REF = %9.5f", temp);
//	$display("\t\tnormalize mult RES = %5d\n", BUT.ROUND_SUM_MUL);
	
	$display("\t\tRef: y[0] = %9.6f\t\t\ty[1] = %9.6f", ref_res[0], ref_res[1]);
	$display("\t\tRes: y[0] = %9.6f\t\t\ty[1] = %9.6f", res[0], res[1]);
	
	$display("\tError (subtraction of res and ref signals), time: %t", $time);
		
	if((err[0] >= `ACCURACY) | (err[1] >= `ACCURACY))
		begin
			$display(" ***\t\tError: err[0] = %6.6f, err[1] = %6.6f", err[0], err[1]);
			
			if(ref_res[0] > (`MAX_ADC_D - 1) | ref_res[0] < -`MAX_ADC_D |
			   ref_res[1] > (`MAX_ADC_D - 1) | ref_res[1] < -`MAX_ADC_D)
				begin
					$display(" ***\t\tOverflow output");
					cnt_of = cnt_of + 1;
					return;
				end
			
			cnt_er = cnt_er + 1;
			
			if(err[0] > err[1]) sum_er = sum_er + err[0];
			else				sum_er = sum_er + err[1];
				
			if(err[0] > max_er)			max_er = err[0];
			else if(err[1] > max_er)	max_er = err[1];
		end
	else $display("\t\tErr: err[0] = %6.6f, err[1] = %6.6f", err[0], err[1]);
endtask

task automatic GetSpecAngle(
	input uint16_t i,
	input int32_t hypo,
	output float32_t cos,
	output float32_t sin
);
	case(i)
		0:	begin
				cos = hypo;
				sin = 0;
			end
		1:	begin
				cos = hypo/$sqrt(2);
				sin = hypo/$sqrt(2);
			end			
		2:	begin
				cos = 0;
				sin = hypo;
			end	
		3:	begin
				cos = -hypo/$sqrt(2);
				sin = hypo/$sqrt(2);
			end	
		4:	begin
				cos = -hypo;
				sin = 0;
			end	
		5:	begin
				cos = -hypo/$sqrt(2);
				sin = -hypo/$sqrt(2);
			end	
		6:	begin
				cos = 0;
				sin = -hypo;
			end	
		7:	begin
				cos = hypo/$sqrt(2);
				sin = -hypo/$sqrt(2);
			end	
	endcase
endtask

final begin
	$display("\n===========================================================================================\n");
	$display("\tStatistics about all calculations, %t:\n", $time);
	$display("\tNumber of errors:\t%6d", cnt_er);
	$display("\tNumber of overflows:\t%6d", cnt_of);
	
	$display("\n\tMax error:\t\t%6.6f", max_er);
	if(cnt_er == 0) $display("\tAvarage error:\t\t0");
	else $display("\tAvarage error:\t\t%6.6f", sum_er/cnt_er);
	$display("\n===========================================================================================\n");
end

fht_but #(.D_BIT(`D_BIT), .W_BIT(`W_BIT)) BUT(
	.iCLK(clk),
	.iRESET(reset),
	
	.iX_0(dut_pack.data[0]),
	.iX_1(dut_pack.data[1]),
	.iX_2(dut_pack.data[2]),
	
	.iSIN(dut_pack.sin),
	.iCOS(dut_pack.cos),
	
	.oY_0(RESULT[0]),
	.oY_1(RESULT[1])
);
	
endmodule