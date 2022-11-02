`timescale 1ns / 1ps

module ALU_fp_tb;
	localparam period = 10;
	parameter bus = 4, bus_fraction = 32;
	integer i, j;
	integer faded = 0.5;

	// integer a, b;
	// integer result;
	logic [31:0] a, b;
	logic [31:0] result;
	
	logic [31:0] round;

	logic [3:0] selector;

	logic zero;

	ALU_fp UUT (a, b, selector, result);

	initial begin
		selector = 4'd0; // add
		// for (i=250; i<256; i++) begin
		// 	a = i * 1.0;
		// 	for (j=0; j<10; j++) begin
		// 		b = j/10.0; 
		// 		round = result;
		// 		#period;
		// 	end
		// end

		// selector = 2'd1; // sub
		// for (i=0; i<(2**bus); i++) begin
		// 	a = i;
		// 	for (j=0; j<(2**bus); j++) begin
		// 		b = j; #period;
		// 	end
		// end
		
		a = 127.5;
		b = 0.6;
		round = int'(result);
		#period;

	end

endmodule