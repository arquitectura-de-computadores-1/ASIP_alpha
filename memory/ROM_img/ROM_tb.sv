`timescale 1ns / 1ns
// vsim -L altera_mf_ver -L lpm_ver ROM_tb

module ROM_tb;
    localparam tic = 10;
    integer i, file;

    logic [4:0] address;
    logic clk = 1'b1;
    logic read;
    logic [31:0] data_out;

    ROM_img	UUT (address, clk, read, data_out);

    always #tic clk = !clk;

    initial begin
        // file = $fopen("./../../core/storage/ROM_img/ROM_img.txt", "w");
    end

    initial begin
        $monitor($time, "clk: %b | read:%d | address:%d | data_out:%d", clk, read, address, data_out);
        
        $display("read ROM_img and write in txt");
        read = 1'b1;
        // ask the written in +clk and present the written in the next +clk
        for (i=0; i<10; i++) begin
            address [4:0] = i;

            #tic; // +clk
            #tic; // -clk
            #tic; // +clk

            $fdisplay(file,"%d", data_out);
            // $fwrite(file,"%d\n", data_out);
        end
        $fclose(file);

        $display("read disable");
        read = 1'b0;
        // ask the written in +clk and present the written in the next +clk
        for (i=0; i<10; i++) begin
            address [4:0] = i;

            #tic; // +clk
            #tic; // -clk
        end

        $stop;
    end

endmodule
