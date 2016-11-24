`timescale 1ns / 10ps

module countleftright(
		input wire clk,
		input wire izquierda, derecha,
		output reg [7:0] countleftright
    );
	 
initial countleftright = 0;

always @(posedge clk) begin
	if ((derecha)&&(countleftright == 3))
		countleftright = 0;
	else if ((derecha)&&(countleftright != 3))
		countleftright = countleftright + 1'b1;
	else if ((izquierda)&&(countleftright != 0)) 
		countleftright = countleftright - 1'b1;
	else if ((izquierda)&&(countleftright == 0))
		countleftright = 3;
end

endmodule
