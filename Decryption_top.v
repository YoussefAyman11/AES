`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 12:17:44 AM
// Design Name: 
// Module Name: decryption_top
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


module decryption_top(
    input clk,
    input reset,
    input start,
    input [127:0] ciphertext,
    input [127:0] key,
    output done,
    output [127:0] plaintext
    );
    
   wire add_round_sig,result_sig,sel_sig,shift_sig;
   wire [127:0] add_in,sub_out,add_out,mix_out,shift_in,shift_out;
   wire [1407:0] key_out;
   wire [3:0] count_sig;
    
    mux_2x1 m1(
        .in1(sub_out),
        .in2(ciphertext),
        .sel(sel_sig),
        .out(add_in)
    );
    
    mux_2x1 m2(
        .in1(mix_out),
        .in2(add_out),
        .sel(sel_sig),
        .out(shift_in)
    );
    
    Add_round add(
        .clk(clk),
        .reset(reset),
        .add_round_en(add_round_sig),
        .result_en(result_sig),
        .data_in(add_in),
        .key(key_out[count_sig*128 +: 128]),
        .data_out(add_out),
        .ciphertext(plaintext),
        .done(done)
    );
    
    Inverse_mix_columns mix(
        .data_in(add_out),
        .data_out(mix_out)
    );
    
    Inverse_shift sh(
        .clk(clk),
        .reset(reset),
        .shift_en(shift_sig),
        .data_in(shift_in),
        .data_out(shift_out)
    );
    
    
    Inverse_key_expand key_inst(
        .key_in(key),
        .key_out(key_out)
    );
    
    Inverse_sub_bytes sub(
        .data_in(shift_out),
        .data_out(sub_out)
    );
    
    Inverse_fsm fsm_inst(
        .clk(clk),
        .reset(reset),
        .start(start),
        .sel(sel_sig),
        .add_round_en(add_round_sig),
        .shift_en(shift_sig),
        .counter(count_sig),
        .result(result_sig)
    );
endmodule
