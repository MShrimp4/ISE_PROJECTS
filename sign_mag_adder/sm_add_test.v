`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:31:13 04/24/2019 
// Design Name: 
// Module Name:    sm_add_test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: led, disp_mux
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
	module sm_add_test(
	input wire clk,
	input wire [1:0] btn,
	input wire [7:0] sw,
	output wire [3:0] an,
	output wire [7:0] sseg
    );

	wire [3:0] sum, mout, oct;
	wire [7:0] led3, led2, led1, led0;
	
	sign_mag_add #(.N(4)) sm_adder_unit
	(.a(sw[3:0]), .b(sw[7:4]), .sum(sum));
	
	assign mout = (btn==2'b00) ? sw[3:0] :
						(btn==2'b01) ? sw[7:4] :
						sum;
	assign oct = {1'b0, mout[2:0]};
	
	hex_to_sseg sseg_unit(.hex(oct), .dp(1'b0), .sseg(led0));
	
	assign led1 = mout[3] ? 8'b11111110 : 8'b11111111;
	assign led2 = 8'b11111111;
	assign led3 = 8'b11111111;
	
	disp_mux disp_unit
	(.clk(clk), .reset(1'b0), .in0(led0), .in1(led1),
	.in2(led2), .in3(led3), .an(an), .sseg(sseg));
	

endmodule
