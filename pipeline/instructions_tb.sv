`timescale 1ns / 1ns
// vsim -L altera_mf_ver -L lpm_ver instructions_tb

module instructions_tb;
	localparam period = 10;
	localparam bus_address = 5; // 2^5=32 lines
	localparam bus_data = 16;

	integer i, file;

	logic [bus_address-1:0] address;
	logic clk = 1'b0;
	logic read;
	logic [bus_data-1:0] data_out;

	instructions instructions_ (address, clk, read, data_out);

	always #period clk = !clk;

	initial begin
		// file = $fopen("./../../CPU_pipeline/fetch/instructions/instructions.txt", "w");
	end

	initial begin
		$display("read instructions and write in txt");
		read = 1'b1;
		address [4:0] = 0;
		// ask the written in +clk and present the written in the next +clk
		for (i=0; i<10; i++)
		begin
			address [4:0] = i;

			#period; // +clk
			#period; // -clk
			#period; // +clk

			// $fdisplay(file,"%d", data_out);
			$fwrite(file,"%d\n", data_out);
		end
		$fclose(file);

		$display("read disable");
		read = 1'b0;
		// ask the written in +clk and present the written in the next +clk
		for (i=0; i<10; i++)
		begin
			address [4:0] = i;

			#period; // +clk
			#period; // -clk
		end

		$stop;
	end

endmodule
