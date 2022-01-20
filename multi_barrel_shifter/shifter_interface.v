`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:01:06 05/04/2019 
// Design Name: 
// Module Name:    shifter_interface 
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
module shifter_interface(
	input wire [2:0] btn, //amount
	input wire [7:0] sw, // num & direction
	input wire clk,
	output wire [3:0] an,
	output wire [7:0] sseg
    );
	wire [7:0] led0, led1, led2, led3;
	wire [7:0] val, shifted;
	
	assign val = {1'b1, sw[6:0]};
	
	multi_barrel_shifter mbshift (val, btn, sw[7], shifted);

	hex_to_sseg hex0 ({2'b00,shifted[7:6]}, 1'b0, led0);
	hex_to_sseg hex1 ({2'b00,shifted[5:4]}, 1'b0, led1);
	hex_to_sseg hex2 ({2'b00,shifted[3:2]}, 1'b0, led2);
	hex_to_sseg hex3 ({2'b00,shifted[1:0]}, 1'b0, led3);
	disp_mux dmux (clk, 1'b0, led0, led1, led2, led3, an, sseg);

endmodule
