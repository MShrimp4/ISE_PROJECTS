`timescale 1ns/10ps
module mux
#(parameter N)
(
input wire [N-1:0] selA, selB,
input wire select,
output wire [N-1:0] out
);

assign #1 out = (select) ? selA : selB;



endmodule