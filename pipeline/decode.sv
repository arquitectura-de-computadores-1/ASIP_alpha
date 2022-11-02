`timescale 1ns / 1ns
/*
vsim -L altera_mf_ver -L lpm_ver decode_tb
*/
module decode #(parameter address_bus = 4 /*2^4=16 lines*/, data_bus = 16)(
	input clk, write_a, write_b,
	input [address_bus-1:0] address_a, address_b,
	input [data_bus-1:0] data_in_a, data_in_b,

	output [data_bus-1:0] data_out_a, data_out_b
	);

register register_ (address_a, address_b, data_in_a, data_in_b, clk, ~clk, write_a, write_b, data_out_a, data_out_b);

endmodule

// --------------------------------------------------

module decode_tb;
	localparam period = 10;
	localparam address_bus = 4;
	localparam data_bus = 16;
	int i, cycle = 1;

	// input
	logic clk, write_in_a, write_in_b;
	logic [address_bus-1:0] address_a, address_b;
	logic [data_bus-1:0] data_in_a, data_in_b;

	// output
	logic [data_bus-1:0] data_out_a, data_out_b;

	decode UUT (
		clk, write_in_a, write_in_b,
		address_a, address_b,
		data_in_a, data_in_b,

		data_out_a, data_out_b
		);

	initial
	begin
		clk = 0;
		write_in_a = 0;
		address_a = 0;
		data_in_a = 0;
		write_in_b = 0;
		address_b = 0;
		data_in_b = 0;
	end

	always #(period/2) clk = !clk;

	always #period cycle++;

	initial
	begin

		// write a in register
		write_in_a = 1'b1;
		write_in_b = 1'b1;
		// write in +clk & +write
		for (i=0; i<5; i++) begin
			address_a = i;
			data_in_a = (i+1)*10;
			address_b = i;
			data_in_b = (i+1)*100;

			#period;
		end

		// read register
		write_in_a = 1'b0;
		write_in_b = 1'b0;
		// ask the written in +clk
		for (i=0; i<=5; i++) begin
			address_a = i;
			address_b = i;

			#period;
		end

		write_in_a = 1'b1;
		address_a = 0;
		data_in_a = 123;
		#(period/2);

		write_in_a = 1'b0;
		address_a = 0;
		#period;

		$stop;
	end

endmodule
