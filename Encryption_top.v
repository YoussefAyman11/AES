`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 06:03:42 PM
// Design Name: 
// Module Name: top
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


module top_encryption(
    input clk,
    input reset,
    input start,
    input [127:0] plaintext,
    input [127:0] key,
    output done,
    output [127:0] ciphertext
    );
    
    wire [3:0] count_sig;
    wire result_sig,expand_key_sig,shift_sig,add_round_sig;
    wire [1:0] sel_sig;
    wire [127:0] add_out,sub_out,shift_out,mix_out,add_data_in,key_out,add_key_in;
    
    mux_3x1 m1(
        .in1(plaintext),
        .in2(mix_out),
        .in3(shift_out),
        .sel(sel_sig),
        .out(add_data_in)
    );
    
    mux_2x1 m2(
        .in1(key_out),
        .in2(key),
        .sel(sel_sig[1]),
        .out(add_key_in)
    );
    
    Add_round add(
        .clk(clk),
        .reset(reset),
        .add_round_en(add_round_sig),
        .result_en(result_sig),
        .data_in(add_data_in),
        .key(add_key_in),
        .data_out(add_out),
        .ciphertext(ciphertext),
        .done(done)
    );
    
    Sub_bytes sub(
        .data_in(add_out),
        .data_out(sub_out)
    );
    
    Shift sh(
        .clk(clk),
        .reset(reset),
        .shift_en(shift_sig),
        .data_in(sub_out),
        .data_out(shift_out)
    );
    
    Mix_columns mix(
        .data_in(shift_out),
        .data_out(mix_out)
    );
    
    Key_expand key_inst(
        .clk(clk),
        .reset(reset),
        .expand_en(expand_key_sig),
        .count(count_sig),
        .key_in(add_key_in),
        .key_out(key_out)
    );
    
    fsm fsm_inst(
        .clk(clk),
        .reset(reset),
        .start(start),
        .sel(sel_sig),
        .add_round_en(add_round_sig),
        .shift_en(shift_sig),
        .expand_key_en(expand_key_sig),
        .counter(count_sig),
        .result(result_sig)
    );
    
    
endmodule
