`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 12:41:57 AM
// Design Name: 
// Module Name: Inverse_sub_bytes
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


module Inverse_sub_bytes(
    input [127:0] data_in,
    output [127:0] data_out
    );

    wire [127:0] data;
    
    genvar i;
    generate
    for(i = 0; i < 16; i = i + 1) begin
            Inverse_SBox s(
                .addr(data_in[127-8*i:120-8*i]),
                .dout(data[127-8*i:120-8*i])
            );
    end
    endgenerate

    assign data_out = data;
    
endmodule
