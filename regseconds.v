`timescale 1ns / 10ps

module regseconds(
		input wire rstregsecs,
		input wire clk,
		input wire leersecs, escribirsecs,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire [3:0] tens,
		input wire [3:0] ones,
		output reg [3:0] second1,
		output reg [3:0] second2
    );
	 
always @(posedge clk) begin
	if (leersecs) begin
		if (rstregsecs) begin
			second1 <= 0;
			second2 <= 0;
		end
		else begin
			second1[3] <= lrda;
			second1[2] <= lrdb;
			second1[1] <= lrdc;
			second1[0] <= lrdd;
			second2[3] <= lrde;
			second2[2] <= lrdf;
			second2[1] <= lrdg;
			second2[0] <= lrdh;
		end
	end
	else if (escribirsecs) begin
		if (rstregsecs) begin
			second1 <= 0;
			second2 <= 0;
		end
		else begin
			second1 <= tens;
			second2 <= ones;
		end
	end
end

endmodule
