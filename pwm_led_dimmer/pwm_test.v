`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:16:43 05/05/2019 
// Design Name: 
// Module Name:    pwm_test 
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
module pwm_test(
	input wire [3:0] sw,
	input wire  btn,
	input wire clk,
	output wire led
    );
	pwm_led_dimmer pwm (sw, clk, btn, led);

endmodule
