`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 03:38:36 PM
// Design Name: 
// Module Name: Key_expand
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


module Key_expand(
    input clk,
    input reset,
    input expand_en,
    input [3:0] count, 
    input [127:0] key_in,
    output [127:0] key_out
    );

    wire [31:0] data;
    reg [31:0] data1;
    reg [31:0] data2;
    
    reg [127:0] data_reg,data_next;
    
    always @(posedge clk,negedge reset) begin
        if(!reset)
            data_reg <= 'b0;
        else
            data_reg <= data_next;
    end
    
    genvar i;
    generate
    for(i = 0; i < 4; i = i + 1) begin
        SBox s(
            .addr(key_in[31-8*i:24-8*i]),
            .dout(data[31-8*i:24-8*i])
        );
    end
    endgenerate
    
    always @(*) begin
        data1 = data;
        case(count)
            'd1: data1 = data ^ 32'h00010000;
            'd2: data1 = data ^ 32'h00020000;
            'd3: data1 = data ^ 32'h00040000;
            'd4: data1 = data ^ 32'h00080000;
            'd5: data1 = data ^ 32'h00100000;
            'd6: data1 = data ^ 32'h00200000;
            'd7: data1 = data ^ 32'h00400000;
            'd8: data1 = data ^ 32'h00800000;
            'd9: data1 = data ^ 32'h001b0000;
            'd10: data1 = data ^ 32'h00360000;
            default: data1 = data;
        endcase
        data2 = {data1[23:0],data1[31:24]};
    end
    
    always @(*) begin
        if(expand_en) begin
            data_next[127:96] = key_in[127:96] ^ data2;
            data_next[95:64] = key_in[95:64] ^ key_in[127:96] ^ data2;
            data_next[63:32] = key_in[63:32] ^ key_in[95:64] ^ key_in[127:96] ^ data2;
            data_next[31:0] = key_in[31:0] ^ key_in[63:32] ^ key_in[95:64] ^ key_in[127:96] ^ data2;
        end
        else
            data_next = data_reg;
    end
    
    assign key_out = data_reg;
endmodule
