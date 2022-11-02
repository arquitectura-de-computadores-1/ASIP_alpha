module sub #(n = 32)
	(input logic [n - 1:0] operand1, operand2,
	 output logic [n-1:0] result);
	 
	 
	 
	 assign result = operand1 - operand2;	 
	
	 
	 
endmodule 