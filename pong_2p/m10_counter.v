`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:02:42 05/18/2019 
// Design Name: 
// Module Name:    m10_counter 
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
module m10_counter(
	input wire clk, reset,
	input wire d_inc, d_clr,
	output wire [3:0] dig
    );
 // signal declaration
   reg [3:0] dig_reg, dig_next;

   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            dig_reg <= 0;
         end
      else
         begin
            dig_reg <= dig_next;
         end

   // next-state logic
   always @*
   begin
      dig_next = dig_reg;
      if (d_clr)
         begin
            dig_next = 0;
         end
      else if (d_inc)
         if (dig_reg==9)
				dig_next = 0;
         else  // dig0 not 9
            dig_next = dig_reg + 1;
   end
   // output
   assign dig = dig_reg;

endmodule
