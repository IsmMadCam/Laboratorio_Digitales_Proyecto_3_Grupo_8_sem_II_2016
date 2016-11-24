`timescale 1ns / 10ps

module countminutes(
		input wire clk,
		input wire aumentar, disminuir,
		output reg [7:0] countmins
    );
	 
initial countmins = 0;

always @(posedge clk) begin
	if ((aumentar)&&(countmins == 59))
		countmins = 0;
	else if ((aumentar)&&(countmins != 59))
		countmins = countmins + 1'b1;
	else if ((disminuir)&&(countmins != 0)) 
		countmins = countmins - 1'b1;
	else if ((disminuir)&&(countmins == 0))
		countmins = 59;
end

endmodule
