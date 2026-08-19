`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2026 11:54:43
// Design Name: 
// Module Name: IMME_GEN
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


module IMME_GEN(
    input wire [31:0] inst_in,
    input wire [2:0] sel_type,
    output reg [31:0] inst_out
    );
    
    always @(*) begin
        case(sel_type)
            3'b000: inst_out = {{20{inst_in[31]}}, inst_in[31:20]};            //I type 
            3'b001: inst_out = {{20{inst_in[31]}}, inst_in[31:25] , inst_in[11:7]};    //S type
            3'b010: inst_out = {{19{inst_in[31]}}, inst_in[31] , inst_in[7] , inst_in[30:25] , inst_in[11:8] , 1'b0};     //B type
            3'b011: inst_out = {inst_in[31:12] , 12'b0};     //U type
            3'b100: inst_out = {{11{inst_in[31]}} , inst_in[31] , inst_in[19:12] , inst_in[20] , inst_in[30:21] , 1'b0};    //J type
            3'b101: inst_out = 32'b0;     //R type
        endcase
    end
            
            
            
endmodule
