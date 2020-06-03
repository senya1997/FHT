module fht_in_mix #(parameter D_BIT = 17, SEC_BIT = 9)( 
	input iCLK,
	input iRESET,
	
	input iST_ZERO,
	input [SEC_BIT - 1 : 0] iSECTOR,
	
	input signed [D_BIT - 1 : 0] iBANK_0, // normal order 0,1,2,3
	input signed [D_BIT - 1 : 0] iBANK_1, // reverse order 2,3,0,1
	input signed [D_BIT - 1 : 0] iBANK_2,
	input signed [D_BIT - 1 : 0] iBANK_3,
	
	output signed [D_BIT - 1 : 0] oY_0,
	output signed [D_BIT - 1 : 0] oY_1,
	output signed [D_BIT - 1 : 0] oY_2
);

reg signed [D_BIT - 1: 0] mux_buf [0 : 2];

always@(posedge iCLK or negedge iRESET)begin
	if(!iRESET)
		begin
			mux_buf[0] <= 0; // 0 - going on SUM
			mux_buf[1] <= 0; // 1 - going on MUL COS
			mux_buf[2] <= 0; // 2 - going on MUL SIN
		end
	else if(iST_ZERO)
		begin
			mux_buf[0] <= iBANK_0;
			mux_buf[1] <= iBANK_1;
			mux_buf[2] <= 0;
		end
	else
		case(iSECTOR)
			0:
				begin
					mux_buf[0] <= iBANK_0;
					mux_buf[1] <= iBANK_1;
					mux_buf[2] <= iBANK_1;
				end
			1:
				begin
					mux_buf[0] <= iBANK_1;
					mux_buf[1] <= iBANK_0;
					mux_buf[2] <= iBANK_2;
				end
			default:
				begin
					if(iSECTOR[0] == 1'b1)
						begin
							mux_buf[0] <= iBANK_0;
							mux_buf[1] <= iBANK_1;
							mux_buf[2] <= iBANK_2;
						end
					else
						begin
							mux_buf[0] <= iBANK_1;
							mux_buf[1] <= iBANK_0;
							mux_buf[2] <= iBANK_3;
						end
				end
		endcase
end

assign oY_0 = mux_buf[0];
assign oY_1 = mux_buf[1];
assign oY_2 = mux_buf[2];

endmodule 