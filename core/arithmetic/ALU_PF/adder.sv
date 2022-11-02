module adder #(n = 32)
	(input logic [n - 1:0] operand1, operand2,
	 input logic carryIn,
	 output logic carryOut,
	 output logic [n-1:0] result);
	 
	
	assign {carryOut, result } = operand1 + operand2 + carryIn;
	 
endmodule 