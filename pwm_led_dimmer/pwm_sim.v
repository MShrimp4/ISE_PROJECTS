`timescale 1 ns / 10 ps

module pwm_sim();

localparam T=20;

reg [3:0] sw;
reg clk;
reg reset;
wire led;


pwm_test pwm (sw, clk, reset, led);

always
begin
  clk = 1'b1;
  #(T/2);
  clk = 1'b0;
  #(T/2);
end

initial
begin
  reset = 1'b1;
  @(negedge clk);
  reset = 1'b0;
  sw = 4'b0000;
  repeat(16) @(negedge clk);
  sw = 4'b0001;
  repeat(16) @(negedge clk);
  sw = 4'b0010;
  repeat(16) @(negedge clk);
  sw = 4'b0011;
  repeat(16) @(negedge clk);
  sw = 4'b0100;
  repeat(16) @(negedge clk);
  sw = 4'b0101;
  repeat(16) @(negedge clk);
  sw = 4'b0110;
  repeat(16) @(negedge clk);
  sw = 4'b0111;
  repeat(16) @(negedge clk);
  sw = 4'b1000;
  repeat(16) @(negedge clk);
  sw = 4'b1001;
  repeat(16) @(negedge clk);
  sw = 4'b1010;
  repeat(16) @(negedge clk);
  sw = 4'b1011;
  repeat(16) @(negedge clk);
  sw = 4'b1100;
  repeat(16) @(negedge clk);
  sw = 4'b1101;
  repeat(16) @(negedge clk);
  sw = 4'b1110;
  repeat(16) @(negedge clk);
  sw = 4'b1111;
  repeat(16) @(negedge clk);
  $stop;
end



endmodule 
