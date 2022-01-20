`timescale 1ns/10ps
module adder
#(
parameter N
)
(
input wire [N-1:0] A, B,
input wire c_in,
output wire [N:0] X
);


//assign #N X = A + B + c_in;

wire [N:0] carry;
genvar i;
generate
  for (i=0;i<N;i=i+1) begin
    assign #1 {carry[i+1] , X[i]} = A[i] + B[i] + carry[i];
  end
endgenerate

assign carry[0] = c_in;
assign X[N] = carry[N];


endmodule