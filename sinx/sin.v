`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:15:48 05/06/2019 
// Design Name: 
// Module Name:    sin 
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
module sin(
	input wire [9:0] x,
	output wire [7:0] y
    );
	 
	 
	localparam
		minus = 1'b1,
		plus = 1'b0;
	
	wire [7:0] addr_x;
	wire sign_y;
	wire [6:0] mag_y;

	assign sign_y = (x[9]) ? minus : plus ;
	assign addr_x = (x[8]) ? (8'b11111111 - x[7:0]) : x[7:0];
	
	sin_fragment sin_table (addr_x, mag_y);
	
	assign y = {sign_y , mag_y};

endmodule
