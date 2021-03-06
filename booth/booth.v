module booth
#(parameter M,N)
(input wire clk, reset, start_calc,
 input wire [M-1:0] m_s,
 input wire [N-1:0] n_s,
 output wire [M+N-1:0] result,
 output reg end_sig);

localparam
  init = 1'b0,
  calc = 1'b1;
  
reg state;
reg [8:0] iter;
reg signed [N-1:0] n;
reg signed [N:0] code_n;  //one bit more
reg [M:0] m; //one bit more
reg [N-1:0] mul_h;
reg [M-1:0] mul_l;


always @(posedge clk, posedge reset)
begin
  if(reset)
    begin
    state <= init;
    end_sig <= 1'b1;
    iter <= 0;
    n <= 0;
    code_n <= 0;
    m <= 0;
    mul_h <= 0;
    mul_l <= 0;
    end
  else if(state == init)
    begin
    if(start_calc)
      begin
      state <= calc;
      m <= {m_s , 1'b0};
      n <= n_s;
      mul_h <= 0;
      mul_l <= 0;
      iter <= M/2;
      end_sig <= 1'b0;
      end
    end
  else //calc
    begin
    if (iter == 0)
      begin
      end_sig <= 1'b1;
      state <= init;
      end
    else
      begin
      m <= {2'b00 , m[M:2]};
      {mul_h , mul_l[M-1:M-2]} <= code_n + mul_h;
      mul_l[M-3:0] <= mul_l[M-1:2];
      iter <= iter - 1;
      end
    end
  
end

always @(m)
begin
  case (m[2:0])
    3'b000:
      code_n = 0;
    3'b001:
      code_n = n;
    3'b010:
      code_n = n;
    3'b011:
      code_n = n*2;
    3'b100:
      code_n = n*(-2);
    3'b101:
      code_n = n*(-1);  
    3'b110:
      code_n = n*(-1);
    3'b111:
      code_n = 0;
  endcase
end

assign result = {mul_h , mul_l};

endmodule 