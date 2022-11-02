module vga_r (
    input clk,
    input [1:0] switch,

    output hsync,
    output vsync,
    // output sync_b,
    // output blank_b,
    // output [2:0] data
    output [7:0] r, g, b
    );

reg [9:0] h_count;
reg [2:0] h_dat;
reg [2:0] v_dat;
reg [9:0] v_count;
reg [7:0] data;
// parameter HACTIVE = 10'd640;
// parameter VACTIVE = 10'd480;
wire active;
reg clk_vga;

parameter
h_sp = 10'd96,
h_bp = 10'd144,
h_dt = 10'd784,
h_fp = 10'd800,
v_sp = 10'd2,
v_bp = 10'd35,
v_dt = 10'd515,
v_fp = 10'd525;

assign active = ((h_bp < h_count) && (h_count <= h_dt)) && ((v_bp < v_count) && (v_count <= v_dt));

assign hsync = (h_sp < h_count);
assign vsync = (v_sp < v_count);
// assign sync_b = hsync & vsync;
// assign blank_b = (h_count < HACTIVE) & (v_count < VACTIVE);
assign r = 8'hFF;
assign g = 8'h00;
assign b = 8'h00;
//assign b = (active) ?  data : 8'h00;

always @(posedge clk) begin
    clk_vga = ~clk_vga;
end

always @(posedge clk_vga) begin
    if (h_count == h_fp) begin
        h_count <= 10'd0;
        if (v_count == v_fp)
            v_count <= 10'd0;
        else
            v_count <= v_count + 10'd1;
    end
    else begin
        h_count <= h_count + 10'd1;
    end
end

always @(posedge clk_vga) begin
    case(switch[1:0])
        2'd0: data <= h_dat;
        2'd1: data <= (v_dat ~^ h_dat);
        2'd2: data <= (v_dat ^ h_dat);
        2'd3: data <= v_dat;
    endcase
end

always @(posedge clk_vga) begin
    if (h_count == 143)
        v_dat <= 8'h01;
    else if (h_bp <= h_count && h_count < 223)
        v_dat <= 8'h06;
    else if (h_count < 303)
        v_dat <= 8'h06;
    else if (h_count < 383)
        v_dat <= 8'h05;
    else if (h_count < 463)
        v_dat <= 8'h04;
    else if (h_count < 543)
        v_dat <= 8'h03;
    else if (h_count < 623)
        v_dat <= 8'h02;
    else if (h_count < 703)
        v_dat <= 8'h01;
    else if (h_count < 782)
        v_dat <= 8'h00;
    else if (h_count == 782)
        v_dat <= 8'h01;
end

always @(posedge clk_vga) begin
    if (v_count == 36)
        h_dat <= 8'h01;
    else if (v_bp <= v_count && v_count < 94)
        h_dat <= 8'h06;
    else if (v_count < 154)
        h_dat <= 8'h06;
    else if (v_count < 214)
        h_dat <= 8'h05;
    else if (v_count < 274)
        h_dat <= 8'h04;
    else if (v_count < 334)
        h_dat <= 8'h03;
    else if (v_count < 394)
        h_dat <= 8'h02;
    else if (v_count < 454)
        h_dat <= 8'h01;
    else
        h_dat <= 8'h00;
end

endmodule

