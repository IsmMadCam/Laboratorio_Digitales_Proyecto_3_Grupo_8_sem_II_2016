`timescale 1ns / 1ps

module controlador_teclado(
		input wire clk, reset,
		input wire ps2d, ps2c,
		output reg [7:0] ascii_code
	);

//Declaración de señales de conexión
wire [7:0] dout;
wire rx_done_tick;
wire gotten_code_flag;
wire [7:0] key_code;
reg [7:0] key_code_reg, key_code_next;

//Para la máquina de estados del registro de la tecla
reg [1:0] state_current, state_next;

localparam [1:0] hold_key_code = 2'b0, read_key_code = 2'b01, reset_key_code = 2'b10;

ps2_rx instancia_ps2_rx  
(
.clk(clk),
.reset(reset),
.ps2d(ps2d),
.ps2c(ps2c),
.rx_en(1'b1),
.rx_done_tick(rx_done_tick),
.dout(dout)
);

key_id instancia_key_id
(
.clk(clk),
.reset(reset),
.rx_done_tick(rx_done_tick),
.dout(dout),//Utilizar solo los bits que realmente contienen el código de la tecla [8:1]
.gotten_code_flag(gotten_code_flag) //Bandera para actualizar el FIFO
);
/*
key2ascii instancia_key2ascii
(
.key_code(key_code),
.ascii_code(ascii_code)
);
*/
//===================================================
// Registro para conservar la última tecla presionada
//===================================================
//Secuencial
always@(posedge clk)
begin
	if(reset) begin
		key_code_reg <= 8'b0;
		state_current <= hold_key_code;
	end
	else begin
		key_code_reg <= key_code_next;
		state_current <= state_next;
	end
end
//Lógica de estado siguiente
always @(*) //changes
	begin
	state_next = state_current;
		case(state_current)
			hold_key_code: //state
			begin
			key_code_next = key_code_reg;
				if(gotten_code_flag) state_next = read_key_code;
				else state_next = state_current;
			end
			read_key_code: //state
			begin	
			key_code_next = dout[7:0]; //Utilizar solo los bits que realmente contienen el código de la tecla
			/*if () *///state_next = reset_key_code; // 
			/*else*/ state_next = reset_key_code;
			end
			reset_key_code: //state
			begin
			key_code_next = 8'b0;
			state_next = hold_key_code;
			end
			default: //state
			begin
				key_code_next = key_code_reg;
				state_next = state_current;
			end
		endcase
	end
	
assign key_code = key_code_reg;

always@(*)
begin
	case(key_code)
		8'h00: ascii_code = 8'h00;//espera
		8'h3c: ascii_code = 8'h55;//U (UP)
		8'h23: ascii_code = 8'h44;//D (DOWN)
		8'h4b: ascii_code = 8'h4c;//L (LEFT)
		8'h2d: ascii_code = 8'h52;//R (RIGHT)
		8'h33: ascii_code = 8'h48;//H (HORA)
		8'h2b: ascii_code = 8'h46;//F (FECHA)
		8'h2c: ascii_code = 8'h54;//T (TIMER)
		8'h1c: ascii_code = 8'h41;//A (desactivar ring)
		default ascii_code = 8'b0;//NULL char
	endcase
end

endmodule
