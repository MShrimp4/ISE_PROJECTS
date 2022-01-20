`timescale 1ns/10ps

module test();

reg [15:0] A,B;
wire [16:0] X_adder;
wire [16:0] X_CSA;

adder #(16) add1 (A,B,0,X_adder);
CSA csadder (A,B,0,X_CSA);


initial
  begin
  A = 15'h0000;
  B = 15'h0000;
  #20;
  A = 15'h7BCD;
  B = 15'h1234;
  #20;
  A = 15'h0000;
  B = 15'h0000;
  #20;
  A = 15'h2AAA;
  B = 15'h5555;
  #20;
  A = 15'h0000;
  B = 15'h0000;
  #20;
  A = 15'h2AAA;
  B = 15'h5556;
  #20;
  $stop;
  end


endmodule