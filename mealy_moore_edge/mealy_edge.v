module mealy_edge(
  input wire clk, reset,
  input wire level,
  output reg tick
  );

  localparam zero = 1'b0,
             one = 1'b1;

  reg state_reg, state_next;

  always @(posedge clk, posedge reset)
    if (reset)
      state_reg <= zero;
    else
      state_reg <= state_next;

  always @*
  begin
    state_next = state_reg;
    tick = 1'b0;
    case (state_reg)
      zero:
        if (level)
        begin
          tick = 1'b1;
          state_next <= one;
        end
      one:
        if (~level)
          state_next <= zero;
      default:
        state_next <= zero;
    endcase
  end


endmodule 
