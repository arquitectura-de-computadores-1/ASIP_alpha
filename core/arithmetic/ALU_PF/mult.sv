module mult #(n = 32)
	(input logic [n - 1:0] operand1, operand2,
	 output logic [n-1:0] result);
	 
	 logic [n-1: 0] mult;
	 
	 
	 assign mult = operand1 * operand2;
	 
	 assign result = mult >> 12;
	
	
endmodule 