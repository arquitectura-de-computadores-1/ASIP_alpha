`timescale 1ns / 1ps

module switches (
	input clk,    

	input [2:0] select_color,    
	input [4:0] select_transparency,    

	output reg [2:0] color,     
	output reg [3:0] transparency,
	output reg [3:0] transparency_complement
	);

always @(posedge clk) begin
	case (select_color)
		3'd0: color = 3'd0; // black
		3'd1: color = 3'd1; // blue		*
		3'd2: color = 3'd2; // green	*
		3'd3: color = 3'd3; // magenta
		3'd4: color = 3'd4; // red		*
		3'd5: color = 3'd5; // cyan
		3'd6: color = 3'd6; // yellow
		3'd7: color = 3'd7; // white
	endcase
end

always @(posedge clk) begin
	case (select_transparency)
		5'b00001: begin
			transparency = 1;
			transparency_complement = 0;
		end
		5'b00010: begin
			transparency = 0.75;
			transparency_complement = 0.25;
		end
		5'b00100: begin
			transparency = 0.5;
			transparency_complement = 0.5;
		end
		5'b01000: begin
			transparency = 0.25;
			transparency_complement = 0.75;
		end
		5'b10000: begin
			transparency = 0;
			transparency_complement = 1;
		end
		default: begin
			transparency = 1;
			transparency_complement = 0;
		end
	endcase
end

endmodule

// --------------------------------------------------

module switches_tb;
	integer i, j;

	logic clk,    
	logic [1:0] select_color,    
	logic [4:0] select_transparency,    
	logic [2:0] color,     
	logic [3:0] transparency,
	logic [3:0] transparency_complement

	switches UUT (clk, select_color, select_transparency, color, transparency, transparency_complement);

	initial begin
		select_color = 2'd1; 
		
		if (color) begin
			/* code */
		end

	end

endmodule