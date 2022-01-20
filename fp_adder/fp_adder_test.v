`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:53:12 05/04/2019 
// Design Name: 
// Module Name:    fp_adder_test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fp_adder_test(
	input wire clk,
	input wire [1:0] btn,
	input wire [7:0] sw,
	output wire [3:0] an,
	output wire [7:0] sseg
    );
	 
	wire sign1, sign2, sign_out;
	wire [3:0] exp1, exp2, exp_out;
	wire [7:0] frac1, frac2, frac_out;
	wire [7:0] led3, led2, led1, led0;
	
	assign sign1 = 1'b0;
	assign exp1 = 4'b1000;
	assign frac1 = {1'b1, sw[1:0], 5'b10101};
	assign sign2 = sw[7];
	assign exp2 = {btn, 2'b00};
	assign frac2 = {1'b1, sw[6:0]};
	
	fp_adder fp_unit
	(.sign1(sign1), .sign2(sign2), .exp1(exp1), .exp2(exp2), 
	.frac1(frac1), .frac2(frac2), .sign_out(sign_out),
	.exp_out(exp_out), .frac_out(frac_out));
	
	hex_to_sseg sseg_unit_0
		(.hex(exp_out), .dp(1'b1), .sseg(led0));
	hex_to_sseg sseg_unit_1
		(.hex(frac_out[3:0]), .dp(1'b0), .sseg(led1));
	hex_to_sseg sseg_unit_2
		(.hex(frac_out[7:4]), .dp(1'b1), .sseg(led2));
	assign led3 = (sign_out) ? 8'b11111110 : 8'b11111111;
	
	disp_mux disp_unit
	(.clk(clk), .reset(1'b0), .in0(led0), .in1(led1), .in2(led2), .in3(led3), .an(an), .sseg(sseg));


endmodule
