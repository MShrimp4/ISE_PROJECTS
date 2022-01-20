`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:25:58 05/04/2019 
// Design Name: 
// Module Name:    left_barrel_shifter 
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
module left_barrel_shifter
	(
	input wire [7:0] in,
	input wire [2:0] amt,
	output wire [7:0] out
    );
	wire [7:0] s4,s2,s1;
	
	assign s4 = amt[2] ? {in[3:0], in[7:4]} : in;
	assign s2 = amt[1] ? {s4[5:0], s4[7:6]} : s4;
	assign s1 = amt[0] ? {s2[6:0], s2[7]} : s2;
	assign out = s1;
	
endmodule
