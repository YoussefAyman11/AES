`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2023 05:53:57 PM
// Design Name: 
// Module Name: Inverse_mix_columns
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


module Inverse_mix_columns(
    input [127:0] data_in,
    output [127:0] data_out
    );
    
    function [7:0] M2;
        input [7:0] x;
        begin
            M2 = (x[7])?(x<<1 ^ 'h1b):(x<<1);
        end
    endfunction
    
    function [7:0] M9;
        input [7:0] x;
        begin
            M9 = M2(M2(M2(x))) ^ x;
        end
    endfunction
    
    function [7:0] Mb;
        input [7:0] x;
        begin
            Mb = M2(M2(M2(x))^ x) ^ x;
        end
    endfunction
    
    function [7:0] Md;
        input [7:0] x;
        begin
            Md = M2(M2(M2(x)^ x)) ^ x;
        end
    endfunction
    
   function [7:0] Me;
        input [7:0] x;
        begin
            Me = M2(M2(M2(x)^ x) ^ x);
        end
    endfunction
   
    genvar i; 
    generate 
    for(i = 0; i < 4; i = i + 1) begin
         assign data_out[127-32*i:120-32*i] = Me(data_in[127-32*i:120-32*i]) ^ Mb(data_in[119-32*i:112-32*i]) ^ Md(data_in[111-32*i:104-32*i]) ^ M9(data_in[103-32*i:96-32*i]);
         assign data_out[119-32*i:112-32*i] = M9(data_in[127-32*i:120-32*i]) ^ Me(data_in[119-32*i:112-32*i]) ^ Mb(data_in[111-32*i:104-32*i]) ^ Md(data_in[103-32*i:96-32*i]);
         assign data_out[111-32*i:104-32*i] = Md(data_in[127-32*i:120-32*i]) ^ M9(data_in[119-32*i:112-32*i]) ^ Me(data_in[111-32*i:104-32*i]) ^ Mb(data_in[103-32*i:96-32*i]);
         assign data_out[103-32*i:96-32*i] = Mb(data_in[127-32*i:120-32*i]) ^ Md(data_in[119-32*i:112-32*i]) ^ M9(data_in[111-32*i:104-32*i]) ^ Me(data_in[103-32*i:96-32*i]);
    end
    endgenerate
endmodule
