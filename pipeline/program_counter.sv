`timescale 1ns / 1ns

module program_counter #(parameter bus_counter = 5)(
	input clk, rst, ena, jmp,
	input [bus_counter-1:0] jmp_in,

	output reg [bus_counter-1:0] count
	);

reg jump;

initial begin
	count = 0;
	jump = 0;
end

always @(negedge clk) begin
	if (jmp) begin
		jump = 1;
	end
	if (rst)
		count <= {bus_counter{1'b1}};
	else begin
		if (ena) begin
			if (jump) begin
				count <= jmp_in;
				jump = 0;
			end
			else
				count++;
		end
	end
end

endmodule

// --------------------------------------------------

module program_counter_tb;
	localparam period = 10;
	parameter bus_counter = 5;

	// input
	logic clk, rst, ena, jmp;
	logic [bus_counter-1:0] jmp_in;

	// output
	reg [bus_counter-1:0] count;

	program_counter #(bus_counter) UUT (clk, rst, ena, jmp, jmp_in, count);

	initial begin
		clk = 0;
		rst = 0;
		ena = 1;
		jmp = 0;
		jmp_in = 0;
	end

	always begin
		clk = ~clk; #(period/2);
	end

	initial begin
		repeat(10) #period;

		jmp = 1;
		jmp_in = 5;
		#period;

		jmp = 0;
		repeat(5) #period;

		#(period/2);
		jmp = 1;
		jmp_in = 1;
		#period;

		jmp = 0;
		ena = 0;
		repeat(5) #period;

		$stop;
	end

endmodule