`timescale 1ns / 10ps

module counthours(
		input wire clk,
		input wire aumentar, disminuir,
		output reg [7:0] counthours
    );
	 
initial counthours = 0;
	
always @(posedge clk) begin
	if ((aumentar)&&(counthours == 23))
		counthours = 0;
	else if ((aumentar)&&(counthours != 23))
		counthours = counthours + 1'b1;
	else if ((disminuir)&&(counthours != 0)) 
		counthours = counthours - 1'b1;
	else if ((disminuir)&&(counthours == 0))
		counthours = 23;
end
endmodule
