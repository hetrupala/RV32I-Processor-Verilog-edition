`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: JUMP_LOGIC
// Project Name:
// Target Devices:
// Tool Versions:
// Description: JAL and JALR jump control and target generation
//
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module JUMP_LOGIC(
    input wire [6:0] opcode,
    input wire [31:0] pc_value,
    input wire [31:0] rs1_value,
    input wire [31:0] immediate,

    output reg jump_taken,
    output reg [31:0] jump_target,
    output reg [31:0] link_address
    );

    always @(*) begin

        // Default values
        jump_taken  = 1'b0;
        jump_target = 32'b0;
        link_address = pc_value + 32'h00000004;

        case (opcode)

            7'b1101111: begin
                // JAL
                //
                // PC = PC + J-immediate
                // rd = PC + 4

                jump_taken  = 1'b1;
                jump_target = pc_value + immediate;

            end

            7'b1100111: begin
                // JALR
                //
                // PC = (rs1 + I-immediate) & ~1
                // rd = PC + 4

                jump_taken  = 1'b1;
                jump_target = (rs1_value + immediate) & 32'hFFFFFFFE;

            end

            default: begin
                jump_taken  = 1'b0;
                jump_target = 32'b0;
            end

        endcase

    end

endmodule