`timescale 1ns / 10ps

module countseconds(
		input wire clk,
		input wire aumentar, disminuir,
		output reg [7:0] countsecs
    );

initial countsecs = 0;

always @(posedge clk) begin
	if ((aumentar)&&(countsecs == 59))
		countsecs = 0;
	else if ((aumentar)&&(countsecs != 59))
		countsecs = countsecs + 1'b1;
	else if ((disminuir)&&(countsecs != 0)) 
		countsecs = countsecs - 1'b1;
	else if ((disminuir)&&(countsecs == 0))
		countsecs = 59;
end
endmodule
