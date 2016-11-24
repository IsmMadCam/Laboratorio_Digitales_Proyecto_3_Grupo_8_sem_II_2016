`timescale 1ns / 10ps

module countdays(
		input wire clk,
		input wire aumentar, disminuir,
		output reg [7:0] countdays
    );
	 
initial countdays = 0;
	
always @(posedge clk) begin
	if ((aumentar)&&(countdays == 31))
		countdays = 1;
	else if ((aumentar)&&(countdays != 31))
		countdays = countdays + 1'b1;
	else if ((disminuir)&&(countdays != 1)) 
		countdays = countdays - 1'b1;
	else if ((disminuir)&&(countdays == 1))
		countdays = 31;
end
endmodule
