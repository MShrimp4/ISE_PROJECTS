`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:09:41 05/05/2019 
// Design Name: 
// Module Name:    pwm_led_dimmer 
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
module pwm_led_dimmer(
	input wire [3:0] w,
	input wire clk, reset,
	output wire out
    );
	 
	 reg [3:0] count;
	 wire [3:0] count_next;

	always @(posedge clk)
	begin
		if (reset)
			count <= 4'b0000;
		else
			count <= count_next;
	end

	assign count_next = count + 4'b0001;
	assign out = (count < w) ? 1'b1 : 1'b0;

endmodule
