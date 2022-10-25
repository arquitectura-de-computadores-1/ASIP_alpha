`timescale 1ns / 1ns

module mux_4 #(parameter bus = 4)(
    input [bus-1:0] d0,
    input [bus-1:0] d1,
    input [bus-1:0] d2,
    input [bus-1:0] d3,
    input [1:0] selector,

    output reg [bus-1:0] out
    );

always @(*) begin
    case (selector)
        2'b00: out = d0;
        2'b01: out = d1;
        2'b10: out = d2;
        2'b11: out = d3;
        // default : out = #;
    endcase
end

endmodule

// --------------------------------------------------

module mux_4_tb;   
    localparam period = 10;
    parameter bus = 4;
    integer i;

    // input
    logic [bus-1:0] d0;
    logic [bus-1:0] d1;
    logic [bus-1:0] d2;
    logic [bus-1:0] d3;
    logic [1:0] selector;

    // output
    reg [bus-1:0] out;

    mux_4 #(bus) UUT (d0, d1, d2, d3, selector, out);

    initial begin

        d0 = 'b1111;
        d1 = 'b1010;
        d2 = 'b1100;
        d3 = 'b0011;

        for (i=0; i<4; i++) begin
            selector = i; #period;
        end

    end 

endmodule 
