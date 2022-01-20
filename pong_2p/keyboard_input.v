`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:34:04 05/06/2019 
// Design Name: 
// Module Name:    keyboard_input 
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
module keyboard_input(
	input wire clk, reset,
	input wire ps2d, ps2c,
	output reg key_1p_u, key_1p_d,
	output reg key_2p_u, key_2p_d
    );
	 
	localparam [7:0]
		W = 8'h1D,
		S = 8'h1B,
		I = 8'h43,
		K = 8'h42,
		DISABLE = 8'hF0;
	
	wire rx_tick;
	wire [7:0] keypress;
	
	reg en;
	wire en_next;
	wire key_1p_u_next, key_2p_u_next;
	wire key_1p_d_next, key_2p_d_next;
	 
	ps2_rx ps2_module(clk, reset, ps2d, ps2c, 1'b1, rx_tick, keypress);
	 
	always @(posedge clk, posedge reset)
		if (reset)
			begin
			en <= 1'b1;
			key_1p_u <= 1'b0;
			key_2p_u <= 1'b0;
			key_1p_d <= 1'b0;
			key_2p_d <= 1'b0;
			end
		else
			begin
			en <= en_next;
			key_1p_u <= key_1p_u_next;
			key_2p_u <= key_2p_u_next;
			key_1p_d <= key_1p_d_next;
			key_2p_d <= key_2p_d_next;
			end
	
	assign en_next = (!rx_tick) ? en : 
									(keypress == DISABLE) ? 1'b0 : 1'b1;
	
	assign key_1p_u_next = (rx_tick & (keypress == W)) ? en : key_1p_u;
	assign key_2p_u_next = (rx_tick & (keypress == I)) ? en : key_2p_u;
	assign key_1p_d_next = (rx_tick & (keypress == S)) ? en : key_1p_d;
	assign key_2p_d_next = (rx_tick & (keypress == K)) ? en : key_2p_d;


endmodule
