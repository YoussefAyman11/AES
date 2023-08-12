`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 12:43:58 AM
// Design Name: 
// Module Name: decryption_tb
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


module decryption_tb();

parameter clk_period = 10;
reg clk = 0; 
always #(clk_period/2) clk = ~clk;

reg [127:0] ciphertext,key;
reg start,reset;
wire [127:0] plaintext;
wire done;

decryption_top dut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .ciphertext(ciphertext),
    .key(key),
    .done(done),
    .plaintext(plaintext)
);
initial begin
    reset=0;
    start=0;
    #(clk_period);
    reset=1;
    
    #(clk_period);
    ciphertext = 'h29c3505f571420f6402299b31a02d73a;
    key =  'h5468617473206D79204B756E67204675;
    #(10*clk_period);
    
    start=1;
    #(clk_period);
    start=0;
    #(1000*clk_period);
    
    reset=0;
    #(clk_period);
    reset=1;
    start=1;
    
    ciphertext = 'h69c4e0d86a7b0430d8cdb78070b4c55a;
    key =  'h000102030405060708090a0b0c0d0e0f;
    #(clk_period);
    start = 0;
    #(1000*clk_period);

    
    $finish();
end
endmodule