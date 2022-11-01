`timescale 1ns / 1ns

module mux_16 #(parameter bus = 4)(
    input [bus-1:0] d00,
    input [bus-1:0] d01,
    input [bus-1:0] d02,
    input [bus-1:0] d03,
    input [bus-1:0] d04,
    input [bus-1:0] d05,
    input [bus-1:0] d06,
    input [bus-1:0] d07,
    input [bus-1:0] d08,
    input [bus-1:0] d09,
    input [bus-1:0] d10,
    input [bus-1:0] d11,
    input [bus-1:0] d12,
    input [bus-1:0] d13,
    input [bus-1:0] d14,
    input [bus-1:0] d15,
    input [3:0] selector,

    output reg [bus-1:0] out
    );

always @(*) begin
    case (selector)
        4'b0000: out = d00;
        4'b0001: out = d01;
        4'b0010: out = d02;
        4'b0011: out = d03;
        4'b0100: out = d04;
        4'b0101: out = d05;
        4'b0110: out = d06;
        4'b0111: out = d07;
        4'b1000: out = d08;
        4'b1001: out = d09;
        4'b1010: out = d10;
        4'b1011: out = d11;
        4'b1100: out = d12;
        4'b1101: out = d13;
        4'b1110: out = d14;
        4'b1111: out = d15;
        // default : out = #;
    endcase
end

endmodule

// --------------------------------------------------

module mux_16_tb;   
    localparam period = 10;
    parameter bus = 4;
    integer i;

    // input
    logic [bus-1:0] d01;
    logic [bus-1:0] d02;
    logic [bus-1:0] d03;
    logic [bus-1:0] d04;
    logic [bus-1:0] d05;
    logic [bus-1:0] d06;
    logic [bus-1:0] d07;
    logic [bus-1:0] d08;
    logic [bus-1:0] d09;
    logic [bus-1:0] d10;
    logic [bus-1:0] d11;
    logic [bus-1:0] d12;
    logic [bus-1:0] d13;
    logic [bus-1:0] d14;
    logic [bus-1:0] d15;
    logic [bus-1:0] d16;
    logic [3:0]selector;

    // output
    reg [bus-1:0] out;

    mux_16 #(bus) UUT (d01, d02, d03, d04, d05, d06, d07, d08, 
        d09, d10, d11, d12, d13, d14, d15, d16, selector, out);

    initial begin

        d01 = 'b0000;
        d02 = 'b0001;
        d03 = 'b0010;
        d04 = 'b0011;
        d05 = 'b0100;
        d06 = 'b0101;
        d07 = 'b0110;
        d08 = 'b0111;
        d09 = 'b1000;
        d10 = 'b1001;
        d11 = 'b1010;
        d12 = 'b1011;
        d13 = 'b1100;
        d14 = 'b1101;
        d15 = 'b1110;
        d16 = 'b1111;

        for (i=0; i<16; i++) begin
            selector = i; #period;
        end

    end 

endmodule 