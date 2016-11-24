`timescale 1ns / 10ps

module SincronizadorVGA(
	input wire reset,
	input wire clk,
	output wire hsync , vsync , video_on, p_tick,
	output wire [9:0] pixel_x, pixel_y
    );
	 
	   // declaracion de constantes
		// VGA 640-by-480 sync parameters
	localparam HD = 640; // area de display horizontal
	localparam HF = 48 ; //borde izquierdo
	localparam HB = 16 ; //borde derecho
	localparam HR = 96 ; // retraso horizonal
	localparam VD = 480; // area de display vertical
	localparam VF = 10; // borde superior
	localparam VB = 33; // borde inferior
	localparam VR = 2; // retraso vertical
	localparam fre = 3;
	// mod-2 counter
	reg mod2_reg;
	reg mod2_next;
	reg [1:0] cuenta;
	// sync counters
	reg [9:0] h_count_reg, h_count_next;
	reg [9:0] v_count_reg , v_count_next ;
	// output buffer
	reg v_sync_reg , h_sync_reg ;
	wire v_sync_next , h_sync_next ;
	// señal de estado
	wire h_end , v_end , pixel_tick;
	
	// cuerpo del registro

	always @( posedge clk , posedge reset)
		if (reset)
			begin
			cuenta <= 0;
			mod2_reg <= 1'b0;
			v_count_reg <= 0;
			h_count_reg <= 0;
			v_sync_reg <= 1'b0;
			h_sync_reg <= 1'b0;
		end
		else
			begin
			cuenta <= cuenta + 2'b01;
			mod2_reg <= mod2_next ;
			v_count_reg <= v_count_next;
			h_count_reg <= h_count_next;
			v_sync_reg <= v_sync_next ;
			h_sync_reg <= h_sync_next ;
		end
		
		//circuito mod-2 para generar un tick de habilitacion de 25 MHz
	assign pixel_tick = mod2_reg;
	// señales de estado
	// final del contador horizontal (799)
	assign h_end = (h_count_reg == (HD+HF+HB+HR-1));
	// final del contador vertical (524)
	assign v_end = (v_count_reg ==(VD+VF+VB+VR-1));
	
	always @*
	begin
		if (cuenta ==  fre)
			mod2_next = 1;
		else 
			mod2_next = 0;
	end
	
	//logica de estado siguiente para contador de sincronizacion horizontal mod-800.
	always @*
		if (pixel_tick) // Pulso de 25 MHz.
			if (h_end)
				h_count_next = 0;
			else
				h_count_next = h_count_reg + 9'b01;
		else
			h_count_next = h_count_reg;
			
	//logica de estado siguiente para contador de sincronizacion vertical mod-525.
	always @*
		if(pixel_tick & h_end)
			if (v_end)
				v_count_next = 0;
			else 
				v_count_next = v_count_reg + 9'b01;
		else
			v_count_next = v_count_reg;
			
	assign h_sync_next = (h_count_reg >= (HD+HB) && h_count_reg <= (HD+HB+HR-1));
	assign v_sync_next = (v_count_reg >= (VD+VB) && v_count_reg <= (VD+VB+VR-1));
	
	//video on/off
	
	assign video_on = (h_count_reg < HD) && (v_count_reg < VD);
	
	//salida
	assign hsync = h_sync_reg;
	assign vsync = v_sync_reg;
	assign pixel_x = h_count_reg;
	assign pixel_y = v_count_reg;
	assign p_tick = pixel_tick;


endmodule
