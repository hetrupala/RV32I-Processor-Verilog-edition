`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2026 21:58:17
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE(
    input clk,
    input reset,
    input we,
    input [31:0] rd,
    input [4:0] rd_addr,
    input [4:0] rs1_addr,
    input [4:0] rs2_addr,
    output [31:0] o_rs1,
    output [31:0] o_rs2
    );
    
    reg [31:0] Registers [0:31];      //32 registers , each having 32bit of length
    integer i;
    
    always @(posedge clk) begin
        if(reset)begin
            for(i = 0; i < 32; i = i + 1)begin
                Registers [i] <= 32'b0;
            end
        end    
        else begin
            if(we == 1)begin
                if(rd_addr != 5'b00000)begin
                    Registers[rd_addr] <= rd;
                end
            end    
        end
    end
    
    
    assign o_rs1 = (rs1_addr == 5'b00000)? 32'b0 : Registers[rs1_addr];
    
    assign o_rs2 = (rs2_addr == 5'b00000)? 32'b0 : Registers[rs2_addr];
                
endmodule
