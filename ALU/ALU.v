`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 13.08.2026 14:43:58
// Design Name:
// Module Name: ALU
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    input  wire [31:0] in_a,
    input  wire [31:0] in_b,
    input  wire [5:0]  alu_op,
    output reg  [31:0] out
    );

    always @(*) begin

        case(alu_op)

            6'b000000: begin
                out = in_a + in_b;             // ADD / ADDI
            end

            6'b000001: begin
                out = in_a - in_b;             // SUB
            end

            6'b000010: begin
                out = in_a & in_b;             // AND / ANDI
            end

            6'b000011: begin
                out = in_a | in_b;             // OR / ORI
            end

            6'b000100: begin
                out = in_a ^ in_b;             // XOR / XORI
            end

            6'b000101: begin
                if ($signed(in_a) < $signed(in_b))
                    out = 32'b1;
                else
                    out = 32'b0;               // SLT / SLTI
            end

            6'b000110: begin
                if (in_a < in_b)
                    out = 32'b1;
                else
                    out = 32'b0;               // SLTU / SLTIU
            end

            6'b000111: begin
                out = in_a << in_b[4:0];       // SLL / SLLI
            end

            6'b001000: begin
                out = in_a >> in_b[4:0];       // SRL / SRLI
            end

            6'b001001: begin
                out = $signed(in_a) >>> in_b[4:0]; // SRA / SRAI
            end

            default: begin
                out = 32'b0;
            end

        endcase

    end

endmodule