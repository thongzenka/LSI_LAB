module convert_num_to_led(num,led);
	input [4:0]num;
	output reg[15:0]led;
	reg [4:0]i;
	reg [4:0]num_temp;
	
	always@(num) begin
		led=16'b0;
		num_temp=num;
		for(i=16; i>0;i=i-1) begin
			if(num_temp>0) begin
				num_temp=num_temp-1;
				led=led << 1;
				led=led | 1'b1;
			end 
		end
	end
endmodule