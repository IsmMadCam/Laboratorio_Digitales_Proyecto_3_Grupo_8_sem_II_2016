`timescale 1ns / 10ps

module GeneradorVGA(
    input wire clk, 
	 input wire AM_PM,
	 input wire [7:0] ascii_code,
    input wire [3:0] day1, day2, month1, month2, year1, year2, hour1, hour2, min1, min2, second1, second2, thour1, thour2, tmin1, tmin2, tsec1, tsec2,
	 input wire [9:0] pix_x, pix_y,
	 input wire estado_alarma,
	/*output wire [9:0] text_on, */
    output reg [2:0] text_rgb,
	 output wire ef_on, etemp_on, eh_on, date_on, hour_on, timer_on, e_on, am_on, pm_on, ring_on
    );

   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_ef, char_addr_etemp, char_addr_eh, char_addr_date, char_addr_hour, char_addr_timer, char_addr_e, char_addr_am, char_addr_pm, char_addr_ring;
   reg [3:0] row_addr;
   wire [3:0] row_addr_ef, row_addr_etemp, row_addr_eh, row_addr_date, row_addr_hour, row_addr_timer, row_addr_e, row_addr_am, row_addr_pm, row_addr_ring;
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_ef, bit_addr_etemp, bit_addr_eh, bit_addr_date, bit_addr_hour, bit_addr_timer, bit_addr_e, bit_addr_am, bit_addr_pm, bit_addr_ring;
   wire [7:0] font_word;
   wire font_bit/*, ef_on, etemp_on, eh_on, date_on, hour_on, timer_on, e_on, am_on, pm_on, ring_on*/;

	//Instanciacion de la ROM.
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));

	//Datos a Mostrar en Pantalla.
	
	//ENCABEZADO - FECHA. ef.
   assign ef_on = (pix_y[9:5]==2) && (pix_x[9:4]<15); //Posicion en Pantalla.
   assign row_addr_ef = pix_y[4:1];  //Escalamiento.
   assign bit_addr_ef = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_ef = 7'h00; //
			4'h1: char_addr_ef = 7'h00; //
			4'h2: char_addr_ef = 7'h44; // D
         4'h3: char_addr_ef = 7'h49; // I
         4'h4: char_addr_ef = 7'h41; // A
         4'h5: char_addr_ef = 7'h00; // 
			4'h6: char_addr_ef = 7'h00; //
         4'h7: char_addr_ef = 7'h4d; // M
         4'h8: char_addr_ef = 7'h45; // E
			4'h9: char_addr_ef = 7'h53; // S
         4'ha: char_addr_ef = 7'h00; //
		   4'hb: char_addr_ef = 7'h00; //
         4'hc: char_addr_ef = 7'h41; //A
         4'hd: char_addr_ef = 7'h4e; //N
         4'he: char_addr_ef = 7'h4f; //O
			4'hf: char_addr_ef = 7'h00; 
      endcase
	
	//ENCABEZADO - TEMPORIZADOR. etemp.
   assign etemp_on = (pix_y[9:5]==10) && (pix_x[9:4]<=15);
   assign row_addr_etemp = pix_y[4:1];
   assign bit_addr_etemp = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_etemp = 7'h00; // 
         4'h1: char_addr_etemp = 7'h54; // T
         4'h2: char_addr_etemp = 7'h45; // E
         4'h3: char_addr_etemp = 7'h4d; // M
			4'h4: char_addr_etemp = 7'h50; // P
         4'h5: char_addr_etemp = 7'h4f; // O
         4'h6: char_addr_etemp = 7'h52; // R
			4'h7: char_addr_etemp = 7'h49; // I
         4'h8: char_addr_etemp = 7'h5a; // Z
			4'h9: char_addr_etemp = 7'h41; // A
         4'ha: char_addr_etemp = 7'h44; // D
         4'hb: char_addr_etemp = 7'h4f; // O
         4'hc: char_addr_etemp = 7'h52; // R
			4'hd: char_addr_etemp = 7'h00; //
			4'he: char_addr_etemp = 7'h00; //
			default:  char_addr_etemp = 7'h00;
      endcase

	//Encabezado - HORA. eh.
   assign eh_on = (pix_y[9:5]==5) && (pix_x[9:4]<15);
   assign row_addr_eh = pix_y[4:1];
   assign bit_addr_eh = pix_x[3:1];
   always @*
      case (pix_x[7:4])
         
         6'h00: char_addr_eh = 7'h00; // 
         6'h01: char_addr_eh = 7'h00; // 
         6'h02: char_addr_eh = 7'h48; // H
         6'h03: char_addr_eh = 7'h4f; // O
         6'h04: char_addr_eh = 7'h52; // R
         6'h05: char_addr_eh = 7'h41; // A
         6'h06: char_addr_eh = 7'h00; //
         6'h07: char_addr_eh = 7'h00; //
         6'h08: char_addr_eh = 7'h00; //
         6'h09: char_addr_eh = 7'h00; //
         6'h0a: char_addr_eh = 7'h00; //
         6'h0b: char_addr_eh = 7'h00; //
         6'h0c: char_addr_eh = 7'h00; //
         6'h0d: char_addr_eh = 7'h00; //
         6'h0e: char_addr_eh = 7'h00; //
         6'h0f: char_addr_eh = 7'h00; //
      endcase

	//Fecha. date.
   assign date_on = (pix_y[9:5]==3) && (pix_x[9:4]<=15);
   assign row_addr_date = pix_y[4:1];
   assign bit_addr_date = pix_x[3:1];
   always @*
      case(pix_x[7:4])
			4'h0: char_addr_date = 7'h00; //
			4'h1: char_addr_date = 7'h00; //
			4'h2: char_addr_date = 7'h00; // 
         4'h3: char_addr_date = {3'b011, day1}; //
         4'h4: char_addr_date = {3'b011, day2}; //
         4'h5: char_addr_date = 7'h00; // 
			4'h6: char_addr_date = 7'h00; //
         4'h7: char_addr_date = 7'h00; // 
         4'h8: char_addr_date = {3'b011, month1}; //
			4'h9: char_addr_date = {3'b011, month2}; //
         4'ha: char_addr_date = 7'h00; //
			4'hb: char_addr_date = 7'h00; //
         4'hc: char_addr_date = 7'h32; // 1ano
         4'hd: char_addr_date = 7'h30; // 2ano
			4'he: char_addr_date = {3'b011, year1}; //
			4'hf: char_addr_date = {3'b011, year2}; //
      endcase
		
	//hora. hour.	
	assign hour_on = (pix_y[9:5]==8) && (pix_x[9:4]<15);
   assign row_addr_hour = pix_y[4:1];
   assign bit_addr_hour = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_hour = 7'h00; //
			4'h1: char_addr_hour = 7'h00; //
			4'h2: char_addr_hour = 7'h00; //
         4'h3: char_addr_hour = 7'h00; //
         4'h4: char_addr_hour = {3'b011, hour1}; //
         4'h5: char_addr_hour = {3'b011, hour2}; //
			4'h6: char_addr_hour = 7'h3a; // :
         4'h7: char_addr_hour = {3'b011, min1}; //
         4'h8: char_addr_hour = {3'b011, min2}; //
			4'h9: char_addr_hour = 7'h3a; // :
         4'ha: char_addr_hour = {3'b011, second1}; //
			4'hb: char_addr_hour = {3'b011, second2}; //
         4'hc: char_addr_hour = 7'h00; //
         4'hd: char_addr_hour = 7'h00; //
         4'he: char_addr_hour = 7'h00; //
      	4'hf: char_addr_hour = 7'h00; //
      endcase
	
	//temporizador. timer.
	assign timer_on = (pix_y[9:5]==11) && (pix_x[9:4]<15);
   assign row_addr_timer = pix_y[4:1];
   assign bit_addr_timer = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_timer = 7'h00; //
			4'h1: char_addr_timer = 7'h00; //
			4'h2: char_addr_timer = {3'b011, thour1}; /*7'h58;*/
         4'h3: char_addr_timer = {3'b011, thour2}; /*7'h58;*/
         4'h4: char_addr_timer = 7'h3a; // :
         4'h5: char_addr_timer = {3'b011, tmin1}; /*7'h58;*/
			4'h6: char_addr_timer = {3'b011, tmin2}; /*7'h58;*/
         4'h7: char_addr_timer = 7'h3a; // :
         4'h8: char_addr_timer = {3'b011, tsec1}; /*7'h58;*/
			4'h9: char_addr_timer = {3'b011, tsec2}; /*7'h58;*/
         4'ha: char_addr_timer = 7'h00; //
			4'hb: char_addr_timer = 7'h00; //
         4'hc: char_addr_timer = 7'h00; //
         4'hd: char_addr_timer = 7'h00; //
         4'he: char_addr_timer = 7'h00; //
      	4'hf: char_addr_timer = 7'h00; //
      endcase
	
	//Encabezado.
	assign e_on = (pix_y[9:5]==1) && (pix_x[9:4]<15);
   assign row_addr_e = pix_y[4:1];
   assign bit_addr_e = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_e = 7'h00; //
			4'h1: char_addr_e = 7'h00; //
			4'h2: char_addr_e = 7'h46; //F
         4'h3: char_addr_e = 7'h45; //E
         4'h4: char_addr_e = 7'h43; //C
         4'h5: char_addr_e = 7'h48; //H 
			4'h6: char_addr_e = 7'h41; //A
         4'h7: char_addr_e = 7'h00; //
         4'h8: char_addr_e = 7'h00; // 
			4'h9: char_addr_e = 7'h00; //
         4'ha: char_addr_e = 7'h00; //
			4'hb: char_addr_e = 7'h00; //
         4'hc: char_addr_e = 7'h00; //
         4'hd: char_addr_e = 7'h00; //
         4'he: char_addr_e = 7'h00; //
      	4'hf: char_addr_e = 7'h00; //
      endcase
		
	//am
	assign am_on = (pix_y[9:5]==6) && (pix_x[9:4]<15);
   assign row_addr_am = pix_y[4:1];
   assign bit_addr_am = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_am = 7'h00; //
			4'h1: char_addr_am = 7'h00; //
			4'h2: char_addr_am = 7'h00; // 
         4'h3: char_addr_am = 7'h00; // 
         4'h4: char_addr_am = 7'h00; // 
         4'h5: char_addr_am = 7'h00; // 
			4'h6: char_addr_am = 7'h00; //
         4'h7: char_addr_am = 7'h00; //
         4'h8: char_addr_am = 7'h00; // 
			4'h9: char_addr_am = 7'h00; //
         4'ha: char_addr_am = 7'h41; //A
			4'hb: char_addr_am = 7'h4d; //M
         4'hc: char_addr_am = 7'h00; //
         4'hd: char_addr_am = 7'h00; //
         4'he: char_addr_am = 7'h00; //
      	4'hf: char_addr_am = 7'h00; //
      endcase
	
	//pm
	assign pm_on = (pix_y[9:5]==7) && (pix_x[9:4]<15);
   assign row_addr_pm = pix_y[4:1];
   assign bit_addr_pm = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_pm = 7'h00; //
			4'h1: char_addr_pm = 7'h00; //
			4'h2: char_addr_pm = 7'h00; // 
         4'h3: char_addr_pm = 7'h00; // 
         4'h4: char_addr_pm = 7'h00; // 
         4'h5: char_addr_pm = 7'h00; // 
			4'h6: char_addr_pm = 7'h00; //
         4'h7: char_addr_pm = 7'h00; //
         4'h8: char_addr_pm = 7'h00; // 
			4'h9: char_addr_pm = 7'h00; //
         4'ha: char_addr_pm = 7'h50; //P
			4'hb: char_addr_pm = 7'h4d; //M
         4'hc: char_addr_pm = 7'h00; //
         4'hd: char_addr_pm = 7'h00; //
         4'he: char_addr_pm = 7'h00; //
      	4'hf: char_addr_pm = 7'h00; //
      endcase
		
	//RING.	
	assign ring_on = (pix_y[9:5]==12) && (pix_x[9:4]<15);
   assign row_addr_ring = pix_y[4:1];
   assign bit_addr_ring = pix_x[3:1];
   always @*
      case (pix_x[7:4])
			4'h0: char_addr_ring = 7'h00; //
			4'h1: char_addr_ring = 7'h00; //
			4'h2: char_addr_ring = 7'h00; // 
         4'h3: char_addr_ring = 7'h00; // 
         4'h4: char_addr_ring = 7'h00; // 
         4'h5: char_addr_ring = 7'h52; //R 
			4'h6: char_addr_ring = 7'h49; //I
         4'h7: char_addr_ring = 7'h4e; //N
         4'h8: char_addr_ring = 7'h47; //G
			4'h9: char_addr_ring = 7'h00; //
         4'ha: char_addr_ring = 7'h00; //
			4'hb: char_addr_ring = 7'h00; //
         4'hc: char_addr_ring = 7'h00; //
         4'hd: char_addr_ring = 7'h00; //
         4'he: char_addr_ring = 7'h00; //
      	4'hf: char_addr_ring = 7'h00; //
      endcase
		
		
//asignación de colores.
   always @*
   begin
      text_rgb = 3'b000;  //black background.
      if (ef_on)
         begin
            char_addr = char_addr_ef;
            row_addr = row_addr_ef;
            bit_addr = bit_addr_ef;
            if (font_bit)
               text_rgb = 3'b111;
         end
			
      if (etemp_on)
         begin
            char_addr = char_addr_etemp;
            row_addr = row_addr_etemp;
            bit_addr = bit_addr_etemp;
            if (font_bit)
               text_rgb = 3'b100;
         end
			
		if (eh_on)
         begin
            char_addr = char_addr_eh;
            row_addr = row_addr_eh;
            bit_addr = bit_addr_eh;
            if (font_bit)
            text_rgb = 3'b010;
         end
       
		
		if (hour_on)
         begin
            char_addr = char_addr_hour;
            row_addr = row_addr_hour;
            bit_addr = bit_addr_hour;
            if (font_bit)
               text_rgb = 3'b111;
         end
       
		
		if (timer_on)
         begin
            char_addr = char_addr_timer;
            row_addr = row_addr_timer;
            bit_addr = bit_addr_timer;
            if (font_bit)
               text_rgb = 3'b111;
         end
 /*

*/ 
      
		if (am_on)
         begin
            char_addr = char_addr_am;
            row_addr = row_addr_am;
            bit_addr = bit_addr_am;
            if (font_bit)
					if (!AM_PM) text_rgb = 3'b111;
					else text_rgb = 3'b000;
         end	
      
		
		if (pm_on)
         begin
            char_addr = char_addr_pm;
            row_addr = row_addr_pm;
            bit_addr = bit_addr_pm;
            if (font_bit)
				if (AM_PM) text_rgb = 3'b111;
				else text_rgb = 3'b000;
         end
      
		
		if (ring_on)
         begin
            char_addr = char_addr_ring;
            row_addr = row_addr_ring;
            bit_addr = bit_addr_ring;
            if (font_bit) begin
					if (estado_alarma == 1'b1) 
					begin
						text_rgb = 3'b101;
					end
					else if (ascii_code == 8'h41)
					begin
						 text_rgb = 3'b000;
					end
					else 
					begin
						text_rgb = 3'b000;
					end
				end
         end
      
		
		if(date_on)
         begin
            char_addr = char_addr_date;
            row_addr = row_addr_date;
            bit_addr = bit_addr_date;
            if (font_bit)
               text_rgb = 3'b111;
         end
			
		if (e_on)
         begin
            char_addr = char_addr_e;
            row_addr = row_addr_e;
            bit_addr = bit_addr_e;
            if (font_bit)
               text_rgb = 3'b001;
         end
   end

	//outputs.
   /*assign text_on = {ring_on, pm_on, am_on*//**//*, timer_on, hour_on, ef_on, etemp_on, eh_on, date_on, e_on};*/
   assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];    //salidas de direccion de la memoria



endmodule
