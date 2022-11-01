module MemTest #(parameter bus = 7)(
	input logic clock,
	input logic rst,

	input logic	[11:0] address,
	output logic [bus-1:0] q
	);


reg	[7:0]  data;
reg	  rden;
reg	  wren;

ROM_img	ROM_img_ (address, clock, rden, data);

RAM RAM_ (address, clock, data, rden, wren, q);

endmodule  
