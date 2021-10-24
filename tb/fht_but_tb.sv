`include "./fht_defines.v"

module fht_but_tb;

import common_types_pkg::*;
import fht_classes_pkg::*;
	
bit clk;
bit reset;

bit signed [`D_BIT - 1 : 0] data [0 : 2];
bit signed [`W_BIT - 1 : 0] sin;
bit signed [`W_BIT - 1 : 0] cos;

wire signed [`D_BIT - 1 : 0] RESULT [0 : 1];

uint16_t cnt_er, cnt_of;
float32_t max_er, sum_er; // max and avarage error

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
	float32_t sin_buf, cos_buf;
	
 	bit rand_trig;
	bit [1 : 0] cnt;
	
	$display("\n\n\t\tSTART TEST '2 DOT' BUTTERFLY");
	$display("\n\tError between reference signal and result must be less then `ACCURACY defines: %f", `ACCURACY);
	$display("\tIf error too big or there is overflow - in console its marked by '***'");
	
	#(5*`TACT); // pause before start
	
	max_er = 0;
	sum_er = 0;
	
	cnt_er = 0;
	cnt_of = 0;
	
	repeat(`NUM_OF_RPT)
		begin
			data[1] = $signed($random)%(`MAX_D);
				if(data[1] == `MAX_D) data[1] = data[1] - 1'b1;
			data[2] = $signed($random)%(`MAX_D);
				if(data[2] == `MAX_D) data[2] = data[2] - 1'b1;
			
			sin = $signed($random)%(`MAX_W);
				rand_trig = $signed($random)%(2);
				// temp = (rand_trig == 0) ? ($sqrt(`MAX_W*`MAX_W - sin*sin)) : ($sqrt(`MAX_W*`MAX_W - sin*sin) * rand_trig);
			// cos = temp - 1;
			cos = (rand_trig == 0) ? ($sqrt(`MAX_W*`MAX_W - sin*sin)) : ($sqrt(`MAX_W*`MAX_W - sin*sin) * rand_trig);
			
			data[0] = #(`TACT) $signed($random)%(`MAX_D);
				if(data[0] == `MAX_D) data[0] = data[0] - 1'b1;
				
			DispInput;
			#(`TACT);
			DispResult;
		end
	
	`ifdef EN_BREAKPOINT
		$display("\n\t\t\tpress 'run' to continue\n");
		$stop;
	`endif
	
	#(5*`TACT);
	
	$display("\n\n\n\t\tTEST ON SPEC ANGLES\n");
	
	cnt = 0;
	data[0] = 0; // max value of data recieve on '0' stage, on this stage 'X(0) = 0'
	
	for(uint16_t i = 0; i < 4; i++)
		begin
			for(uint16_t j = 0; j < 8; j++)
				begin
					if(cnt[0]) data[1] = {1'b0, {(`ADC_WIDTH - 1){1'b1}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					else data[1] = `MAX_D + {1'b1, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					
					if(cnt[1]) data[2] = {1'b0, {(`ADC_WIDTH - 1){1'b1}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					else data[2] = `MAX_D + {1'b1, {(`D_BIT - `ADC_WIDTH){1'b0}}};
			
					GetSpecAngle(j, `MAX_W, cos_buf, sin_buf);
					
					sin = sin_buf;
					cos = cos_buf;
					
					#(`TACT);
					DispInput;
					#(`TACT);
					DispResult;
				end
			cnt = cnt + 1;
		end
		
	ram_imit = null;
	#(5*`TACT);
	
	$finish;
end

task automatic DispInput;
	$display("\n\n\tInput signals, time: %t", $time);
	$display("\t\tData: x0 = %9.6f,\tx1 = %9.6f,\tx2 = %9.6f",	ram_imit.Reg2Float(data[0]), 
																ram_imit.Reg2Float(data[1]), 
																ram_imit.Reg2Float(data[2]));
	$display("\t\tCoef: sin = %6d,\tcos = %6d", sin, cos);
endtask

task automatic DispResult;
	float32_t temp;
	float32_t ref_0, ref_1;
	float32_t er_0, er_1;
	float32_t res [0 : 1];
	
	$display("\tReference/output signals:");
	temp = (cos*ram_imit.Reg2Float(data[1]) + sin*ram_imit.Reg2Float(data[2]))*1.0/`MAX_W;
	
	// $display("\t\tnormalize mult REF = %9.5f", temp);
	// $display("\t\tnormalize mult RES = %5d\n", BUT.ROUND_SUM_MUL);
	
	ref_0 = (ram_imit.Reg2Float(data[0]) + temp)/2.0;
	ref_1 = (ram_imit.Reg2Float(data[0]) - temp)/2.0;
	
	res[0] = ram_imit.Reg2Float(RESULT[0]);
	res[1] = ram_imit.Reg2Float(RESULT[1]);
	
	$display("\t\tRef: y0 = %9.6f\t\t\ty1 = %9.6f", ref_0, ref_1);
	$display("\t\tRes: y0 = %9.6f\t\t\ty1 = %9.6f", res[0], res[1]);
	
	$display("\tError (subtraction of res and ref signals), time: %t", $time);
		er_0 = ram_imit.AbsData(res[0] - ref_0);
		er_1 = ram_imit.AbsData(res[1] - ref_1);
	if((er_0 > `ACCURACY) | (er_1 > `ACCURACY))
		begin
			cnt_er = cnt_er + 1;
			$display(" ***\t\tError: er_0 = %6.6f, er_1 = %6.6f", er_0, er_1);
			
			if(er_0 > er_1) sum_er = sum_er + er_0;
			else sum_er = sum_er + er_1;
				
			if(er_0 > max_er) max_er = er_0;
			else if(er_1 > max_er) max_er = er_1;
		end
	else $display("\t\tErr: er_0 = %6.6f, er_1 = %6.6f", er_0, er_1);
		
	if((res[0] > `MAX_ADC_D - 1) | (res[0] < -`MAX_ADC_D) |
	   (res[1] > `MAX_ADC_D - 1) | (res[1] < -`MAX_ADC_D) |
	   (ref_0 > `MAX_ADC_D - 1) | (ref_0 < -`MAX_ADC_D) |
	   (ref_1 > `MAX_ADC_D - 1) | (ref_1 < -`MAX_ADC_D))
		begin
			cnt_of = cnt_of + 1;
			$display(" ***\t\tOverflow output");
		end
endtask

task automatic GetSpecAngle(
	input uint16_t i,
	input uint32_t hypo,
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
	$display("\tTotal amount of errors: %6d", cnt_er);
	$display("\tTotal amount of overflows: %6d", cnt_of);
	$display("\n\tMax error: %6.6f", max_er);

	if(cnt_er == 0) $display("\tAvarage error: 0");
	else $display("\tAvarage error: %6.6f", sum_er/cnt_er);
	$display("\n===========================================================================================\n");
end

fht_but #(.D_BIT(`D_BIT), .W_BIT(`W_BIT)) BUT(
	.iCLK(clk),
	.iRESET(reset),
	
	.iX_0(data[0]),
	.iX_1(data[1]),
	.iX_2(data[2]),
	
	.iSIN(sin),
	.iCOS(cos),
	
	.oY_0(RESULT[0]),
	.oY_1(RESULT[1])
);
	
endmodule