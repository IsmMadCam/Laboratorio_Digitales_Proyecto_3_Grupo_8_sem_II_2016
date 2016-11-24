`timescale 1ns / 10ps

module countyears(
		input wire clk,
		input wire aumentar, disminuir,
		output reg [7:0] countyears
    );
	 
initial countyears = 0;

always @(posedge clk) begin
	if ((aumentar)&&(countyears == 99))
		countyears = 0;
	else if ((aumentar)&&(countyears != 99))
		countyears = countyears + 1'b1;
	else if ((disminuir)&&(countyears != 0)) 
		countyears = countyears - 1'b1;
	else if ((disminuir)&&(countyears == 0))
		countyears = 99;
end

endmodule
