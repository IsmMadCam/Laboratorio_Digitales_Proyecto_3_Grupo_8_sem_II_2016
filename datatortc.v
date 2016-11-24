`timescale 1ns / 1ps

module datatortc(
		input wire clk, reset,
		input wire fkda, fkdb, fkdc, fkdd, fkde, fkdf, fkdg, fkdh,
		input wire fkaa, fkab, fkac, fkad, fkae, fkaf, fkag, fkah,
		input wire listoe, listod,
		output reg dartc, dbrtc, dcrtc, ddrtc, dertc, dfrtc, dgrtc, dhrtc
    );
	 
localparam STATE_Initial = 3'b000,
	STATE_1 = 3'b001, 
	STATE_2 = 3'b010,
	STATE_3_PlaceHolder = 3'b011;

reg[1:0] CurrentState;
reg[1:0] NextState;

always @(posedge clk) begin
	if (reset) CurrentState <= STATE_Initial;
	else CurrentState <= NextState;
end
	 
always @(*) begin
	NextState = CurrentState;
	case (CurrentState)
		STATE_Initial: begin
			if (listod) NextState = STATE_1;
			else if (listoe) NextState = STATE_2;
			dartc <= 0;
			dbrtc <= 0;
			dcrtc <= 0;
			ddrtc <= 0;
			dertc <= 0;
			dfrtc <= 0;
			dgrtc <= 0;
			dhrtc <= 0;
		end
		STATE_1: begin
			dartc <= fkaa;
			dbrtc <= fkab;
			dcrtc <= fkac;
			ddrtc <= fkad;
			dertc <= fkae;
			dfrtc <= fkaf;
			dgrtc <= fkag;
			dhrtc <= fkah;
		end
		STATE_2: begin
			dartc <= fkda;
			dbrtc <= fkdb;
			dcrtc <= fkdc;
			ddrtc <= fkdd;
			dertc <= fkde;
			dfrtc <= fkdf;
			dgrtc <= fkdg;
			dhrtc <= fkdh;
		end
		STATE_3_PlaceHolder: begin
			NextState = STATE_Initial;
		end
	endcase
end

endmodule
