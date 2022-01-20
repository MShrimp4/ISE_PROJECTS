`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:25:54 05/05/2019 
// Design Name: 
// Module Name:    roatating_led 
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
module rotating_led(
	input wire clk, reset, en, dir,
	output wire [7:0] sseg,
	output wire [3:0] an
    );
	 
	 wire [7:0] led3, led2, led1, led0;
	 wire [39:0] data_shifted;
	 reg [39:0] data;
	 wire update;
	 
	 free_bin_counter count (clk, reset, update);
	 
	 disp_mux dmux (clk, reset, led3, led2, led1, led0, an, sseg);
	 hex_to_sseg l3 (data[39:36],1'b0,led3);
	 hex_to_sseg l2 (data[35:32],1'b0,led2);
	 hex_to_sseg l1 (data[31:28],1'b0,led1);
	 hex_to_sseg l0 (data[27:24],1'b0,led0);
	 
	 always @(posedge clk, posedge reset)
	 begin
		if (reset)
			data <= 40'h0123456789;
		else if (update && en)
			data <= data_shifted; // else : stay
	 end

	assign data_shifted = dir ? { data[35:0] , data[39:36] } : { data[3:0] , data[39:4] }; //left default

endmodule
