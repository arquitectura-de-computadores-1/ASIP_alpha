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
videoGen videoGen(clk,addr, x, y, r, g, b);
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
if(10'd639 == x && 10'd479 == y) addr = 0;
x++;
if (x == HMAX) begin
x = 0;
y++;

if (y == VMAX) y = 0;
end
if(10'd180 >= x && 10'd180 >= y) addr++;
 //memory addr
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


module videoGen(input logic clk,input logic [23:0] addr, input logic [9:0] x, y, 
output logic [7:0] r, g, b);
logic [23:0] pixel; // save rgb from memory
logic inarea;

//loadimg loadimg (clk,addr, 1'b1 ,pixel);
image	MEMRom (addr, clk, pixel); // read memory
//chargenrom chargenromb(addr, pixel);
area area(x, y, 10'd0, 10'd0, 10'd180, 10'd180, inarea);

		assign r = inarea ? pixel[7:0] : 8'h00;
		assign g = inarea ? pixel[15:8] : 8'h00;
		assign b = inarea ? pixel[23:16] : 8'h00;
//		assign r = pixel[7:0] ; 
//		assign g = pixel[15:8] ;
//		assign b = pixel[23:16] ;

//		assign r = 8'h00;
//		assign g = 8'h00;
//		assign b = 8'h00;

endmodule


module loadimg(
	 input logic clk,
    input logic [23:0] address,
    input logic read,
	 output logic [23:0] pixel);
	// logic [31:0] data_out;
    ROM_img	MEMR (address, clk, read, pixel); // read memory
	// assign pixel = data_out; //save data
	 
endmodule

module area(input logic [9:0] x, y, left, top, right, bot,
output logic inarea);
assign inarea = (x >= left & x < right & y >= top & y < bot);
endmodule


//module chargenrom(input logic [23:0] address,
//output logic [23:0] pixel);
//logic [23:0] charrom[16384:0]; // character generator ROM
//initial
//$readmemb("lego.txt", charrom);
//assign pixel = charrom[address]; //save data
//endmodule



