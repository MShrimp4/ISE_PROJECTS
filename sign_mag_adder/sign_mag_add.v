`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:11:20 04/24/2019 
// Design Name: 
// Module Name:    sign_mag_add 
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
module sign_mag_add
	#(
	parameter N=4
	)
	(
	input wire [N-1:0] a, b,
	output reg [N-1:0] sum
    );

	//signal declaration
	reg [N-2:0] mag_a, mag_b, mag_sum, max, min;
	reg sign_a, sign_b, sign_sum;
	
	always @*
	begin
		mag_a = a[N-2:0];
		mag_b = b[N-2:0];
		sign_a = a[N-1];
		sign_b = b[N-1];
		
		if(mag_a > mag_b)
			begin
			max = mag_a;
			min = mag_b;
			sign_sum = sign_a;
			end
		else
			begin
			max = mag_b;
			min = mag_a;
			sign_sum = sign_b;
			end
		
		if (sign_a == sign_b)
			mag_sum = max + min;
		else
			mag_sum = max - min;
			
		sum = {sign_sum, mag_sum};
	end

endmodule
