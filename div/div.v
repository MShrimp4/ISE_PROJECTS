`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:51 05/05/2019 
// Design Name: 
// Module Name:    div 
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
module div
	#(
	parameter W = 8,
				 CBIT = 4 //CBIT = log2(w) + 1
	)
	(
	input wire clk, reset,
	input wire start,
	input wire [W-1:0] dvsr, dvnd,
	output reg ready, done_tick,
	output wire [W-1:0] quo,rmd
    );

	localparam [1:0]
		idle = 2'b00,
		op   = 2'b01,
		last = 2'b10,
		done = 2'b11;
		
	reg [1:0] state_reg, state_next;
	reg [W-1:0] rh_reg, rh_next, rl_reg, rl_next, rh_tmp;
	reg [W-1:0] d_reg, d_next;
	reg [CBIT-1:0] n_reg, n_next;
	reg q_bit;
	
	always @(posedge clk, posedge reset)
		if (reset)
		begin
		end
		else
		begin
		end
	
	always @*
	begin
		state_next = state_reg;
		ready = 1'b0;
		done_tick = 1'b0;
		rh_next = re_reg;
		rl_next = rl_reg;
		d_next = d_reg;
		n_next = n_reg;
		case (state_reg)
			idle:
			begin
			  ready = 1'b1;
			  if (start)
			    begin
				 rh_next = 0;
				 rl_next = dvnd;
				 d_next = dvsr;
				 n_next = CBIT;
			end
			op:
			last:
			
	end
	

endmodule
