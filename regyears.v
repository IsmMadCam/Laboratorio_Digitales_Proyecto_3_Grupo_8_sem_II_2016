`timescale 1ns / 10ps

module regyears(
		input wire rstregyears,
		input wire clk,
		input wire leeryears, escribiryears,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire [3:0] ytens,
		input wire [3:0] yones,
		output reg [3:0] year1,
		output reg [3:0] year2
    );

always @(posedge clk) begin
	if (leeryears) begin
		if (rstregyears) begin
			year1 <= 0;
			year2 <= 0;
		end
		else begin
			year1[3] <= lrda;
			year1[2] <= lrdb;
			year1[1] <= lrdc;
			year1[0] <= lrdd;
			year2[3] <= lrde;
			year2[2] <= lrdf;
			year2[1] <= lrdg;
			year2[0] <= lrdh;
		end
	end
	else if (escribiryears) begin
		if (rstregyears) begin
			year1 <= 0;
			year2 <= 0;
		end
		else begin
			year1 <= ytens;
			year2 <= yones;
		end
	end
end

endmodule
