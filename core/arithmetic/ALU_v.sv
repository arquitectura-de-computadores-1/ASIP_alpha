`timescale 1ns / 1ps

module ALU_v #(parameter vector = 4, bus = 4, bus_selector = 4)(
	input logic [vector-1:0][bus-1:0] a, b,
	input logic [bus_selector-1:0] selector,

	output logic [vector-1:0][bus-1:0] result,
	output logic [vector-1:0] carry_out
	);

// -------------------------------------------------- operations
logic [vector-1:0][bus-1:0] add_result, sub_result, mul_result;
logic [vector-1:0] add_c, sub_c, mul_c;
logic [1:0] operation;

assign operation = selector[1:0];

adder #(bus) adder_v0 (a[0], b[0], operation, add_result[0], , , , add_c[0]);
adder #(bus) adder_v1 (a[1], b[1], operation, add_result[1], , , , add_c[1]);
adder #(bus) adder_v2 (a[2], b[2], operation, add_result[2], , , , add_c[2]);
adder #(bus) adder_v3 (a[3], b[3], operation, add_result[3], , , , add_c[3]);

adder #(bus) adder_v4 (a[0], b[0], operation, sub_result[0], , , , sub_c[0]);
adder #(bus) adder_v5 (a[1], b[1], operation, sub_result[1], , , , sub_c[1]);
adder #(bus) adder_v6 (a[2], b[2], operation, sub_result[2], , , , sub_c[2]);
adder #(bus) adder_v7 (a[3], b[3], operation, sub_result[3], , , , sub_c[3]);

multiplier #(bus) multiplier_v0 (a[0], b[0], mul_result[0], , , , mul_c[0]);
multiplier #(bus) multiplier_v1 (a[1], b[1], mul_result[1], , , , mul_c[1]);
multiplier #(bus) multiplier_v2 (a[2], b[2], mul_result[2], , , , mul_c[2]);
multiplier #(bus) multiplier_v3 (a[3], b[3], mul_result[3], , , , mul_c[3]);

// -------------------------------------------------- MUX flags
mux_4 #(4) mux_ALU_flags_v (
	.d0({add_c[0], add_c[1], add_c[2], add_c[3]}), 	// add
	.d1({sub_c[0], sub_c[1], sub_c[2], sub_c[3]}), 	// sub
	.d2({mul_c[0], mul_c[1], mul_c[2], mul_c[3]}), 	// mul
	.d3({sub_c[0], sub_c[1], sub_c[2], sub_c[3]}), 	// sub

	.selector(operation),
	.out(carry_out));

// -------------------------------------------------- MUX operations
mux_4 #(vector*bus) mux_ALU_v (
	.d0({add_result[0], add_result[1], add_result[2], add_result[3]}), 	// add
	.d1({sub_result[0], sub_result[1], sub_result[2], sub_result[3]}), 	// sub
	.d2({mul_result[0], mul_result[1], mul_result[2], mul_result[3]}), 	// mul
	.d3({vector*bus{1'b0}}),	// div

	.selector(operation),
	.out({result[0], result[1], result[2], result[3]}));

endmodule

// --------------------------------------------------

module ALU_v_tb;
	localparam period = 10;
	parameter vector = 4, bus = 3, bus_selector = 4;
	integer i, j;

	logic [vector-1:0][bus-1:0] a;
	logic [vector-1:0][bus-1:0] b;
	logic [bus_selector-1:0] selector;

	logic [vector-1:0][bus-1:0] result;
	logic [vector-1:0] carry_out;

	ALU_v #(vector, bus) UUT (a, b, selector, result, carry_out);

	initial begin
		selector = 4'd0; // add
		// selector = 4'd1; // sub
		// selector = 4'd2; // mul
		for (i=0; i<(2**bus); i++) begin
			a[3] = i*0;
			a[2] = i*1;
			a[1] = i*2;
			a[0] = i*3;
			for (j=0; j<(2**bus); j++) begin
				b[0] = j;
				b[1] = j;
				b[2] = j;
				b[3] = j;
				#period;
			end
		end
	end

endmodule