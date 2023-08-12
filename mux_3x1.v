`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 06:33:23 PM
// Design Name: 
// Module Name: mux_3x1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_3x1(
    input [127:0] in1,
    input [127:0] in2,
    input [127:0] in3,
    input [1:0] sel,
    output reg [127:0] out
    );
    
    always @(*) begin
        if(sel == 'b01)
            out = in1;
        else if(sel == 'b10)
            out = in2;
        else if(sel == 'b11)
            out = in3;
        else
            out = 'b0;
    end
    
endmodule
