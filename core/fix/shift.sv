`timescale 1ns/1ps

module shift #(parameter bus = 4)(
	input logic [bus-1:0] a,
	input logic shift_count,
	input logic dir,
	
	output logic [bus-1:0] y
	);

always @(*) begin
	if (dir)
		y = a >> shift_count;
	else
		y = a << shift_count;
end

endmodule  

// ----------------------------------------------------------------------------------------------------

module shift_tb;
	
	localparam period = 20;

	parameter bus = 4;
	parameter bus_shift = $clog2(bus);

	logic [bus-1:0] a;
	logic [bus_shift-1:0] shift_count;
	logic dir;
	
	logic [bus-1:0] y;

	shift #(bus) DUT (a, shift_count, dir, y);  

	initial begin
		a = 4'b0001;
		dir = 0;

		shift_count = 2'b00; #period;
		shift_count = 2'b01; #period;
		shift_count = 2'b10; #period;
		shift_count = 2'b11; #period;

		a = 4'b1000;
		dir = 1;
		
		shift_count = 2'b00; #period;
		shift_count = 2'b01; #period;
		shift_count = 2'b10; #period;
		shift_count = 2'b11; #period;
	end  

endmodule 