`timescale 1ns / 1ps

module adder #(parameter bus = 4)(
	input [bus-1:0] a, b,
	input logic [1:0] selector,

	output logic [bus-1:0] result,
	output logic overflow, zero, negative, carry_out
	);

// -------------------------------------------------- add
logic operation;
assign operation = selector == 2'b0 ? 1'b0 : 1'b1;
// -------------------------------------------------- flags
logic same_sign, sign;
// overflow
assign same_sign = ~(a[bus-1] ^ b[bus-1]);	// same signs verification
assign sign = a[bus-1] ^ result[bus-1];	// sign change verification
assign overflow = same_sign & sign;
// zero
assign zero = result == {bus{1'b0}};
// negative
assign negative = result[bus-1];

mux_2 #(bus+1) mux_adder (
	.d0({1'b0, a + b}), 	// add
	.d1({1'b0, a - b}), 	// sub

	.selector(operation),
	.out({carry_out, result}));

endmodule

// --------------------------------------------------

module adder_tb;
	localparam period = 10;
	parameter bus = 2;
	integer i, j;

	logic [bus-1:0] a;
	logic [bus-1:0] b;
	logic [1:0] selector;

	logic [bus-1:0] result;
	logic overflow, zero, negative, carry_out;

	adder #(bus) UUT (a, b, selector, result, overflow, zero, negative, carry_out);

	initial begin
		selector = 2'd0; // add
		for (i=0; i<(2**bus); i++) begin
			a = i;
			for (j=0; j<(2**bus); j++) begin
				b = j; #period;
			end
		end

		selector = 2'd1; // sub
		for (i=0; i<(2**bus); i++) begin
			a = i;
			for (j=0; j<(2**bus); j++) begin
				b = j; #period;
			end
		end
	end

endmodule