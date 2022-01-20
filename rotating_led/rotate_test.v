`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:49:30 05/05/2019 
// Design Name: 
// Module Name:    rotate_test 
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
module rotate_test(
	input wire [2:0] sw,
	input wire clk,
	output wire [7:0] sseg,
	output wire [3:0] an
    );
	 
	rotating_led rot (clk, sw[2], sw[1], sw[0], sseg, an);

endmodule
