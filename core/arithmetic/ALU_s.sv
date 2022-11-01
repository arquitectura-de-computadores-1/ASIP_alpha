`timescale 1ns / 1ps

module ALU_s #(parameter bus = 4, bus_selector = 4)(
	input logic [bus-1:0] a, b,
	input logic [bus_selector-1:0] selector,

	output logic [bus-1:0] result,
	output logic overflow, zero, negative, carry_out
	);

// -------------------------------------------------- operations
logic [bus-1:0] add_result, sub_result, mul_result;
logic add_v, add_z, add_n, add_c;
logic sub_v, sub_z, sub_n, sub_c;
logic mul_v, mul_z, mul_n, mul_c;
logic [1:0] operation;

assign operation = selector[1:0];

adder #(bus) adder_ (a, b, operation, add_result, add_v, add_z, add_n, add_c);
adder #(bus) subtract_ (a, b, operation, sub_result, sub_v, sub_z, sub_n, sub_c);
multiplier #(bus) multiplier_ (a, b, mul_result, mul_v, mul_z, mul_n, mul_c);

// -------------------------------------------------- MUX flags
mux_4 #(4) mux_ALU_flags (
	.d0({add_v, add_z, add_n, add_c}), 	// add
	.d1({sub_v, sub_z, sub_n, sub_c}), 	// sub
	.d2({mul_v, mul_z, mul_n, mul_c}), 	// mul
	.d3({mul_v, mul_z, mul_n, mul_c}), 	// div

	.selector(operation),
	.out({overflow, zero, negative, carry_out}));

// -------------------------------------------------- fix
// 

// -------------------------------------------------- MUX operations
mux_16 #(bus) mux_ALU (
	// arithmetic
	.d00(add_result),	// add
	.d01(sub_result),	// sub
	.d02(mul_result),	// mul
	.d03(mul_result),	// div
	// logic
	.d04(a & b),			// and
	.d05(a | b),			// or
	.d06(a ^ b),			// xor
	.d07(~(a & b)),			// nand
	.d08(~(a | b)),			// nor
	.d09(~(a ^ b)),			// xnor
	.d10(~a),				// not
	// fix
	.d11(a & b),
	.d12(a & b),
	.d13(a & b),
	.d14(a & b),
	.d15(a & b),
	// unused

	.selector(selector),
	.out(result));

endmodule

// --------------------------------------------------

module ALU_s_tb;
	localparam period = 10;
	parameter bus = 3, bus_selector = 4;
	integer i, j;

	logic [bus-1:0] a;
	logic [bus-1:0] b;
	logic [bus_selector-1:0] selector;

	logic [bus-1:0] result;
	logic overflow, zero, negative, carry_out;

	ALU_s #(bus) UUT (a, b, selector, result, overflow, zero, negative, carry_out);

	initial begin
		selector = 4'd0; // add
		// selector = 4'd1; // sub
		// selector = 4'd2; // mul
		// selector = 4'd3; // div
		// selector = 4'd4; // and
		// selector = 4'd5; // or
		// selector = 4'd6; // xor
		// selector = 4'd7; // nand
		// selector = 4'd8; // nor
		// selector = 4'd9; // xnor
		for (i=0; i<(2**bus); i++) begin
			a = i;
			for (j=0; j<(2**bus); j++) begin
				b = j; #period;
			end
		end

		// selector = 4'd10; // not
		// for (i=0; i<(2**bus); i++) begin
		// 	a = i; #period;
		// end
	end

endmodule