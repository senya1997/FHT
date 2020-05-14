`timescale 1ns/1ns
`include "../fht_defines.v"
`include "../fht_defines_tb.v"

`define D_SIZE 17 // data - signed 
`define W_SIZE 12 // rotation coefficients - signed 

`define MAX_D 32767 // or 32768 ?
`define MAX_W 1024
`define HALF_W 11'sd512

`define NUM_OF_RPT 30 // number of repeat test 

module fht_but_tb;

bit clk;
bit reset;

bit signed [`D_SIZE - 1 : 0] data [0:2];
bit signed [`W_SIZE - 1 : 0] sin;
bit signed [`W_SIZE - 1 : 0] cos;

wire signed [`D_SIZE - 1 : 0] RESULT [0:1];

// reference signals:
wire signed [`D_SIZE + 1 : 0] Y0_RE_4DOT = x_re[0] + x_re[1] + x_re[2] + x_re[3] + 3'sd2; // 4 dot
wire signed [`D_SIZE + 1 : 0] Y0_IM_4DOT = x_im[0] + x_im[1] + x_im[2] + x_im[3] + 3'sd2;

wire signed [`D_SIZE + 1 : 0] Y1_RE_4DOT = x_re[0] + x_im[1] - x_re[2] - x_im[3] + 3'sd2;
wire signed [`D_SIZE + 1 : 0] Y1_IM_4DOT = x_im[0] - x_re[1] - x_im[2] + x_re[3] + 3'sd2;

wire signed [`D_SIZE + 1 : 0] Y2_RE_4DOT = x_re[0] - x_re[1] + x_re[2] - x_re[3] + 3'sd2;
wire signed [`D_SIZE + 1 : 0] Y2_IM_4DOT = x_im[0] - x_im[1] + x_im[2] - x_im[3] + 3'sd2;

wire signed [`D_SIZE + 1 : 0] Y3_RE_4DOT = x_re[0] - x_im[1] - x_re[2] + x_im[3] + 3'sd2;
wire signed [`D_SIZE + 1 : 0] Y3_IM_4DOT = x_im[0] + x_re[1] - x_im[2] - x_re[3] + 3'sd2;

// compare output with reference:	
wire MATCH_4DOT = Y_RE[0] == Y0_RE_4DOT[`D_SIZE + 1 : 2] & Y_RE[1] == Y1_RE_4DOT[`D_SIZE + 1 : 2] & Y_RE[2] == Y2_RE_4DOT[`D_SIZE + 1 : 2] & Y_RE[3] == Y3_RE_4DOT[`D_SIZE + 1 : 2] &
				  Y_IM[0] == Y0_IM_4DOT[`D_SIZE + 1 : 2] & Y_IM[1] == Y1_IM_4DOT[`D_SIZE + 1 : 2] & Y_IM[2] == Y2_IM_4DOT[`D_SIZE + 1 : 2] & Y_IM[3] == Y3_IM_4DOT[`D_SIZE + 1 : 2];			  
	
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
	#(5*`TACT); // pause before start
	
	$display("\n\n\t\t\tSTART TEST ONE '2 DOT' BUTTERFLY\n");
	
	repeat(`NUM_OF_RPT_4DOT)
		begin
			data[0] = $signed($random)%(`MAX_D);
			data[1] = $signed($random)%(`MAX_D);
			data[2] = $signed($random)%(`MAX_D);
			
			sin = $signed($random)%(`MAX_W);
			
			
			GET_COMP_NUM(x_re[0], x_im[0]);
			GET_COMP_NUM(x_re[1], x_im[1]);
			GET_COMP_NUM(x_re[2], x_im[2]);
			GET_COMP_NUM(x_re[3], x_im[3]);
			
			$display("\n\tinput signals, time: %t", $time);
			$display("\t\tDATA: x0 = %6d", data[0], "\tx1 = %6d", data[1], "\tx2 = %6d", data[2]);
			$display("\t\tCOEF: sin = %6d", sin, "\tcos = %6d", cos);
			
			#(`TACT);
			
			assert(MATCH_2DOT) $display("\tOK output signals:");
			else
				begin
					$display("\tERROR reference/output signals:");
					$display("\t\tRE: y0 = %6d", Y0_RE_4DOT[`D_SIZE + 1 : 2], "\ty1 = %6d", Y1_RE_4DOT[`D_SIZE + 1 : 2], "\ty2 = %6d", Y2_RE_4DOT[`D_SIZE + 1 : 2], "\ty3 = %6d", Y3_RE_4DOT[`D_SIZE + 1 : 2]);
					$display("\t\tIM: y0 = %6d", Y0_IM_4DOT[`D_SIZE + 1 : 2], "\ty1 = %6d", Y1_IM_4DOT[`D_SIZE + 1 : 2], "\ty2 = %6d", Y2_IM_4DOT[`D_SIZE + 1 : 2], "\ty3 = %6d", Y3_IM_4DOT[`D_SIZE + 1 : 2]);
				end
			$display("\t\tRES: y0 = %6d", RESULT[0], "\ty1 = %6d", RESULT[1]);
		end
	
	$display("\n\t\tTEST ON SPEC ANGLES\n");
	for(i = 0; i < 8; i++)
		begin
			for(j = 0; j < 8; j++)
				begin
					GET_SPEC_ANG(i, `MAX_D, re_buf, im_buf);
						re = re_buf;
						im = im_buf;
			
					GET_SPEC_ANG(j, `MAX_W, w_re_buf, w_im_buf);
						w_re = w_re_buf;
						w_im = w_im_buf;
					
					d_ang = GET_ANG(re_buf, im_buf, `MAX_D);
					w_ang = GET_ANG(w_re_buf, w_im_buf, `MAX_W);
					
					res_ang = d_ang + w_ang;
					if(res_ang >= 360) res_ang = res_ang - 360;
					
					#(`TACT);
						re_buf = RE;
						im_buf = IM;
					mult_ang = GET_ANG(re_buf, im_buf, `MAX_D);
					
					$display("\n\td_ang = %6.2f", d_ang, "\t\tw_ang = %6.2f", w_ang, "\t\ttime = %t", $time,
					 "\n\t\tres_ang =  \t%6.2f", res_ang,
					 "\n\t\tmult_ang = \t%6.2f\n", mult_ang);
				end 
		end
		
	#(5*`TACT);
	$display("\n\n\t\t\t\tCOMPLETE\n");
	
	mti_fli::mti_Cmd("stop -sync");
end

task GET_COMP_NUM(
	output signed [`D_SIZE - 1 : 0] oRE,
	output signed [`D_SIZE - 1 : 0] oIM
);
	begin
		real temp;
		byte temp_byte;
		
		oRE = $signed($random)%(`MAX_D);
			temp_byte = $signed($random)%(2); // get random '1' or '-1' for imagine part of number
			temp = (temp_byte == 0) ? ($sqrt(`MAX_D*`MAX_D - oRE*oRE)) : ($sqrt(`MAX_D*`MAX_D - oRE*oRE) * temp_byte);
		// im = temp - 1; // for avoid overflow 
		oIM = temp;	
	end
endtask;

task GET_SPEC_ANG(
	input shortint i,
	input int hypo,
	output real re,
	output real im
);
	case(i)
		0:	begin
				re = hypo;
				im = 0;
			end
		1:	begin
				re = hypo/$sqrt(2);
				im = hypo/$sqrt(2);
			end			
		2:	begin
				re = 0;
				im = hypo;
			end	
		3:	begin
				re = -hypo/$sqrt(2);
				im = hypo/$sqrt(2);
			end	
		4:	begin
				re = -hypo;
				im = 0;
			end	
		5:	begin
				re = -hypo/$sqrt(2);
				im = -hypo/$sqrt(2);
			end	
		6:	begin
				re = 0;
				im = -hypo;
			end	
		7:	begin
				re = hypo/$sqrt(2);
				im = -hypo/$sqrt(2);
			end	
	endcase
endtask

fht_but #(.D_BIT(`D_SIZE), .W_BIT(`W_SIZE), .W_HALF(`HALF_W)) BUT(
	.iCLK(iCLK),
	.iRESET(iRESET),
	
	.iX_0(data[0]),
	.iX_1(data[1]),
	.iX_2(data[2]),
	
	.iSIN(sin),
	.iCOS(cos),
	
	.oY_0(RESULT[0]),
	.oY_1(RESULT[1])
);
	
endmodule