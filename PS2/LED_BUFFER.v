`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:37 05/05/2019 
// Design Name: 
// Module Name:    LED_BUFFER 
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
module LED_BUFFER(
	input wire clk, reset,
	input wire data_ready,
	input wire [7:0] data,
	output wire [7:0] sseg,
	output wire [3:0] an
    );
	 
	 reg [15:0] disp_data;
	 wire [15:0] disp_data_next;
	 
	 wire [7:0] led3, led2, led1, led0;
	 
	 disp_mux disp (clk,reset, led3,led2,led1,led0, an,sseg);
	 hex_to_sseg sseg3 (disp_data[15:12],1'b1,led3);
	 hex_to_sseg sseg2 (disp_data[11:8],1'b1,led2);
	 hex_to_sseg sseg1 (disp_data[7:4],1'b1,led1);
	 hex_to_sseg sseg0 (disp_data[3:0],1'b1,led0);
	 
	 
	 
	 always @(posedge clk, posedge reset)
		if (reset)
			disp_data <= 16'h0000;
		else
			disp_data <= disp_data_next;

	assign disp_data_next = (data_ready) ? {disp_data[7:0] , data} : disp_data;

endmodule
