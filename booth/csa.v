`timescale 1ns/10ps
module CSA
(
input wire [15:0] A, B,
input wire c_in,
output wire [16:0] X
);

wire [15:2] X0, X1;
wire [5:2] carry0, carry1;
wire [5:1] carry;

adder #(5) add5_0 (A[15:11], B[15:11], 0, {carry0[5],X0[15:11]});
adder #(5) add5_1 (A[15:11], B[15:11], 1, {carry1[5],X1[15:11]});
adder #(4) add4_0 (A[10:7], B[10:7], 0, {carry0[4],X0[10:7]});
adder #(4) add4_1 (A[10:7], B[10:7], 1, {carry1[4],X1[10:7]});
adder #(3) add3_0 (A[6:4], B[6:4], 0, {carry0[3],X0[6:4]});
adder #(3) add3_1 (A[6:4], B[6:4], 1, {carry1[3],X1[6:4]});
adder #(2) add2_0 (A[3:2], B[3:2], 0, {carry0[2],X0[3:2]});
adder #(2) add2_1 (A[3:2], B[3:2], 1, {carry1[2],X1[3:2]});
adder #(2) add1 (A[1:0]  , B[1:0] , c_in , {carry[1],X[1:0]});

mux #(5) m5 (X1[15:11], X0[15:11], carry[4], X[15:11]);
mux #(4) m4 (X1[10:7], X0[10:7], carry[3], X[10:7]);
mux #(3) m3 (X1[6:4], X0[6:4], carry[2], X[6:4]);
mux #(2) m2 (X1[3:2], X0[3:2], carry[1], X[3:2]);

mux #(1) c2 (carry1[2],carry0[2],carry[1],carry[2]);
mux #(1) c3 (carry1[3],carry0[3],carry[2],carry[3]);
mux #(1) c4 (carry1[4],carry0[4],carry[3],carry[4]);
mux #(1) c5 (carry1[5],carry0[5],carry[4],carry[5]);

assign X[16] = carry[5];

endmodule