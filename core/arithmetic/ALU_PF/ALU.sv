




module ALU #(n = 32)
	(input logic [n-1:0] operand1, operand2,
	 input logic [1:0] sel,
	 output logic zero,
	 output logic [n-1:0] out);
	 
	 	 
	 logic [n-1:0] addOut, subOut, multOut;
	 logic carryOut;
	 
	 
	 adder #(n) addModule(operand1, operand2,0, carryOut, addOut);
	 
	 sub	#(n) subModule(operand1, operand2, subOut);
	 
	 mult #(n) multModule(operand1, operand2, multOut);
	 
	 always_comb begin
		case (sel)
		
			2'b00 : out = addOut;
			2'b01 : out = subOut;
			2'b10 : out = multOut;
			default : out = 0; 
	 
		endcase
		
		zero <= ~|out;
	 
	 end	 
	 
	 
endmodule
				