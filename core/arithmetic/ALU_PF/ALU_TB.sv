module ALU_TB ();
	logic [31:0] a, b;
	logic [1:0] selector;
	logic [31:0] out;
	logic zero;
	
	ALU #(32) aluModule(a, b, selector, zero, out);
	
	initial begin
		selector = 2'b10;
		a = 32'd847872;	//binario = 11001111.000000000000 -> 207.0 11001111000000000000 11001111.000000000000
		b = 32'd2048;	//binario = 0000000.100000000000  ->   0.5
		#20;

		selector = 2'b01;
		a = out; 

		#20;

	end

endmodule


