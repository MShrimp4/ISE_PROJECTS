`timescale 1 ns/10 ps
//Page 96 ?? .
module hex_to_sseg_sim;
	localparam T=20;

	reg clk;
	reg [7:0] sw;
	wire [3:0] an;
	wire [7:0] sseg_out;

	hex_to_sseg_test test_unit
	(.clk(clk), .sw(sw), .an(an), .sseg(sseg_out));

	always
	begin
	  clk = 1'b1;
	  #(T/2);
	  clk = 1'b0;
	  #(T/2);
	end

	initial
	begin
		sw = 8'h12;
		repeat(8) @(negedge clk);

		sw = 8'h45;
		repeat(8) @(negedge clk);

		sw = 8'h78;
		repeat(8) @(negedge clk);
		
		sw = 8'hab;
		repeat(8) @(negedge clk);

		sw = 8'hde;
		repeat(8) @(negedge clk);
		
		$stop;
	end
endmodule	