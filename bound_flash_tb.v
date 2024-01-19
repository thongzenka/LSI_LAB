`timescale 1ns/1ps
module bound_flash_tb;
	wire [15:0] out;
	reg clk, reset, flick = 0;
	wire [3:0] out_state;
	bound_flash test(clk, reset, flick, out_state, out);
	integer i;
	
	always #5 clk = ~clk;

	initial begin
		clk <= 0;
		reset <= 0;

		#10  flick <= 1; // start at 1
		#10  flick <= 0; // flick off
		#220 flick <= 1; // flick on at 20 (21 is the 10th led)
		#10  flick <= 0; // flick off at 22
//		#380 flick <= 1; // flick on at 60 (61 is the 15th led)
//		#20  flick <= 0; // flick off at 62

		#700 $finish;
	end

	initial begin
		$monitor("time =%0d, flick =%b, out_state = %d, led = %b", $time, flick, out_state, out);
	end

//	initial begin
//	reset = 0;
//	clk = 1;
//	flick = 1;
//	#10;
//	flick = 0;
//	for (i=0; i<200; i=i+1) 
//		begin
//			if (i==20) flick = 1;
//			if (i==40) flick = 0;
//			if (i==63) flick = 1;
//			if (i==80) flick = 0;
//			clk = ~clk;
//			#10;
//		end
//	#10;
//	$stop;
//	end

initial begin
  $recordfile ("waves");
  $recordvars ("depth=0", bound_flash_tb);
end

endmodule
