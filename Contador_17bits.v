`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:29:01 11/01/2016 
// Design Name: 
// Module Name:    Contador_17bits 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Contador_17bits(clk, dta);
input clk;
output dta;
initial begin
tone = 0;
counter = 0;
dta =0;
end
parameter clkdivider = 25000000/440/2;
reg [23:0] tone;
always @(posedge clk) tone <= tone+24'b1;
reg [14:0] counter;
always @(posedge clk)
if (counter==0) counter <= (tone[23] ? clkdivider-15'b1 : clkdivider/2-15'b1);
else counter <= counter-15'b1;
reg dta;
always @(posedge clk)
if (counter==0) dta <= ~dta;
endmodule
 
