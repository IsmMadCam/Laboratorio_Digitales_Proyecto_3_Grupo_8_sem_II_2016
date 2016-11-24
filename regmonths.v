`timescale 1ns / 10ps

module regmonths(
		input wire rstregmonths,
		input wire clk,
		input wire leermonths, escribirmonths,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire [3:0] mtens,
		input wire [3:0] mones,
		output reg [3:0] month1,
		output reg [3:0] month2
    );
	 
always @(posedge clk) begin
	if (leermonths) begin
		if (rstregmonths) begin
			month1 <= 0;
			month2 <= 0;
		end
		else begin
			month1[3] <= lrda;
			month1[2] <= lrdb;
			month1[1] <= lrdc;
			month1[0] <= lrdd;
			month2[3] <= lrde;
			month2[2] <= lrdf;
			month2[1] <= lrdg;
			month2[0] <= lrdh;
		end
	end
	else if (escribirmonths) begin
		if (rstregmonths) begin
			month1 <= 0;
			month2 <= 0;
		end
		else begin
			month1 <= mtens;
			month2 <= mones;
		end
	end
end


endmodule
