`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:39:15 05/05/2019 
// Design Name: 
// Module Name:    free_run_shift_reg 
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
module free_run_shift_reg
	#( parameter N=8 )
	(
	input wire clk, reset,
	input wire s_in,
	output wire s_out
    );

	reg [N-1:0] r_reg;
	wire [N-1:0] r_next;
	
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			r_reg <= 0;
		else
			 r_reg <= r_next;
	end
	
	assign r_next = {s_in, r_reg[N-1:1]};
	assign s_out = r_reg[0];

endmodule
