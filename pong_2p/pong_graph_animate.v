`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:19:09 05/06/2019 
// Design Name: 
// Module Name:    pong_graph_animate 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pong_graph_animate
   (
    input wire clk, reset,
    input wire [3:0] btn,
    input wire [9:0] pix_x, pix_y,
	 input wire gra_still,
	 output reg left_miss, right_miss,
	 input wire [1:0] next_toss,
	 output wire graph_on,
    output reg [2:0] graph_rgb
   );

   // constant and signal declaration
   // x, y coordinates (0,0) to (639,479)
   localparam MAX_X = 640;
   localparam MAX_Y = 480;
	localparam MIN_BALL_RIGHT = 8;
   wire refr_tick;
   //--------------------------------------------
   // vertical stripe as a wall
   //--------------------------------------------
   // wall left, right boundary
	//localparam WALL_X_L = 32;
   //localparam WALL_X_R = 35;
   //--------------------------------------------
   // right vertical bar
   //--------------------------------------------
   // bar left, right boundary
   localparam BAR_X_L = 600;
   localparam BAR_X_R = 603;
   // bar top, bottom boundary
   wire [9:0] bar_y_t, bar_y_b;
   localparam BAR_Y_SIZE = 72;
   // register to track top boundary  (x position is fixed)
   reg [9:0] bar_y_reg, bar_y_next;
   // bar moving velocity when a button is pressed
   localparam BAR_V = 4;
	//--------------------------------------------
	// left vertical bar
	//--------------------------------------------
	localparam BAR2_X_L = 32;
	localparam BAR2_X_R = 35;
	wire [9:0] bar2_y_t, bar2_y_b;
	localparam BAR2_Y_SIZE = 72;
	reg [9:0] bar2_y_reg, bar2_y_next;
	//localparam BAR2_V = 4;
   //--------------------------------------------
   // square ball
   //--------------------------------------------
   localparam BALL_SIZE = 8;
   // ball left, right boundary
   wire [9:0] ball_x_l, ball_x_r;
   // ball top, bottom boundary
   wire [9:0] ball_y_t, ball_y_b;
   // reg to track left, top position
   reg [9:0] ball_x_reg, ball_y_reg;
   wire [9:0] ball_x_next, ball_y_next;
   // reg to track ball speed
   reg [9:0] x_delta_reg, x_delta_next;
   reg [9:0] y_delta_reg, y_delta_next;
   // ball velocity can be pos or neg)
   localparam BALL_V_P = 2;
   localparam BALL_V_N = -2;
   //--------------------------------------------
   // round ball
   //--------------------------------------------
   wire [2:0] rom_addr, rom_col;
   reg [7:0] rom_data;
   wire rom_bit;
   //--------------------------------------------
   // object output signals
   //--------------------------------------------
   wire bar_on, bar2_on, sq_ball_on, rd_ball_on;
   wire [2:0] bar_rgb, bar2_rgb, ball_rgb;

   // body
   //--------------------------------------------
   // round ball image ROM
   //--------------------------------------------
   always @*
   case (rom_addr)
      3'h0: rom_data = 8'b00111100; //   ****
      3'h1: rom_data = 8'b01111110; //  ******
      3'h2: rom_data = 8'b11111111; // ********
      3'h3: rom_data = 8'b11111111; // ********
      3'h4: rom_data = 8'b11111111; // ********
      3'h5: rom_data = 8'b11111111; // ********
      3'h6: rom_data = 8'b01111110; //  ******
      3'h7: rom_data = 8'b00111100; //   ****
   endcase

   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            bar_y_reg <= 0;
				bar2_y_reg <= 0;
            ball_x_reg <= 0;
            ball_y_reg <= 0;
            x_delta_reg <= 10'h004;
            y_delta_reg <= 10'h004;
         end
      else
         begin
            bar_y_reg <= bar_y_next;
				bar2_y_reg <= bar2_y_next;
            ball_x_reg <= ball_x_next;
            ball_y_reg <= ball_y_next;
            x_delta_reg <= x_delta_next;
            y_delta_reg <= y_delta_next;
         end

   // refr_tick: 1-clock tick asserted at start of v-sync
   //            i.e., when the screen is refreshed (60 Hz)
   assign refr_tick = (pix_y==481) && (pix_x==0);

   //--------------------------------------------
   // (wall) left vertical strip
   //--------------------------------------------
   // pixel within wall
   //assign wall_on = (WALL_X_L<=pix_x) && (pix_x<=WALL_X_R);
   // wall rgb output
   //assign wall_rgb = 3'b001; // blue
   //--------------------------------------------
   // right vertical bar
   //--------------------------------------------
   // boundary
   assign bar_y_t = bar_y_reg;
   assign bar_y_b = bar_y_t + BAR_Y_SIZE - 1;
   assign bar2_y_t = bar2_y_reg;
   assign bar2_y_b = bar2_y_t + BAR2_Y_SIZE - 1;
   // pixel within bar
   assign bar_on = (BAR_X_L<=pix_x) && (pix_x<=BAR_X_R) &&
                   (bar_y_t<=pix_y) && (pix_y<=bar_y_b);
   assign bar2_on = (BAR2_X_L<=pix_x) && (pix_x<=BAR2_X_R) &&
                   (bar2_y_t<=pix_y) && (pix_y<=bar2_y_b);
   // bar rgb output
   assign bar_rgb = 3'b001; // blue on right
	assign bar2_rgb = 3'b100; // red on left
   // new bar y-position
   always @*
   begin
      bar_y_next = bar_y_reg; // no move
      bar2_y_next = bar2_y_reg; // no move
      if (refr_tick)
			begin
         if (btn[1] & (bar_y_b < (MAX_Y-1-BAR_V)))
            bar_y_next = bar_y_reg + BAR_V; // move down
         else if (btn[0] & (bar_y_t > BAR_V))
            bar_y_next = bar_y_reg - BAR_V; // move up
			//bar 2
         if (btn[3] & (bar2_y_b < (MAX_Y-1-BAR_V)))
            bar2_y_next = bar2_y_reg + BAR_V; // move down
         else if (btn[2] & (bar2_y_t > BAR_V))
            bar2_y_next = bar2_y_reg - BAR_V; // move up
			end
   end

   //--------------------------------------------
   // square ball
   //--------------------------------------------
   // boundary
   assign ball_x_l = ball_x_reg;
   assign ball_y_t = ball_y_reg;
   assign ball_x_r = ball_x_l + BALL_SIZE - 1;
   assign ball_y_b = ball_y_t + BALL_SIZE - 1;
   // pixel within ball
   assign sq_ball_on =
            (ball_x_l<=pix_x) && (pix_x<=ball_x_r) &&
            (ball_y_t<=pix_y) && (pix_y<=ball_y_b);
   // map current pixel location to ROM addr/col
   assign rom_addr = pix_y[2:0] - ball_y_t[2:0];
   assign rom_col = pix_x[2:0] - ball_x_l[2:0];
   assign rom_bit = rom_data[rom_col];
   // pixel within ball
   assign rd_ball_on = sq_ball_on & rom_bit;
   // ball rgb output
   assign ball_rgb = 3'b110;   // red
   // new ball position
   assign ball_x_next = (gra_still) ? MAX_X/2 :
								(refr_tick) ? ball_x_reg+x_delta_reg :
                        ball_x_reg ;
   assign ball_y_next = (gra_still) ? MAX_Y/2 :
								(refr_tick) ? ball_y_reg+y_delta_reg :
                        ball_y_reg ;
   // new ball velocity
   always @*
   begin
		left_miss = 1'b0;
		right_miss = 1'b0;
      x_delta_next = x_delta_reg;
      y_delta_next = y_delta_reg;
		if (gra_still)
			begin
				if (next_toss[1])
					x_delta_next = BALL_V_N;
				else
					x_delta_next = BALL_V_P;
				if (next_toss[0])
					y_delta_next = BALL_V_N;
				else
					y_delta_next = BALL_V_P;
			end
      else if (ball_y_t < 1) // reach top
         y_delta_next = BALL_V_P;
      else if (ball_y_b > (MAX_Y-1)) // reach bottom
         y_delta_next = BALL_V_N;
      //else if (ball_x_l <= WALL_X_R) // reach wall
      //   x_delta_next = BALL_V_P;    // bounce back
		else if ((ball_x_l<=BAR2_X_R) && (BAR2_X_L<=ball_x_r) &&
					(bar2_y_t<=ball_y_b) && (ball_y_t<=bar2_y_b))
			x_delta_next = BALL_V_P;
      else if ((BAR_X_L<=ball_x_r) && (ball_x_r<=BAR_X_R) &&
               (bar_y_t<=ball_y_b) && (ball_y_t<=bar_y_b))
         // reach x of right bar and hit, ball bounce back
         x_delta_next = BALL_V_N;
		else if (ball_x_r < MIN_BALL_RIGHT)
			left_miss = 1'b1;
		else if (ball_x_r > MAX_X)
			right_miss = 1'b1;
   end
   //--------------------------------------------
   // rgb multiplexing circuit
   //--------------------------------------------
   always @*
		if (bar_on)
			graph_rgb = bar_rgb;
		else if (bar2_on)
			graph_rgb = bar2_rgb;
		else if (rd_ball_on)
			graph_rgb = ball_rgb;
		else
			graph_rgb = 3'b000; // yellow background
	assign graph_on = bar_on | bar2_on | rd_ball_on;
 
endmodule