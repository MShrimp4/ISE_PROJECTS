`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:20:08 05/06/2019 
// Design Name: 
// Module Name:    pong_top_an 
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
module pong_top_an
   (
    input wire clk, reset,
    input wire ps2d, ps2c,
    output wire hsync, vsync,
    output wire [2:0] rgb
   );
	
	localparam [1:0]
		newgame = 2'b00,
		play	  = 2'b01,
		newball = 2'b10,
		over	  = 2'b11;

   // signal declaration
	reg [1:0] state_reg, state_next;
   wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick, graph_on, left_miss, right_miss;
	wire [3:0] text_on;
	wire [2:0] graph_rgb, text_rgb;
   reg [2:0] rgb_reg, rgb_next;
	wire [3:0] l_score, r_score;
	reg gra_still, l_inc, r_inc, d_clr, timer_start;
	wire timer_tick, timer_up;
	reg [3:0] ball_reg, ball_next;
	reg last_winner, last_winner_next;
	
	wire [1:0] key_p1, key_p2;
	wire winner;

	assign winner = (l_score > r_score) ? 1'b1 : 1'b0;

   // body
   // instantiate vga sync circuit
   vga_sync vsync_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(pixel_tick),
       .pixel_x(pixel_x), .pixel_y(pixel_y));
		 
	// instantiate text generator
	pong_text text_unit
		(.clk(clk),
		 .pix_x(pixel_x), .pix_y(pixel_y),
		 .left_score(l_score), .right_score(r_score), .winner(winner), .ball(ball_reg),
		 .text_on(text_on), .text_rgb(text_rgb)
		);
	
   // instantiate graphic generator
   pong_graph_animate pong_graph_an_unit
      (.clk(clk), .reset(reset), .btn({key_p1,key_p2}),
       .pix_x(pixel_x), .pix_y(pixel_y), 
		 .gra_still(gra_still), .left_miss(left_miss), .right_miss(right_miss),
		 .next_toss({last_winner,ball_reg[0]}), .graph_on(graph_on), .graph_rgb(graph_rgb));
	
	//2 sec timer
	assign timer_tick = (pixel_x==0) && (pixel_y ==0);
	timer timer_unit
		(.clk(clk), .reset(reset), .timer_tick(timer_tick),
		 .timer_start(timer_start), .timer_up(timer_up)
		);
		
	//counter
	m10_counter left_score
	(.clk(clk), .reset(reset), .d_inc(l_inc), .d_clr(d_clr),
	 .dig(l_score)
	);
	m10_counter right_score
	(.clk(clk), .reset(reset), .d_inc(r_inc), .d_clr(d_clr),
	 .dig(r_score)
	);
		 
	keyboard_input keyboard_unit
		(clk, reset, ps2d, ps2c, key_p1[0], key_p1[1], key_p2[0], key_p2[1]);
	
	//=======================================================
   // FSMD
   //=======================================================
   // FSMD state & data registers
    always @(posedge clk, posedge reset)
       if (reset)
          begin
             state_reg <= newgame;
             ball_reg <= 0;
             rgb_reg <= 0;
				 last_winner <= 1'b0;
          end
       else
          begin
            state_reg <= state_next;
            ball_reg <= ball_next;
				last_winner <= last_winner_next;
            if (pixel_tick)
               rgb_reg <= rgb_next;
          end
   // FSMD next-state logic
   always @*
   begin
      gra_still = 1'b1;
      timer_start = 1'b0;
      l_inc = 1'b0;
		r_inc = 1'b0;
      d_clr = 1'b0;
      state_next = state_reg;
      ball_next = ball_reg;
		last_winner_next = last_winner;
      case (state_reg)
         newgame:
            begin
               ball_next = 4'b1001; // nine balls
               d_clr = 1'b1;      // clear score
               if ({key_p1,key_p2} != 4'b0000)  // button pressed
                  begin
                     state_next = play;
                     ball_next = ball_reg - 1;
                  end
            end
         play:
            begin
               gra_still = 1'b0;  // animated screen
               if (left_miss)
						begin
                  r_inc = 1'b1;   // right side gets score
						last_winner_next = 1'b0;
						end
					else if (right_miss)
						begin
						l_inc = 1'b1;   // left side gets score
						last_winner_next = 1'b1;
						end
					if (left_miss || right_miss)
                  begin
                     if (ball_reg==0)
                        state_next = over;
                     else
                        state_next = newball;
                     timer_start = 1'b1;  // 2 sec timer
                     ball_next = ball_reg - 1;
                  end
            end
         newball:
            // wait for 2 sec and until button pressed
            if (timer_up && ({key_p1,key_p2} != 4'b0000))
                state_next = play;
         over:
            // wait for 2 sec and no button pressed
            if (timer_up && ({key_p1,key_p2} == 4'b0000))
					state_next = newgame;
       endcase
    end
   //=======================================================
   // rgb multiplexing circuit
   //=======================================================
   always @*
      if (~video_on)
         rgb_next = "000"; // blank the edge/retrace
      else
         if (graph_on)  // display graph
           rgb_next = graph_rgb;
         // display score, rule, or game over
         else if (text_on[3] ||
               ((state_reg==newgame) && text_on[1]) || // rule
               ((state_reg==over) && text_on[0]))
            rgb_next = text_rgb;
         else if (text_on[2]) // display logo
           rgb_next = text_rgb;
         else
           rgb_next = 3'b000; // yellow background
   // output
   assign rgb = rgb_reg;

endmodule
