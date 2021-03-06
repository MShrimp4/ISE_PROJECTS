`timescale 1 ns/10 ps

module gt_test;
	reg [3:0] ta,tb;
	wire test_out;

	gt_4bit gt_m(.a(ta), .b(tb), .agtb(test_out));

	initial
	begin
		ta = 4'b0000;
		tb = 4'b0000;
		#200;
		ta = 4'b0000;
		tb = 4'b0011;
		#200;
		ta = 4'b0100;
		tb = 4'b0011;
		#200;
		ta = 4'b0101;
		tb = 4'b0100;
		#200;
		ta = 4'b1000;
		tb = 4'b0111;
		#200;
		ta = 4'b1111;
		tb = 4'b1110;
		#200;
		ta = 4'b1111;
		tb = 4'b1111;
		#200;
		ta = 4'b0010;
		tb = 4'b0011;
		#200;
		ta = 4'b0001;
		tb = 4'b0001;
		#200;
		ta = 4'b0000;
		tb = 4'b0011;
		#200;
		ta = 4'b0000;
		tb = 4'b0011;
		#200;
		$stop;
	end
endmodule