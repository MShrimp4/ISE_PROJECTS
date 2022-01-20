`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:39:42 05/05/2019 
// Design Name: 
// Module Name:    free_bin_counter 
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
module free_bin_counter
	#(parameter N=24) // less than 1Hz?
	(
	input wire clk, reset,
	output wire max_tick
    );

	reg [N-1:0] r_reg;
	wire [N-1:0] r_next;
	
	always @(posedge clk, posedge reset)
		if(reset)
			r_reg <= 0;
		else
			r_reg <= r_next;
	
	assign r_next = r_reg + 1;
	assign max_tick = (r_reg == 2**N -1) ? 1'b1 : 1'b0;

endmodule
