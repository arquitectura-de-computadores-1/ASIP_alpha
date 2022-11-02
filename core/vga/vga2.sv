module vga2(input logic clk,
output logic vgaclk, // 25.175 MHz VGA clock
output logic hsync, vsync,
output logic sync_b, blank_b, // to monitor & DAC
output logic [7:0] r, g, b); // to video DAC
logic [9:0] x, y;
logic [23:0] addr;
// Use a PLL to create the 25.175 MHz VGA pixel clock
// 25.175 MHz clk period = 39.772 ns
// Screen is 800 clocks wide by 525 tall, but only 640 x 480 used for display
// HSync = 1/(39.772 ns * 800) = 31.470 KHz
// Vsync = 31.474 KHz / 525 = 59.94 Hz (~60 Hz refresh rate)
// pll vgapll(.inclk0(clk), .c0(vgaclk));
always @(posedge clk) begin

	vgaclk <= ~vgaclk;

end
// generate monitor timing signals
vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y, addr);
// user-defined module to determine pixel color
videoGen videoGen(addr, x, y, r, g, b);
endmodule

module vgaController #(parameter HACTIVE = 10'd640,
	HFP = 10'd16,
	HSYN = 10'd96,
	HBP = 10'd48,
	HMAX = HACTIVE + HFP + HSYN + HBP,
	VBP = 10'd32,
	VACTIVE = 10'd480,
	VFP = 10'd11,
	VSYN = 10'd2,
	VMAX = VACTIVE + VFP + VSYN + VBP)
(input logic vgaclk,
	output logic hsync, vsync, sync_b, blank_b,
	output logic [9:0] x, y,
	output logic [23:0] addr);

// counters for horizontal and vertical positions
always @(posedge vgaclk) begin
addr++; //memory addr
x++;
if (x == HMAX) begin
	x = 0;
	y++;
	if (y == VMAX) y = 0;
	if (addr == (VMAX*HMAX)) addr = 0;
end
end
// compute sync signals (active low)
//localparam hcnt = x;
//localparam vcnt = y;
assign hsync = ~(x >= HACTIVE + HFP & x < HACTIVE + HFP + HSYN);
assign vsync = ~(y >= VACTIVE + VFP & y < VACTIVE + VFP + VSYN);
assign sync_b = hsync & vsync;
// force outputs to black when outside the legal display area
assign blank_b = (x < HACTIVE) & (y < VACTIVE);
endmodule


module videoGen(input logic [23:0] addr, input logic [9:0] x, y, output logic [7:0] r, g, b);
logic [23:0] pixel; // save rgb from memory

loadimg loadimg(addr,1'b1,pixel);
assign r = pixel[7:0] ; 
assign g = pixel[15:8] ;
assign b = pixel[23:16] ;

endmodule


module loadimg(
	input logic [23:0] address,
	input logic read,
	output logic pixel);

logic [31:0] data_out;
    ROM_img	UUT (address, clk, read, data_out); // read memory
	 assign pixel = data_out; //save data
	 
	endmodule



