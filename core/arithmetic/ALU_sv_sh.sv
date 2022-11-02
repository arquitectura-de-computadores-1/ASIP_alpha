`timescale 1ns / 1ps

module ALU_sv_sh #(parameter vector = 8, bus = 24, bus_selector = 4, bus_color = 8, 
	bus_color_r_msb = 23, bus_color_r_lsb = 16, 
	bus_color_g_msb = 15, bus_color_g_lsb = 8, 
	bus_color_b_msb = 7, bus_color_b_lsb = 0)(
	input logic [bus_color-1:0] s,
	input logic [vector-1:0][bus-1:0] v,
	input logic [bus_selector-1:0] selector,
	input logic [2:0] color_flag,

	output logic [vector-1:0][bus-1:0] result,
	output logic [vector-1:0] carry_out
	);

// -------------------------------------------------- operations
logic [vector-1:0][bus_color-1:0] color;
logic [vector-1:0][bus_color-1:0] result_add, result_sub, result_mul;
logic [vector-1:0] add_c, sub_c, mul_c;
logic [1:0] operation;

assign operation = selector[1:0];

always @(*) begin
	case (color_flag)
		3'b100: begin
			color[0] = v[0][bus_color_r_msb:bus_color_r_lsb];
			color[1] = v[1][bus_color_r_msb:bus_color_r_lsb];
			color[2] = v[2][bus_color_r_msb:bus_color_r_lsb];
			color[3] = v[3][bus_color_r_msb:bus_color_r_lsb];
			color[4] = v[4][bus_color_r_msb:bus_color_r_lsb];
			color[5] = v[5][bus_color_r_msb:bus_color_r_lsb];
			color[6] = v[6][bus_color_r_msb:bus_color_r_lsb];
			color[7] = v[7][bus_color_r_msb:bus_color_r_lsb];
		end
		3'b010: begin
			color[0] = v[0][bus_color_g_msb:bus_color_g_lsb];
			color[1] = v[1][bus_color_g_msb:bus_color_g_lsb];
			color[2] = v[2][bus_color_g_msb:bus_color_g_lsb];
			color[3] = v[3][bus_color_g_msb:bus_color_g_lsb];
			color[4] = v[4][bus_color_g_msb:bus_color_g_lsb];
			color[5] = v[5][bus_color_g_msb:bus_color_g_lsb];
			color[6] = v[6][bus_color_g_msb:bus_color_g_lsb];
			color[7] = v[7][bus_color_g_msb:bus_color_g_lsb];
		end
		3'b001: begin
			color[0] = v[0][bus_color_b_msb:bus_color_b_lsb];
			color[1] = v[1][bus_color_b_msb:bus_color_b_lsb];
			color[2] = v[2][bus_color_b_msb:bus_color_b_lsb];
			color[3] = v[3][bus_color_b_msb:bus_color_b_lsb];
			color[4] = v[4][bus_color_b_msb:bus_color_b_lsb];
			color[5] = v[5][bus_color_b_msb:bus_color_b_lsb];
			color[6] = v[6][bus_color_b_msb:bus_color_b_lsb];
			color[7] = v[7][bus_color_b_msb:bus_color_b_lsb];
		end
	endcase
end

always @(*) begin
	case (color_flag)
		3'b100: begin
			case (operation)
				2'd0: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = result_add[0];
					result[1][bus_color_r_msb:bus_color_r_lsb] = result_add[1];
					result[2][bus_color_r_msb:bus_color_r_lsb] = result_add[2];
					result[3][bus_color_r_msb:bus_color_r_lsb] = result_add[3];
					result[4][bus_color_r_msb:bus_color_r_lsb] = result_add[4];
					result[5][bus_color_r_msb:bus_color_r_lsb] = result_add[5];
					result[6][bus_color_r_msb:bus_color_r_lsb] = result_add[6];
					result[7][bus_color_r_msb:bus_color_r_lsb] = result_add[7];

					result[0][bus_color_g_msb:bus_color_g_lsb] = v[0][bus_color_g_msb:bus_color_g_lsb];
					result[1][bus_color_g_msb:bus_color_g_lsb] = v[1][bus_color_g_msb:bus_color_g_lsb];
					result[2][bus_color_g_msb:bus_color_g_lsb] = v[2][bus_color_g_msb:bus_color_g_lsb];
					result[3][bus_color_g_msb:bus_color_g_lsb] = v[3][bus_color_g_msb:bus_color_g_lsb];
					result[4][bus_color_g_msb:bus_color_g_lsb] = v[4][bus_color_g_msb:bus_color_g_lsb];
					result[5][bus_color_g_msb:bus_color_g_lsb] = v[5][bus_color_g_msb:bus_color_g_lsb];
					result[6][bus_color_g_msb:bus_color_g_lsb] = v[6][bus_color_g_msb:bus_color_g_lsb];
					result[7][bus_color_g_msb:bus_color_g_lsb] = v[7][bus_color_g_msb:bus_color_g_lsb];

					result[0][bus_color_b_msb:bus_color_b_lsb] = v[0][bus_color_b_msb:bus_color_b_lsb];
					result[1][bus_color_b_msb:bus_color_b_lsb] = v[1][bus_color_b_msb:bus_color_b_lsb];
					result[2][bus_color_b_msb:bus_color_b_lsb] = v[2][bus_color_b_msb:bus_color_b_lsb];
					result[3][bus_color_b_msb:bus_color_b_lsb] = v[3][bus_color_b_msb:bus_color_b_lsb];
					result[4][bus_color_b_msb:bus_color_b_lsb] = v[4][bus_color_b_msb:bus_color_b_lsb];
					result[5][bus_color_b_msb:bus_color_b_lsb] = v[5][bus_color_b_msb:bus_color_b_lsb];
					result[6][bus_color_b_msb:bus_color_b_lsb] = v[6][bus_color_b_msb:bus_color_b_lsb];
					result[7][bus_color_b_msb:bus_color_b_lsb] = v[7][bus_color_b_msb:bus_color_b_lsb];
				end
				2'd1: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = result_sub[0];
					result[1][bus_color_r_msb:bus_color_r_lsb] = result_sub[1];
					result[2][bus_color_r_msb:bus_color_r_lsb] = result_sub[2];
					result[3][bus_color_r_msb:bus_color_r_lsb] = result_sub[3];
					result[4][bus_color_r_msb:bus_color_r_lsb] = result_sub[4];
					result[5][bus_color_r_msb:bus_color_r_lsb] = result_sub[5];
					result[6][bus_color_r_msb:bus_color_r_lsb] = result_sub[6];
					result[7][bus_color_r_msb:bus_color_r_lsb] = result_sub[7];

					result[0][bus_color_g_msb:bus_color_g_lsb] = v[0][bus_color_g_msb:bus_color_g_lsb];
					result[1][bus_color_g_msb:bus_color_g_lsb] = v[1][bus_color_g_msb:bus_color_g_lsb];
					result[2][bus_color_g_msb:bus_color_g_lsb] = v[2][bus_color_g_msb:bus_color_g_lsb];
					result[3][bus_color_g_msb:bus_color_g_lsb] = v[3][bus_color_g_msb:bus_color_g_lsb];
					result[4][bus_color_g_msb:bus_color_g_lsb] = v[4][bus_color_g_msb:bus_color_g_lsb];
					result[5][bus_color_g_msb:bus_color_g_lsb] = v[5][bus_color_g_msb:bus_color_g_lsb];
					result[6][bus_color_g_msb:bus_color_g_lsb] = v[6][bus_color_g_msb:bus_color_g_lsb];
					result[7][bus_color_g_msb:bus_color_g_lsb] = v[7][bus_color_g_msb:bus_color_g_lsb];
					
					result[0][bus_color_b_msb:bus_color_b_lsb] = v[0][bus_color_b_msb:bus_color_b_lsb];
					result[1][bus_color_b_msb:bus_color_b_lsb] = v[1][bus_color_b_msb:bus_color_b_lsb];
					result[2][bus_color_b_msb:bus_color_b_lsb] = v[2][bus_color_b_msb:bus_color_b_lsb];
					result[3][bus_color_b_msb:bus_color_b_lsb] = v[3][bus_color_b_msb:bus_color_b_lsb];
					result[4][bus_color_b_msb:bus_color_b_lsb] = v[4][bus_color_b_msb:bus_color_b_lsb];
					result[5][bus_color_b_msb:bus_color_b_lsb] = v[5][bus_color_b_msb:bus_color_b_lsb];
					result[6][bus_color_b_msb:bus_color_b_lsb] = v[6][bus_color_b_msb:bus_color_b_lsb];
					result[7][bus_color_b_msb:bus_color_b_lsb] = v[7][bus_color_b_msb:bus_color_b_lsb];
				end
				2'd2: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = result_mul[0];
					result[1][bus_color_r_msb:bus_color_r_lsb] = result_mul[1];
					result[2][bus_color_r_msb:bus_color_r_lsb] = result_mul[2];
					result[3][bus_color_r_msb:bus_color_r_lsb] = result_mul[3];
					result[4][bus_color_r_msb:bus_color_r_lsb] = result_mul[4];
					result[5][bus_color_r_msb:bus_color_r_lsb] = result_mul[5];
					result[6][bus_color_r_msb:bus_color_r_lsb] = result_mul[6];
					result[7][bus_color_r_msb:bus_color_r_lsb] = result_mul[7];

					result[0][bus_color_g_msb:bus_color_g_lsb] = v[0][bus_color_g_msb:bus_color_g_lsb];
					result[1][bus_color_g_msb:bus_color_g_lsb] = v[1][bus_color_g_msb:bus_color_g_lsb];
					result[2][bus_color_g_msb:bus_color_g_lsb] = v[2][bus_color_g_msb:bus_color_g_lsb];
					result[3][bus_color_g_msb:bus_color_g_lsb] = v[3][bus_color_g_msb:bus_color_g_lsb];
					result[4][bus_color_g_msb:bus_color_g_lsb] = v[4][bus_color_g_msb:bus_color_g_lsb];
					result[5][bus_color_g_msb:bus_color_g_lsb] = v[5][bus_color_g_msb:bus_color_g_lsb];
					result[6][bus_color_g_msb:bus_color_g_lsb] = v[6][bus_color_g_msb:bus_color_g_lsb];
					result[7][bus_color_g_msb:bus_color_g_lsb] = v[7][bus_color_g_msb:bus_color_g_lsb];
					
					result[0][bus_color_b_msb:bus_color_b_lsb] = v[0][bus_color_b_msb:bus_color_b_lsb];
					result[1][bus_color_b_msb:bus_color_b_lsb] = v[1][bus_color_b_msb:bus_color_b_lsb];
					result[2][bus_color_b_msb:bus_color_b_lsb] = v[2][bus_color_b_msb:bus_color_b_lsb];
					result[3][bus_color_b_msb:bus_color_b_lsb] = v[3][bus_color_b_msb:bus_color_b_lsb];
					result[4][bus_color_b_msb:bus_color_b_lsb] = v[4][bus_color_b_msb:bus_color_b_lsb];
					result[5][bus_color_b_msb:bus_color_b_lsb] = v[5][bus_color_b_msb:bus_color_b_lsb];
					result[6][bus_color_b_msb:bus_color_b_lsb] = v[6][bus_color_b_msb:bus_color_b_lsb];
					result[7][bus_color_b_msb:bus_color_b_lsb] = v[7][bus_color_b_msb:bus_color_b_lsb];
				end
			endcase
		end
		3'b010: begin
			case (operation)
				2'd0: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = v[0][bus_color_r_msb:bus_color_r_lsb];
					result[1][bus_color_r_msb:bus_color_r_lsb] = v[1][bus_color_r_msb:bus_color_r_lsb];
					result[2][bus_color_r_msb:bus_color_r_lsb] = v[2][bus_color_r_msb:bus_color_r_lsb];
					result[3][bus_color_r_msb:bus_color_r_lsb] = v[3][bus_color_r_msb:bus_color_r_lsb];
					result[4][bus_color_r_msb:bus_color_r_lsb] = v[4][bus_color_r_msb:bus_color_r_lsb];
					result[5][bus_color_r_msb:bus_color_r_lsb] = v[5][bus_color_r_msb:bus_color_r_lsb];
					result[6][bus_color_r_msb:bus_color_r_lsb] = v[6][bus_color_r_msb:bus_color_r_lsb];
					result[7][bus_color_r_msb:bus_color_r_lsb] = v[7][bus_color_r_msb:bus_color_r_lsb];

					result[0][bus_color_g_msb:bus_color_g_lsb] = result_add[0];
					result[1][bus_color_g_msb:bus_color_g_lsb] = result_add[1];
					result[2][bus_color_g_msb:bus_color_g_lsb] = result_add[2];
					result[3][bus_color_g_msb:bus_color_g_lsb] = result_add[3];
					result[4][bus_color_g_msb:bus_color_g_lsb] = result_add[4];
					result[5][bus_color_g_msb:bus_color_g_lsb] = result_add[5];
					result[6][bus_color_g_msb:bus_color_g_lsb] = result_add[6];
					result[7][bus_color_g_msb:bus_color_g_lsb] = result_add[7];

					result[0][bus_color_b_msb:bus_color_b_lsb] = v[0][bus_color_b_msb:bus_color_b_lsb];
					result[1][bus_color_b_msb:bus_color_b_lsb] = v[1][bus_color_b_msb:bus_color_b_lsb];
					result[2][bus_color_b_msb:bus_color_b_lsb] = v[2][bus_color_b_msb:bus_color_b_lsb];
					result[3][bus_color_b_msb:bus_color_b_lsb] = v[3][bus_color_b_msb:bus_color_b_lsb];
					result[4][bus_color_b_msb:bus_color_b_lsb] = v[4][bus_color_b_msb:bus_color_b_lsb];
					result[5][bus_color_b_msb:bus_color_b_lsb] = v[5][bus_color_b_msb:bus_color_b_lsb];
					result[6][bus_color_b_msb:bus_color_b_lsb] = v[6][bus_color_b_msb:bus_color_b_lsb];
					result[7][bus_color_b_msb:bus_color_b_lsb] = v[7][bus_color_b_msb:bus_color_b_lsb];
				end
				2'd1: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = v[0][bus_color_r_msb:bus_color_r_lsb];
					result[1][bus_color_r_msb:bus_color_r_lsb] = v[1][bus_color_r_msb:bus_color_r_lsb];
					result[2][bus_color_r_msb:bus_color_r_lsb] = v[2][bus_color_r_msb:bus_color_r_lsb];
					result[3][bus_color_r_msb:bus_color_r_lsb] = v[3][bus_color_r_msb:bus_color_r_lsb];
					result[4][bus_color_r_msb:bus_color_r_lsb] = v[4][bus_color_r_msb:bus_color_r_lsb];
					result[5][bus_color_r_msb:bus_color_r_lsb] = v[5][bus_color_r_msb:bus_color_r_lsb];
					result[6][bus_color_r_msb:bus_color_r_lsb] = v[6][bus_color_r_msb:bus_color_r_lsb];
					result[7][bus_color_r_msb:bus_color_r_lsb] = v[7][bus_color_r_msb:bus_color_r_lsb];

					result[0][bus_color_g_msb:bus_color_g_lsb] = result_sub[0];
					result[1][bus_color_g_msb:bus_color_g_lsb] = result_sub[1];
					result[2][bus_color_g_msb:bus_color_g_lsb] = result_sub[2];
					result[3][bus_color_g_msb:bus_color_g_lsb] = result_sub[3];
					result[4][bus_color_g_msb:bus_color_g_lsb] = result_sub[4];
					result[5][bus_color_g_msb:bus_color_g_lsb] = result_sub[5];
					result[6][bus_color_g_msb:bus_color_g_lsb] = result_sub[6];
					result[7][bus_color_g_msb:bus_color_g_lsb] = result_sub[7];

					result[0][bus_color_b_msb:bus_color_b_lsb] = v[0][bus_color_b_msb:bus_color_b_lsb];
					result[1][bus_color_b_msb:bus_color_b_lsb] = v[1][bus_color_b_msb:bus_color_b_lsb];
					result[2][bus_color_b_msb:bus_color_b_lsb] = v[2][bus_color_b_msb:bus_color_b_lsb];
					result[3][bus_color_b_msb:bus_color_b_lsb] = v[3][bus_color_b_msb:bus_color_b_lsb];
					result[4][bus_color_b_msb:bus_color_b_lsb] = v[4][bus_color_b_msb:bus_color_b_lsb];
					result[5][bus_color_b_msb:bus_color_b_lsb] = v[5][bus_color_b_msb:bus_color_b_lsb];
					result[6][bus_color_b_msb:bus_color_b_lsb] = v[6][bus_color_b_msb:bus_color_b_lsb];
					result[7][bus_color_b_msb:bus_color_b_lsb] = v[7][bus_color_b_msb:bus_color_b_lsb];
				end
				2'd2: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = v[0][bus_color_r_msb:bus_color_r_lsb];
					result[1][bus_color_r_msb:bus_color_r_lsb] = v[1][bus_color_r_msb:bus_color_r_lsb];
					result[2][bus_color_r_msb:bus_color_r_lsb] = v[2][bus_color_r_msb:bus_color_r_lsb];
					result[3][bus_color_r_msb:bus_color_r_lsb] = v[3][bus_color_r_msb:bus_color_r_lsb];
					result[4][bus_color_r_msb:bus_color_r_lsb] = v[4][bus_color_r_msb:bus_color_r_lsb];
					result[5][bus_color_r_msb:bus_color_r_lsb] = v[5][bus_color_r_msb:bus_color_r_lsb];
					result[6][bus_color_r_msb:bus_color_r_lsb] = v[6][bus_color_r_msb:bus_color_r_lsb];
					result[7][bus_color_r_msb:bus_color_r_lsb] = v[7][bus_color_r_msb:bus_color_r_lsb];

					result[0][bus_color_g_msb:bus_color_g_lsb] = result_mul[0];
					result[1][bus_color_g_msb:bus_color_g_lsb] = result_mul[1];
					result[2][bus_color_g_msb:bus_color_g_lsb] = result_mul[2];
					result[3][bus_color_g_msb:bus_color_g_lsb] = result_mul[3];
					result[4][bus_color_g_msb:bus_color_g_lsb] = result_mul[4];
					result[5][bus_color_g_msb:bus_color_g_lsb] = result_mul[5];
					result[6][bus_color_g_msb:bus_color_g_lsb] = result_mul[6];
					result[7][bus_color_g_msb:bus_color_g_lsb] = result_mul[7];

					result[0][bus_color_b_msb:bus_color_b_lsb] = v[0][bus_color_b_msb:bus_color_b_lsb];
					result[1][bus_color_b_msb:bus_color_b_lsb] = v[1][bus_color_b_msb:bus_color_b_lsb];
					result[2][bus_color_b_msb:bus_color_b_lsb] = v[2][bus_color_b_msb:bus_color_b_lsb];
					result[3][bus_color_b_msb:bus_color_b_lsb] = v[3][bus_color_b_msb:bus_color_b_lsb];
					result[4][bus_color_b_msb:bus_color_b_lsb] = v[4][bus_color_b_msb:bus_color_b_lsb];
					result[5][bus_color_b_msb:bus_color_b_lsb] = v[5][bus_color_b_msb:bus_color_b_lsb];
					result[6][bus_color_b_msb:bus_color_b_lsb] = v[6][bus_color_b_msb:bus_color_b_lsb];
					result[7][bus_color_b_msb:bus_color_b_lsb] = v[7][bus_color_b_msb:bus_color_b_lsb];
				end
			endcase
		end
		3'b001: begin
			case (operation)
				2'd0: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = v[0][bus_color_r_msb:bus_color_r_lsb];
					result[1][bus_color_r_msb:bus_color_r_lsb] = v[1][bus_color_r_msb:bus_color_r_lsb];
					result[2][bus_color_r_msb:bus_color_r_lsb] = v[2][bus_color_r_msb:bus_color_r_lsb];
					result[3][bus_color_r_msb:bus_color_r_lsb] = v[3][bus_color_r_msb:bus_color_r_lsb];
					result[4][bus_color_r_msb:bus_color_r_lsb] = v[4][bus_color_r_msb:bus_color_r_lsb];
					result[5][bus_color_r_msb:bus_color_r_lsb] = v[5][bus_color_r_msb:bus_color_r_lsb];
					result[6][bus_color_r_msb:bus_color_r_lsb] = v[6][bus_color_r_msb:bus_color_r_lsb];
					result[7][bus_color_r_msb:bus_color_r_lsb] = v[7][bus_color_r_msb:bus_color_r_lsb];

					result[0][bus_color_g_msb:bus_color_g_lsb] = v[0][bus_color_g_msb:bus_color_g_lsb];
					result[1][bus_color_g_msb:bus_color_g_lsb] = v[1][bus_color_g_msb:bus_color_g_lsb];
					result[2][bus_color_g_msb:bus_color_g_lsb] = v[2][bus_color_g_msb:bus_color_g_lsb];
					result[3][bus_color_g_msb:bus_color_g_lsb] = v[3][bus_color_g_msb:bus_color_g_lsb];
					result[4][bus_color_g_msb:bus_color_g_lsb] = v[4][bus_color_g_msb:bus_color_g_lsb];
					result[5][bus_color_g_msb:bus_color_g_lsb] = v[5][bus_color_g_msb:bus_color_g_lsb];
					result[6][bus_color_g_msb:bus_color_g_lsb] = v[6][bus_color_g_msb:bus_color_g_lsb];
					result[7][bus_color_g_msb:bus_color_g_lsb] = v[7][bus_color_g_msb:bus_color_g_lsb];

					result[0][bus_color_b_msb:bus_color_b_lsb] = result_add[0];
					result[1][bus_color_b_msb:bus_color_b_lsb] = result_add[1];
					result[2][bus_color_b_msb:bus_color_b_lsb] = result_add[2];
					result[3][bus_color_b_msb:bus_color_b_lsb] = result_add[3];
					result[4][bus_color_b_msb:bus_color_b_lsb] = result_add[4];
					result[5][bus_color_b_msb:bus_color_b_lsb] = result_add[5];
					result[6][bus_color_b_msb:bus_color_b_lsb] = result_add[6];
					result[7][bus_color_b_msb:bus_color_b_lsb] = result_add[7];
				end
				2'd1: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = v[0][bus_color_r_msb:bus_color_r_lsb];
					result[1][bus_color_r_msb:bus_color_r_lsb] = v[1][bus_color_r_msb:bus_color_r_lsb];
					result[2][bus_color_r_msb:bus_color_r_lsb] = v[2][bus_color_r_msb:bus_color_r_lsb];
					result[3][bus_color_r_msb:bus_color_r_lsb] = v[3][bus_color_r_msb:bus_color_r_lsb];
					result[4][bus_color_r_msb:bus_color_r_lsb] = v[4][bus_color_r_msb:bus_color_r_lsb];
					result[5][bus_color_r_msb:bus_color_r_lsb] = v[5][bus_color_r_msb:bus_color_r_lsb];
					result[6][bus_color_r_msb:bus_color_r_lsb] = v[6][bus_color_r_msb:bus_color_r_lsb];
					result[7][bus_color_r_msb:bus_color_r_lsb] = v[7][bus_color_r_msb:bus_color_r_lsb];

					result[0][bus_color_g_msb:bus_color_g_lsb] = v[0][bus_color_g_msb:bus_color_g_lsb];
					result[1][bus_color_g_msb:bus_color_g_lsb] = v[1][bus_color_g_msb:bus_color_g_lsb];
					result[2][bus_color_g_msb:bus_color_g_lsb] = v[2][bus_color_g_msb:bus_color_g_lsb];
					result[3][bus_color_g_msb:bus_color_g_lsb] = v[3][bus_color_g_msb:bus_color_g_lsb];
					result[4][bus_color_g_msb:bus_color_g_lsb] = v[4][bus_color_g_msb:bus_color_g_lsb];
					result[5][bus_color_g_msb:bus_color_g_lsb] = v[5][bus_color_g_msb:bus_color_g_lsb];
					result[6][bus_color_g_msb:bus_color_g_lsb] = v[6][bus_color_g_msb:bus_color_g_lsb];
					result[7][bus_color_g_msb:bus_color_g_lsb] = v[7][bus_color_g_msb:bus_color_g_lsb];

					result[0][bus_color_b_msb:bus_color_b_lsb] = result_sub[0];
					result[1][bus_color_b_msb:bus_color_b_lsb] = result_sub[1];
					result[2][bus_color_b_msb:bus_color_b_lsb] = result_sub[2];
					result[3][bus_color_b_msb:bus_color_b_lsb] = result_sub[3];
					result[4][bus_color_b_msb:bus_color_b_lsb] = result_sub[4];
					result[5][bus_color_b_msb:bus_color_b_lsb] = result_sub[5];
					result[6][bus_color_b_msb:bus_color_b_lsb] = result_sub[6];
					result[7][bus_color_b_msb:bus_color_b_lsb] = result_sub[7];
				end
				2'd2: begin
					result[0][bus_color_r_msb:bus_color_r_lsb] = v[0][bus_color_r_msb:bus_color_r_lsb];
					result[1][bus_color_r_msb:bus_color_r_lsb] = v[1][bus_color_r_msb:bus_color_r_lsb];
					result[2][bus_color_r_msb:bus_color_r_lsb] = v[2][bus_color_r_msb:bus_color_r_lsb];
					result[3][bus_color_r_msb:bus_color_r_lsb] = v[3][bus_color_r_msb:bus_color_r_lsb];
					result[4][bus_color_r_msb:bus_color_r_lsb] = v[4][bus_color_r_msb:bus_color_r_lsb];
					result[5][bus_color_r_msb:bus_color_r_lsb] = v[5][bus_color_r_msb:bus_color_r_lsb];
					result[6][bus_color_r_msb:bus_color_r_lsb] = v[6][bus_color_r_msb:bus_color_r_lsb];
					result[7][bus_color_r_msb:bus_color_r_lsb] = v[7][bus_color_r_msb:bus_color_r_lsb];

					result[0][bus_color_g_msb:bus_color_g_lsb] = v[0][bus_color_g_msb:bus_color_g_lsb];
					result[1][bus_color_g_msb:bus_color_g_lsb] = v[1][bus_color_g_msb:bus_color_g_lsb];
					result[2][bus_color_g_msb:bus_color_g_lsb] = v[2][bus_color_g_msb:bus_color_g_lsb];
					result[3][bus_color_g_msb:bus_color_g_lsb] = v[3][bus_color_g_msb:bus_color_g_lsb];
					result[4][bus_color_g_msb:bus_color_g_lsb] = v[4][bus_color_g_msb:bus_color_g_lsb];
					result[5][bus_color_g_msb:bus_color_g_lsb] = v[5][bus_color_g_msb:bus_color_g_lsb];
					result[6][bus_color_g_msb:bus_color_g_lsb] = v[6][bus_color_g_msb:bus_color_g_lsb];
					result[7][bus_color_g_msb:bus_color_g_lsb] = v[7][bus_color_g_msb:bus_color_g_lsb];

					result[0][bus_color_b_msb:bus_color_b_lsb] = result_mul[0];
					result[1][bus_color_b_msb:bus_color_b_lsb] = result_mul[1];
					result[2][bus_color_b_msb:bus_color_b_lsb] = result_mul[2];
					result[3][bus_color_b_msb:bus_color_b_lsb] = result_mul[3];
					result[4][bus_color_b_msb:bus_color_b_lsb] = result_mul[4];
					result[5][bus_color_b_msb:bus_color_b_lsb] = result_mul[5];
					result[6][bus_color_b_msb:bus_color_b_lsb] = result_mul[6];
					result[7][bus_color_b_msb:bus_color_b_lsb] = result_mul[7];
				end
			endcase
		end
	endcase
end

adder #(bus_color) adder_v00 (color[0], s, operation, result_add[0], , , , add_c[0]);
adder #(bus_color) adder_v01 (color[1], s, operation, result_add[1], , , , add_c[1]);
adder #(bus_color) adder_v02 (color[2], s, operation, result_add[2], , , , add_c[2]);
adder #(bus_color) adder_v03 (color[3], s, operation, result_add[3], , , , add_c[3]);
adder #(bus_color) adder_v04 (color[4], s, operation, result_add[4], , , , add_c[4]);
adder #(bus_color) adder_v05 (color[5], s, operation, result_add[5], , , , add_c[5]);
adder #(bus_color) adder_v06 (color[6], s, operation, result_add[6], , , , add_c[6]);
adder #(bus_color) adder_v07 (color[7], s, operation, result_add[7], , , , add_c[7]);

adder #(bus_color) subtract_v08 (color[0], s, operation, result_sub[0], , , , sub_c[0]);
adder #(bus_color) subtract_v09 (color[1], s, operation, result_sub[1], , , , sub_c[1]);
adder #(bus_color) subtract_v10 (color[2], s, operation, result_sub[2], , , , sub_c[2]);
adder #(bus_color) subtract_v11 (color[3], s, operation, result_sub[3], , , , sub_c[3]);
adder #(bus_color) subtract_v12 (color[4], s, operation, result_sub[4], , , , sub_c[4]);
adder #(bus_color) subtract_v13 (color[5], s, operation, result_sub[5], , , , sub_c[5]);
adder #(bus_color) subtract_v14 (color[6], s, operation, result_sub[6], , , , sub_c[6]);
adder #(bus_color) subtract_v15 (color[7], s, operation, result_sub[7], , , , sub_c[7]);

multiplier #(bus_color) multiplier_v0 (color[0], s, result_mul[0], , , , mul_c[0]);
multiplier #(bus_color) multiplier_v1 (color[1], s, result_mul[1], , , , mul_c[1]);
multiplier #(bus_color) multiplier_v2 (color[2], s, result_mul[2], , , , mul_c[2]);
multiplier #(bus_color) multiplier_v3 (color[3], s, result_mul[3], , , , mul_c[3]);
multiplier #(bus_color) multiplier_v4 (color[4], s, result_mul[4], , , , mul_c[4]);
multiplier #(bus_color) multiplier_v5 (color[5], s, result_mul[5], , , , mul_c[5]);
multiplier #(bus_color) multiplier_v6 (color[6], s, result_mul[6], , , , mul_c[6]);
multiplier #(bus_color) multiplier_v7 (color[7], s, result_mul[7], , , , mul_c[7]);

// -------------------------------------------------- MUX flags
mux_4 #(bus_color) mux_ALU_sv_sh_flags (
	.d0({add_c[0], add_c[1], add_c[2], add_c[3], add_c[4], add_c[5], add_c[6], add_c[7]}), 	// add
	.d1({sub_c[0], sub_c[1], sub_c[2], sub_c[3], sub_c[4], sub_c[5], sub_c[6], sub_c[7]}), 	// sub
	.d2({mul_c[0], mul_c[1], mul_c[2], mul_c[3], mul_c[4], mul_c[5], mul_c[6], mul_c[7]}), 	// mul
	.d3({vector{1'b0}}), 	// div

	.selector(operation),
	.out(carry_out));

endmodule

// --------------------------------------------------

module ALU_sv_sh_tb;
	localparam period = 10;
	parameter vector = 8, bus = 24, bus_selector = 4, bus_color = 8;
	integer i, j;

	logic [bus_color-1:0] s;
	logic [vector-1:0][bus-1:0] v;
	logic [bus_selector-1:0] selector;
	logic [2:0] color_flag;

	logic [vector-1:0][bus-1:0] result;
	logic [vector-1:0] carry_out;

	ALU_sv_sh #(vector, bus) UUT (s, v, selector, color_flag, result, carry_out);

	initial begin
		// selector = 4'd0; // add
		// selector = 4'd1; // sub
		selector = 4'd2; // mul
		// color_flag = 3'b100;
		color_flag = 3'b010;
		// color_flag = 3'b001;
		for (i=1; i<4; i++) begin
			s = i;
			for (j=0; j<2; j++) begin
				v[0] = {8'd1, 8'd1, 8'd1};
				v[1] = {8'd2, 8'd2, 8'd2};
				v[2] = {8'd3, 8'd3, 8'd3};
				v[3] = {8'd4, 8'd4, 8'd4};
				v[4] = {8'd5, 8'd5, 8'd5};
				v[5] = {8'd6, 8'd6, 8'd6};
				v[6] = {8'd7, 8'd7, 8'd7};
				v[7] = {8'd8, 8'd8, 8'd8};
				#period;
			end
		end
	end

endmodule