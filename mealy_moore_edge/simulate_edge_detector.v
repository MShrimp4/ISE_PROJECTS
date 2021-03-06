module sim_edge;
  
  localparam T=20;
  reg clk, reset;
  reg signal;
  wire mealy_output, moore_output;

  mealy_edge mealy(clk, reset, signal, mealy_output);
  moore_edge moore(clk, reset, signal, moore_output);
  
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
    @(posedge clk);
    reset = 1'b0;
    signal = 1'b0;
    #T;
    signal = 1'b1;
    #T;
    signal = 1'b0;
    #T;
    signal = 1'b1;
    #T;
    signal = 1'b1;
    #T;
    signal = 1'b0;
    #T;
    signal = 1'b1;
    #T;
    signal = 1'b0;
    #T;
    signal = 1'b0;
    #T;
    signal = 1'b0;
    #T;
    signal = 1'b1;
    #T;
    signal = 1'b0;
    #T;
    $stop;
  end



endmodule
