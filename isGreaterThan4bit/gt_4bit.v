`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:24 05/03/2019 
// Design Name: 
// Module Name:    gt_4bit 
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
module gt_4bit(
	input wire [3:0] a, b,
	output wire agtb
    );
	 
	 wire dummy;
	 wire [3:0] gt;
	
	assign dummy = 1'b0;
	assign agtb = gt[3];
	
	gt_1bit g3 (.i0(a[3]), .i1(b[3]), .carry(gt[2]), .gt(gt[3]));
	gt_1bit g2 (.i0(a[2]), .i1(b[2]), .carry(gt[1]), .gt(gt[2]));
	gt_1bit g1 (.i0(a[1]), .i1(b[1]), .carry(gt[0]), .gt(gt[1]));
	gt_1bit g0 (.i0(a[0]), .i1(b[0]), .carry(dummy), .gt(gt[0]));

endmodule
