`timescale 1ns / 1ps

module adder_v #(parameter bus = 4)(
	input logic [bus-1:0] a, b,
	input logic [1:0] selector,

	output logic [bus-1:0] result,
	output logic carry_out
	);

logic operation;
assign operation = selector == 2'b0 ? 1'b0 : 1'b1;

mux_2 #(bus+1) mux_adder_v (
	.d0({1'b0, a + b}),	// add
	.d1({1'b0, a - b}),	// sub

	.selector(operation),
	.out({carry_out, result}));

endmodule