module multiplier_fp #(parameter bus = 32)(
	input logic [bus-1:0] a, b,
	output logic [bus-1:0] result
	);

logic [bus-1:0] mult;

assign mult = a * b;

assign result = mult >> 12;

endmodule 