`timescale 1ns / 1ns

module mux_2 #(parameter bus = 4)(
	input [bus-1:0] d0,
	input [bus-1:0] d1,
	input selector,

	output reg [bus-1:0] out
	);

always @(*) begin
	case (selector)
		1'b0: out = d0;
		1'b1: out = d1;
        // default : out = #;
	endcase
end

endmodule

// --------------------------------------------------

module mux_2_tb;   
	localparam period = 10;
	parameter bus = 4;

	// input
	logic [bus-1:0] d0;
	logic [bus-1:0] d1;
	logic selector;

	// output
	reg [bus-1:0] out;

	mux_2 #(bus) UUT (d0, d1, selector, out);

	initial begin

		d0 = 'b1111;
		d1 = 'b1010;

		selector = 1'b0; #period;
		selector = 1'b1; #period;

	end 

endmodule 