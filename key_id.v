`timescale 1ns / 1ps

module key_id(
		input wire clk, reset,
		input wire rx_done_tick,
		input wire [7:0] dout,//Utilizar solo los bits que realmente contienen el código de la tecla
		output reg gotten_code_flag //Bandera para actualizar el FIFO
    );

localparam break_code = 8'hF0;

localparam wait_break_code = 1'b0;
localparam get_code = 1'b1;
/*localparam interruption = 2'b10;*/

reg state_next, state_reg;

//FSM
always @(posedge clk, posedge reset)
	if (reset)
		state_reg <= wait_break_code;
	else
		state_reg <= state_next;
		
//NEXT STATE LOGIC
always @*
begin
	gotten_code_flag = 1'b0;
	state_next = state_reg;
	case (state_reg)
		wait_break_code:  // Espera "break code"
			if (rx_done_tick == 1'b1 && dout == break_code)
				state_next = get_code;
			else begin
				state_next = wait_break_code;
				gotten_code_flag =1'b0;
				end
		get_code:  // Obtener el próximo código
			if (rx_done_tick)
				begin
					gotten_code_flag =1'b1;
					state_next = wait_break_code;
				end
	endcase
end
endmodule
