`timescale 1ns / 10ps

module countmonths(
		input wire clk,
		input wire aumentar, disminuir,
		output reg [7:0] countmonths
    );

initial countmonths = 0;

always @(posedge clk) begin
	if ((aumentar)&&(countmonths == 12))
		countmonths = 1;
	else if ((aumentar)&&(countmonths != 12))
		countmonths = countmonths + 1'b1;
	else if ((disminuir)&&(countmonths != 1)) 
		countmonths = countmonths - 1'b1;
	else if ((disminuir)&&(countmonths == 1))
		countmonths = 12;
end
endmodule
