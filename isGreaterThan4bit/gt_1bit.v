`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:12 05/03/2019 
// Design Name: 
// Module Name:    gt_1bit 
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
module gt_1bit(
	input wire i0, i1, carry,
	output wire gt
    );

	assign gt = {i0, i1} == 2'b10 | ( {i0, i1} != 2'b01 & carry );

endmodule
