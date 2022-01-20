`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:32 04/19/2019 
// Design Name: 
// Module Name:    eq2 
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

module eq1(
	input wire i0, i1,
	output wire eq
	);
	
	wire p0, p1;
	
	assign eq = p0 | p1;
	assign p0 = ~i0 & ~i1;
	assign p1 = i0 & i1;
endmodule

module eq2(
	input wire[1:0] a, b,
	output wire aeqb
    );
	wire e0, e1;
	
	eq1 eq_bit0_uinit (.i0(a[0]), .i1(b[0]), .eq(e0));
	eq1 eq_bit1_uinit (.i0(a[1]), .i1(b[1]), .eq(e1));
	assign aeqb = e0 & e1;

endmodule
