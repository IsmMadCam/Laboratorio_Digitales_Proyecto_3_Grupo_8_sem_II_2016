`timescale 1ns / 10ps

module regminutes(
		input wire rstregmins,
		input wire clk,
		input wire leermins, escribirmins,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire [3:0] mintens,
		input wire [3:0] minones,
		output reg [3:0] min1,
		output reg [3:0] min2
    );
	 
always @(posedge clk) begin
	if (leermins) begin
		if (rstregmins) begin
			min1 <= 0;
			min2 <= 0;
		end
		else begin
			min1[3] <= lrda;
			min1[2] <= lrdb;
			min1[1] <= lrdc;
			min1[0] <= lrdd;
			min2[3] <= lrde;
			min2[2] <= lrdf;
			min2[1] <= lrdg;
			min2[0] <= lrdh;
		end
	end
	else if (escribirmins) begin
		if (rstregmins) begin
			min1 <= 0;
			min2 <= 0;
		end
		else begin
			min1 <= mintens;
			min2 <= minones;
		end
	end
end

endmodule
