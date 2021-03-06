`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:26:12 05/04/2019 
// Design Name: 
// Module Name:    right_barrel_shifter 
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
module right_barrel_shifter
	(
	input wire [7:0] in,
	input wire [2:0] amt,
	output wire [7:0] out
    );
	wire [7:0] s4,s2,s1;
	
	assign s4 = amt[2] ? {in[3:0], in[7:4]} : in;
	assign s2 = amt[1] ? {s4[1:0], s4[7:2]} : s4;
	assign s1 = amt[0] ? {s2[0], s2[7:1]} : s2;
	assign out = s1;
	
endmodule
