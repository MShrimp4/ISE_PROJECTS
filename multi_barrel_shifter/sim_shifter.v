`timescale 1ns / 1ps
module sim_shifter;
reg [7:0] in;
reg [3:0] amt;
reg lr;
wire [7:0] out;
multi_barrel_shifter shft (in,amt,lr,out);

initial
begin
 in = 8'b01010011;
 amt = 3'b000;
 lr = 1'b1;
# 200;
 lr = 1'b0;
# 200;
 amt = 3'b001;
 lr = 1'b1;
# 200;
 lr = 1'b0;
# 200;
 amt = 3'b010;
 lr = 1'b1;
# 200;
 lr = 1'b0;
# 200;
 amt = 3'b100;
 lr = 1'b1;
# 200;
 lr = 1'b0;
# 200;
 amt = 3'b111;
 lr = 1'b1;
# 200;
 lr = 1'b0;
# 200;
end


endmodule 