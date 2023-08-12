`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2023 04:46:58 PM
// Design Name: 
// Module Name: fsm
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


module fsm(
    input clk,
    input reset,
    input start,
    output [1:0] sel,
    output reg add_round_en,
    output reg shift_en,
    output reg expand_key_en,
    output [3:0] counter,
    output result
    );
    
    localparam [2:0] add_round = 3'b000;
    localparam [2:0] sub_bytes = 3'b001;
    localparam [2:0] shift = 3'b010;
    localparam [2:0] mix_columns = 3'b011;
    localparam [2:0] idle = 3'b100;
    
    reg [2:0] state_reg,state_next;
    reg [1:0] sel_reg,sel_next; 
    reg [3:0] count_reg,count_next; 
    reg done_reg,done_next;
    
    always @(posedge clk, negedge reset) begin
        if(!reset)begin
            state_reg <= idle;
            count_reg <= 'b0;
            sel_reg <= 'b01;
            done_reg <= 0;
        end
        else begin
            state_reg <= state_next;
            count_reg <= count_next;
            sel_reg <= sel_next;
            done_reg <= done_next;
        end

    end
    
    always @(*) begin
        done_next = done_reg;
        count_next = count_reg;
        state_next = state_reg;
        add_round_en = 'b0;
        shift_en = 'b0;
        expand_key_en = 'b0;
        sel_next = sel_reg;
        
        case(state_reg)
            idle: begin
                if(start) begin
                    state_next = add_round;
                    count_next = 'b0;
                    done_next = 0;
                end
                else begin
                    state_next = state_reg;
                end    
            end
            add_round: begin
                    if(count_reg == 'd0) begin
                        sel_next = 'b01;
                        state_next = sub_bytes;
                        count_next = count_reg + 1;
                        add_round_en = 'b1;
                    end
                    else if(count_reg > 'd0 & count_reg < 'd10) begin
                        sel_next = 'b10;
                        state_next = sub_bytes; 
                        count_next = count_reg + 1;
                        add_round_en = 'b1;
                    end
                    else if(count_reg == 'd10) begin
                        sel_next = 'b11;
                        state_next = state_reg;
                        count_next = count_reg + 1;
                        add_round_en = 'b1;
                    end
                    else begin
                        sel_next = 'b11;
                        state_next = idle;
                        count_next = count_reg;
                        add_round_en = 'b0;
                        done_next = 1;
                    end
                end
            
            sub_bytes: begin
                expand_key_en = 'b1;
                state_next = shift;
            end
            
            shift: begin
                if(count_reg != 10)
                    state_next = mix_columns;
                else
                    state_next = add_round;
                shift_en = 'b1;
            end
            
            mix_columns: begin
                state_next = add_round;
            end

            default: begin
                count_next = count_reg;
                state_next = state_reg;
                add_round_en = 'b1;
                shift_en = 'b0;
                expand_key_en = 'b0;
                sel_next = sel_reg;
            end
        endcase 
    end
    
    assign result = done_reg;
    assign counter = count_reg;
    assign sel = sel_next;
    
endmodule
