// Listing 13.2
module vga_test
   (
    input wire clk, reset,
    input wire [2:0] sw,
    output wire hsync, vsync,
    output wire [2:0] r, g, b
   );

   //signal declaration
   reg [2:0] rgb_reg;
   wire video_on;

   // instantiate vga sync circuit
   vga_sync vsync_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(), .pixel_x(), .pixel_y());
   // rgb buffer
   always @(posedge clk, posedge reset)
      if (reset)
         rgb_reg <= 0;
      else
         rgb_reg <= sw;
   // output
	assign r[1:0] = 0;
	assign g[1:0] = 0;
	assign b[1:0] = 0;
   assign {r[2], g[2], b[2]} = (video_on) ? rgb_reg : 3'b0;

endmodule