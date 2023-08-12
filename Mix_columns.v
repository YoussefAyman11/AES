`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 01:31:09 PM
// Design Name: 
// Module Name: Mix_columns
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


module Mix_columns(
    input [127:0] data_in,
    output [127:0] data_out
    );
    
    function [7:0] M2;
        input [7:0] x;
        begin
            M2 = (x[7])?(x<<1 ^ 'h1b):(x<<1);
        end
    endfunction
    
    function [7:0] M3;
        input [7:0] x;
        begin
            M3 = M2(x) ^ x;
        end
    endfunction
    
   
    genvar i; 
    generate 
    for(i = 0; i < 4; i = i + 1) begin
         assign data_out[127-32*i:120-32*i] = M2(data_in[127-32*i:120-32*i]) ^ M3(data_in[119-32*i:112-32*i]) ^ data_in[111-32*i:104-32*i] ^ data_in[103-32*i:96-32*i];
         assign data_out[119-32*i:112-32*i] = data_in[127-32*i:120-32*i] ^ M2(data_in[119-32*i:112-32*i]) ^ M3(data_in[111-32*i:104-32*i]) ^ data_in[103-32*i:96-32*i];
         assign data_out[111-32*i:104-32*i] = data_in[127-32*i:120-32*i] ^ data_in[119-32*i:112-32*i] ^ M2(data_in[111-32*i:104-32*i]) ^ M3(data_in[103-32*i:96-32*i]);
         assign data_out[103-32*i:96-32*i] = M3(data_in[127-32*i:120-32*i]) ^ data_in[119-32*i:112-32*i] ^ data_in[111-32*i:104-32*i] ^ M2(data_in[103-32*i:96-32*i]);
    end
    endgenerate
endmodule
