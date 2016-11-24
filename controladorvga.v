`timescale 1ns / 10ps

module controladorvga(
    input wire clk, reset,
	 input wire [3:0] day1, day2, month1, month2, year1, year2, hour1, hour2, min1, min2, second1, second2, /* thour1, thour2, tmin1, tmin2, tsec1, tsec2, */
    output wire hsync, vsync,
    output wire [2:0] rgb
    );

	//declaracion de señales
   wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick;
	wire ef_on;
	wire etemp_on;
	wire eh_on;
	wire date_on;
	wire hour_on;
	wire timer_on;
	wire e_on;
	wire am_on;
	wire pm_on;
	wire ring_on;
   reg [2:0] rgb_reg;
   reg [2:0] rgb_next;
	wire [2:0] text_rgb;

   SincronizadorVGA sincronizador
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(pixel_tick),
       .pixel_x(pixel_x), .pixel_y(pixel_y));
		 
   GeneradorVGA generador
      (.clk(clk), .day1(day1), .day2(day2), .month1(month1), .month2(month2), .year1(year1), .year2(year2), 
		.hour1(hour1), .hour2(hour2), .min1(min1), .min2(min2), .second1(second1), .second2(second2), 
		/*.thour1(thour1), .thour2(thour2), .tmin1(tmin1), .tmin2(tmin2), .tsec1(tsec1), .tsec2(tsec2), */
		.pix_x(pixel_x), .pix_y(pixel_y)/*, .text_on(text_on)*/, .text_rgb(text_rgb), .ef_on(ef_on), .etemp_on(etemp_on),
		.eh_on(eh_on), .date_on(date_on), .hour_on(hour_on), .timer_on(timer_on), .e_on(e_on), .am_on(am_on),
		.pm_on(pm_on), .ring_on(ring_on));
	
   
	// buffer rgb
   always @(negedge clk)
      if (pixel_tick)
         rgb_reg <= rgb_next;
	
	always @*
		if (~video_on)
			rgb_next = 3'b000/*"000"*/;
		else
			if (ef_on || etemp_on || eh_on || date_on || hour_on || timer_on || e_on || am_on || pm_on || ring_on)
				rgb_next = text_rgb;
			else
				rgb_next = 3'b000;
			
	// salida
   assign rgb = rgb_reg;
endmodule
