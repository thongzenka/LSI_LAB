module bound_flash(clk, reset, flick, state, out);
	parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6;
	input clk, reset, flick;
	output wire [15:0] out;
	output reg [3:0] state;
	reg [4:0] count = 0;
	
	convert_num_to_led func(.num (count), .led (out));

	always @ (posedge clk or posedge reset) begin
		if (reset) state = S0;
		else begin
			case (state)
				S0:
					begin
						if (count>0 )count = count - 1;
						else begin
							count = 0;
							state = (flick == 1)?S1:S0;
						end
					end
				S1:
					begin
						count = count + 1;
						if (count==6) state = S2;
					end
				S2:
					begin
						count= count - 1;
						if (count==0) state = S3;
					end
				S3:
					begin
						count= count + 1;
						if (count==6) state = (flick==1)?S2:S3;
						else if (count==11) state = (flick==1)?S2:S4;
					end
				S4:
					begin
						count = count - 1;
						if (count==5) state = S5;
					end
				S5:
					begin
						count = count + 1;
						if (count==6) state = (flick==1)?S4:S5;
						else if (count==11) state = (flick==1)?S4:S5;
						else if (count==16) state = S0;
					end
				default: state = 0;
			endcase
		end
	end
endmodule