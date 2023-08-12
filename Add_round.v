`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2023 05:20:33 PM
// Design Name: 
// Module Name: Add_round
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


module Add_round(
    input clk,
    input reset,
    input add_round_en,
    input result_en,
    input [127:0] data_in,
    input [127:0] key,
    output [127:0] data_out,
    output [127:0] ciphertext,
    output done
    );
    
    reg [127:0] data_reg,data_next;
    
    always @(posedge clk,negedge reset) begin
        if(!reset) begin
            data_reg <= 'b0;
        end
        else begin
            data_reg <= data_next;
        end
    end
    
    always @(*) begin
        if(add_round_en)
            data_next = data_in ^ key;
        else
            data_next = data_reg;
        if(result_en) begin
        end
        else begin
        end
    end
    
    assign done = result_en;
    assign ciphertext = done?(data_reg):(0);
    assign data_out = data_reg;

endmodule
