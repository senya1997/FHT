`timescale 1ns/1ns
`include "../fht_defines.v"
`include "../fht_defines_tb.v"

module fht_but_tb;

bit clk;
bit reset;

bit signed [`D_BIT - 1 : 0] data [0 : 2];
bit signed [`W_BIT - 1 : 0] sin;
bit signed [`W_BIT - 1 : 0] cos;

wire signed [`D_BIT - 1 : 0] RESULT [0 : 1];

// real temp;
byte temp_byte;
real sin_buf, cos_buf;

int cnt_er, cnt_of;

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
	bit [2 : 0] cnt;
	
	#(5*`TACT); // pause before start
	
	$display("\n\n\t\tSTART TEST ONE '2 DOT' BUTTERFLY");
	$display("\n\terror between reference signal and result must be less then '1'");
	$display("\tif error too big or there is overflow - in console its marked by '***'");
	
	cnt_er = 0;
	cnt_of = 0;
	repeat(`NUM_OF_RPT)
		begin
			data[1] = $signed($random)%(`MAX_D);
				if(data[1] == `MAX_D) data[1] = data[1] - 1;
			data[2] = $signed($random)%(`MAX_D);
				if(data[2] == `MAX_D) data[2] = data[2] - 1;
				
			sin = $signed($random)%(`MAX_W);
				temp_byte = $signed($random)%(2);
				// temp = (temp_byte == 0) ? ($sqrt(`MAX_W*`MAX_W - sin*sin)) : ($sqrt(`MAX_W*`MAX_W - sin*sin) * temp_byte);
			// cos = temp - 1;
			cos = (temp_byte == 0) ? ($sqrt(`MAX_W*`MAX_W - sin*sin)) : ($sqrt(`MAX_W*`MAX_W - sin*sin) * temp_byte);
			
			data[0] = #(`TACT) $signed($random)%(`MAX_D);
				if(data[0] == `MAX_D) data[0] = data[0] - 1;
				
			DISP_INPUT;
			#(`TACT);
			DISP_RESULT;
		end
	
	#(5*`TACT);
	
	$display("\n\n\n\t\tTEST ON SPEC ANGLES\n");
	
	cnt = 0;
	for(i = 0; i < 8; i++)
		begin
			for(j = 0; j < 8; j++)
				begin
					if(cnt[1]) data[1] = `MAX_D - 1; else data[1] = -`MAX_D;
					if(cnt[2]) data[2] = `MAX_D - 1; else data[2] = -`MAX_D;
			
						GET_SPEC_ANG(j, `MAX_W, cos_buf, sin_buf);
					sin = sin_buf;
					cos = cos_buf;
					
					#(`TACT); 
					if(cnt[0]) data[0] = `MAX_D - 1; else data[0] = -`MAX_D;
					
					DISP_INPUT;
					#(`TACT);
					DISP_RESULT;
				end
			cnt = cnt + 1;
		end
	
	$display("\n\n\tTotal amount of errors: %6d", cnt_er);
	$display("\tTotal amount of overflows: %6d", cnt_of);
	
	#(5*`TACT);
	$display("\n\n\t\t\tCOMPLETE\n");
	
	mti_fli::mti_Cmd("stop -sync");
end

task DISP_INPUT;
	$display("\n\n\tinput signals, time: %t", $time);
	$display("\t\tDATA: x0 = %6d,", data[0], "\tx1 = %6d,", data[1], "\tx2 = %6d", data[2]);
	$display("\t\tCOEF: sin = %6d,", sin, "\tcos = %6d", cos);
endtask

task DISP_RESULT;
	bit signed [`D_BIT + `W_BIT : 0] ext_buf; 
	
	real ref_0, ref_1;
	real er_0, er_1;

	$display("\treference/output signals:");
					
		ext_buf = cos*data[1] + sin*data[2];
	ref_0 = (data[0] + ext_buf*1.0/`MAX_W/2.0)/2.0;
	ref_1 = (data[0] - ext_buf*1.0/`MAX_W/2.0)/2.0;
	
	$display("\t\tREF: y0 = %9.3f,", ref_0, "\ty1 = %9.3f", ref_1);
	$display("\t\tRES: y0 = %9d,", RESULT[0], "\ty1 = %9d", RESULT[1]);
	
	$display("\terror (subtraction of res and ref signals), time: %t", $time);
		er_0 = RESULT[0] - ref_0; // value of error
		er_1 = RESULT[1] - ref_1;
	if(((er_0*er_0) >= 1) | ((er_1*er_1) >= 1)) // abs value
		begin
			cnt_er = cnt_er + 1;
			$display("***\t\tERROR: er_0 = %6.4f, er_1 = %6.4f", er_0, er_1);
		end
	else 
		$display("\t\tERR: er_0 = %6.4f, er_1 = %6.4f", er_0, er_1);
	if((RESULT[0] > (`MAX_D - 1)) | (RESULT[0] < (-`MAX_D)) |
	   (RESULT[1] > (`MAX_D - 1)) | (RESULT[1] < (-`MAX_D)))
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

fht_but BUT(
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