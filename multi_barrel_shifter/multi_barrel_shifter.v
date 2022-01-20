`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:18:09 05/04/2019 
// Design Name: 
// Module Name:    multi_barrel_shifter 
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
module multi_barrel_shifter
	(
	input wire [7:0] in,
	input wire [2:0] amt,
	input wire lr,
	output wire [7:0] out
    );
	 
	 wire [7:0] lshift, rshift;

	left_barrel_shifter lbar
		(.in(in), .amt(amt), .out(lshift));
	right_barrel_shifter rbar
		(.in(in), .amt(amt), .out(rshift));
	
	assign out = lr ? lshift : rshift;

endmodule
