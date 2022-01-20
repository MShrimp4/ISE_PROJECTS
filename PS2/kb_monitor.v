`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:08:28 05/05/2019 
// Design Name: 
// Module Name:    kb_monitor 
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
module kb_monitor(
	input wire clk, reset,
	input wire ps2d, ps2c,
	output wire [3:0] an,
	output wire [7:0] sseg
    );
		
	wire [7:0] scan_data;
	wire scan_done_tick;
	
	ps2_rx ps2_rx_unit
	(.clk(clk), .reset(reset), .ps2d(ps2d), .ps2c(ps2c), .rx_en(1'b1), .rx_done_tick(scan_done_tick), .dout(scan_data));
	
	LED_BUFFER led_buffer
	(clk,reset, scan_done_tick,scan_data, sseg, an);

	
endmodule
