`timescale 1 ns/ 10 ps
module booth_test;

localparam
 M = 8, N = 8;

reg clk = 0;
reg reset;
reg start_calc;
reg [M-1:0] m;
reg [N-1:0] n;
wire [M+N-1:0] result;
wire end_sig;

booth #(M,N) booth_t (clk,reset,start_calc,m,n,result,end_sig);


always #2 clk = ~clk;

initial
  begin
  reset = 1'b1;
  repeat(2) @(negedge clk);
  reset = 1'b0;
  
  m = 8'b00000001;
  n = 3;
  start_calc = 1'b1;
  @(negedge clk);
  start_calc = 1'b0;
  @(posedge end_sig);
  @(negedge clk);


  m = 8'b01111111;
  n = 8'b10101101;
  start_calc = 1'b1;
  @(negedge clk);
  start_calc = 1'b0;
  @(posedge end_sig);
  @(negedge clk);


  m = 8'b10000000;
  n = 8'b00100101;
  start_calc = 1'b1;
  @(negedge clk);
  start_calc = 1'b0;
  @(posedge end_sig);
  @(negedge clk);


  m = 8'b11111111;
  n = 8'b11111111;
  start_calc = 1'b1;
  @(negedge clk);
  start_calc = 1'b0;
  @(posedge end_sig);
  @(negedge clk);
  
  $stop;
  end

endmodule 
