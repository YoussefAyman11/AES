`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2023 05:06:12 PM
// Design Name: 
// Module Name: Inverse_shift
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


module Inverse_shift(
    input clk,
    input reset,
    input [127:0] data_in,
    input shift_en,
    output [127:0] data_out 
    );
    
    reg [127:0] data_reg,data_next;
    
    always @(posedge clk,negedge reset) begin
        if(!reset)
            data_reg <= 'b0;
        else
            data_reg <= data_next;
    end
    
    always @(*) begin
        if(shift_en)
            data_next = {data_in[127:120],data_in[23:16],data_in[47:40],data_in[71:64],data_in[95:88],data_in[119:112],data_in[15:8],data_in[39:32],data_in[63:56],data_in[87:80],data_in[111:104],data_in[7:0],data_in[31:24],data_in[55:48],data_in[79:72],data_in[103:96]};
        else
            data_next = data_reg;
    end
    
    assign data_out = data_reg;
    
endmodule

