`timescale 1ns / 1ps

module multiplier #(parameter bus = 4)(
	input [bus-1:0] a, b,

	output logic [bus-1:0] result,
	output logic overflow, zero, negative, carry_out
	);

// -------------------------------------------------- mul
logic [bus-1:0] extra;
assign {extra, carry_out, result} = a * b;
// -------------------------------------------------- flags
logic mul_nzero;
// overflow
assign mul_nzero = a != {bus{1'b0}};
assign overflow = mul_nzero? (result / a) != b : 1'b0;
// zero
assign zero = (a == {bus{1'b0}}) || (b == {bus{1'b0}});
// negative
assign negative = result[bus-1];

endmodule

// --------------------------------------------------

module multiplier_tb;
	localparam period = 10;
	parameter bus = 4;
	integer i, j;

	logic [bus-1:0] a;
	logic [bus-1:0] b;

	logic [bus-1:0] result;
	logic overflow, zero, negative, carry_out;

	multiplier #(bus) UUT (a, b, result, overflow, zero, negative, carry_out);

	initial begin
		// positive
		for (i=0; i<(2**bus); i++) begin
			a = i;
			for (j=0; j<(2**bus); j++) begin
				b = j; #period;
			end
		end

		// negative
		for (i=(2**bus)-1; i==0; i--) begin
			a = i;
			for (j=0; j<(2**bus); j++) begin
				b = j; #period;
			end
		end
	end

endmodule