`timescale 1ns / 1ns
/*
vsim -L altera_mf_ver -L lpm_ver fetch_tb
*/

module fetch #(parameter bus_address = 6 /*2^6=64 lines*/, bus_data = 32)(
	input clk, jmp,
	input [bus_address-1:0] jmp_in,

	output reg [bus_data-1:0] data_out
	);

logic ena, rst;
assign ena = 1;
assign rst = 0;
reg [bus_address-1:0] address;
program_counter #(bus_address) program_counter_ (
	clk, rst, ena, jmp, jmp_in, 
	address
	);

wire read;
assign read = 1;
instructions instructions_ (address, ~clk, read, data_out);

endmodule

// --------------------------------------------------

module fetch_tb;
	localparam period = 10;
	localparam bus_address = 6;
	localparam bus_data = 32;
	int cycle = '1;

	// input
	logic clk, jmp;
	logic [bus_address-1:0] jmp_in;

	// output
	logic [bus_data-1:0] data_out;

	fetch #(bus_address, bus_data) UUT (clk, jmp, jmp_in, data_out);

	initial begin
		clk = 0;
		jmp = 0;
		jmp_in = 0;
	end

	always #(period/2) clk = !clk;

	always #period cycle++;

	initial begin
		repeat(5) #period;

		jmp = 1;
		jmp_in = 2;
		#period;
		jmp = 0;

		#(period/2)

		jmp = 1;
		jmp_in = 1;
		#period;
		jmp = 0;

		#(period/2)

		repeat(12) #period;

		$stop;
	end

endmodule
