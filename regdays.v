`timescale 1ns / 10ps
module regdays(
		input wire rstregdays,
		input wire clk,
		input wire leerdays, escribirdays,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire [3:0] dtens,
		input wire [3:0] dones,
		output reg [3:0] day1,
		output reg [3:0] day2
    );
	 
always @(posedge clk) begin
	if (leerdays) begin
		if (rstregdays) begin
			day1 <= 0;
			day2 <= 0;
		end
		else begin
			day1[3] <= lrda;
			day1[2] <= lrdb;
			day1[1] <= lrdc;
			day1[0] <= lrdd;
			day2[3] <= lrde;
			day2[2] <= lrdf;
			day2[1] <= lrdg;
			day2[0] <= lrdh;
		end
	end
	else if (escribirdays) begin
		if (rstregdays) begin
			day1 <= 0;
			day2 <= 0;
		end
		else begin
			day1 <= dtens;
			day2 <= dones;
		end
	end
end

endmodule
