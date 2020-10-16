`timescale 1ns/1ns
`include "../fht_defines.v"

package fli;
	import "DPI-C" function mti_Cmd(input string cmd);
endpackage

module fht_but_tb;

import fli::*;

bit clk;
bit reset;

bit signed [`D_BIT - 1 : 0] data [0 : 2];
bit signed [`W_BIT - 1 : 0] sin;
bit signed [`W_BIT - 1 : 0] cos;

wire signed [`D_BIT - 1 : 0] RESULT [0 : 1];

// real temp;
byte temp_byte;

real sin_buf, cos_buf;
real max_er, av_er; // max and avarage error

int cnt_er, cnt_of;

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
	shortint i, j;
	bit [1 : 0] cnt;
	
	max_er = 0;
	av_er = 0;
	
	#(5*`TACT); // pause before start
	
	$display("\n\n\t\tSTART TEST '2 DOT' BUTTERFLY");
	$display("\n\terror between reference signal and result must be less then `ACCURACY defines: %6.6f", `ACCURACY);
	$display("\tif error too big or there is overflow - in console its marked by '***'");
	
	cnt_er = 0;
	cnt_of = 0;
	repeat(`NUM_OF_RPT)
		begin
			data[1] = $signed($random)%(`MAX_D);
				if(data[1] == `MAX_D) data[1] = data[1] - 1'b1;
			data[2] = $signed($random)%(`MAX_D);
				if(data[2] == `MAX_D) data[2] = data[2] - 1'b1;
			
			sin = $signed($random)%(`MAX_W);
				temp_byte = $signed($random)%(2);
				// temp = (temp_byte == 0) ? ($sqrt(`MAX_W*`MAX_W - sin*sin)) : ($sqrt(`MAX_W*`MAX_W - sin*sin) * temp_byte);
			// cos = temp - 1;
			cos = (temp_byte == 0) ? ($sqrt(`MAX_W*`MAX_W - sin*sin)) : ($sqrt(`MAX_W*`MAX_W - sin*sin) * temp_byte);
			
			data[0] = #(`TACT) $signed($random)%(`MAX_D);
				if(data[0] == `MAX_D) data[0] = data[0] - 1'b1;
				
			DISP_INPUT;
			#(`TACT);
			DISP_RESULT;
		end
	
	`ifdef EN_BREAKPOINT
		$display("\n\t\t\tpress 'run' to continue\n");
		void'(mti_Cmd("stop -sync"));
	`endif
	
	#(5*`TACT);
	
	$display("\n\n\n\t\tTEST ON SPEC ANGLES\n");
	
	cnt = 0;
	data[0] = 0; // max value of data recieve on '0' stage, on this stage 'X(0) = 0'
	
	for(i = 0; i < 4; i++)
		begin
			for(j = 0; j < 8; j++)
				begin
					if(cnt[0]) data[1] = {1'b0, {(`ADC_WIDTH - 1){1'b1}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					else data[1] = `MAX_D + {1'b1, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					
					if(cnt[1]) data[2] = {1'b0, {(`ADC_WIDTH - 1){1'b1}}, {(`D_BIT - `ADC_WIDTH){1'b0}}};
					else data[2] = `MAX_D + {1'b1, {(`D_BIT - `ADC_WIDTH){1'b0}}};
			
					GET_SPEC_ANG(j, `MAX_W, cos_buf, sin_buf);
					
					sin = sin_buf;
					cos = cos_buf;
					
					#(`TACT);
					DISP_INPUT;
					#(`TACT);
					DISP_RESULT;
				end
			cnt = cnt + 1;
		end
	
	$display("\n\n\ttotal amount of errors: %6d", cnt_er);
	$display("\ttotal amount of overflows: %6d", cnt_of);
	
	$display("\n\tmax error: %6.6f", max_er);
	
	if(cnt_er == 0) $display("\tavarage error: 0.000000");
	else $display("\tavarage error: %6.6f\n", av_er/cnt_er);
	
	#(5*`TACT);
	$display("\n\n\t\t\tCOMPLETE\n");
	
	void'(mti_Cmd("stop -sync"));
end

task DISP_INPUT;
	$display("\n\n\tinput signals, time: %t", $time);
	$display("\t\tDATA: x0 = %9.6f,", F_REG_TO_REAL(data[0]), "\tx1 = %9.6f,", F_REG_TO_REAL(data[1]), "\tx2 = %9.6f", F_REG_TO_REAL(data[2]));
	$display("\t\tCOEF: sin = %6d,", sin, "\tcos = %6d", cos);
endtask

task DISP_RESULT;
	real temp;
	real ref_0, ref_1;
	real er_0, er_1;
	real res [0 : 1];
	
	$display("\treference/output signals:");
	temp = (cos*F_REG_TO_REAL(data[1]) + sin*F_REG_TO_REAL(data[2]))*1.0/`MAX_W;
	
	// $display("\t\tnormalize mult REF = %9.5f", temp);
	// $display("\t\tnormalize mult RES = %5d\n", BUT.ROUND_SUM_MUL);
	
	ref_0 = (F_REG_TO_REAL(data[0]) + temp)/2.0;
	ref_1 = (F_REG_TO_REAL(data[0]) - temp)/2.0;
	
	res[0] = F_REG_TO_REAL(RESULT[0]);
	res[1] = F_REG_TO_REAL(RESULT[1]);
	
	$display("\t\tREF: y0 = %9.6f\t\t\ty1 = %9.6f", ref_0, ref_1);
	$display("\t\tRES: y0 = %9.6f\t\t\ty1 = %9.6f", res[0], res[1]);
	
	$display("\terror (subtraction of res and ref signals), time: %t", $time);
		er_0 = F_ABS(res[0] - ref_0); // abs value of error
		er_1 = F_ABS(res[1] - ref_1);
	if((er_0 > `ACCURACY) | (er_1 > `ACCURACY))
		begin
			cnt_er = cnt_er + 1;
			$display("***\t\tERROR: er_0 = %6.6f, er_1 = %6.6f", er_0, er_1);
			
			if(er_0 > er_1) av_er = av_er + er_0;
			else av_er = av_er + er_1;
				
			if(er_0 > max_er) max_er = er_0;
			else if(er_1 > max_er) max_er = er_1;
		end
	else $display("\t\tERR: er_0 = %6.6f, er_1 = %6.6f", er_0, er_1);
		
	if((res[0] > `MAX_ADC_D) | (res[0] < -`MAX_ADC_D) |
	   (res[1] > `MAX_ADC_D) | (res[1] < -`MAX_ADC_D) |
	   (ref_0 > `MAX_ADC_D) | (ref_0 < -`MAX_ADC_D) |
	   (ref_1 > `MAX_ADC_D) | (ref_1 < -`MAX_ADC_D))
		begin
			cnt_of = cnt_of + 1;
			$display("***\t\tOVERFLOW OUTPUT");
		end
endtask

task GET_SPEC_ANG(
	input shortint i,
	input int hypo,
	output real cos,
	output real sin
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