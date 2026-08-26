`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: BRANCH_LOGIC
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Conditional branch comparison logic
//
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module BRANCH_LOGIC(
    input wire [31:0] rs1_value,
    input wire [31:0] rs2_value,
    input wire branch_out,
    input wire [2:0] branch_op_out,
    output reg branch_taken
    );

    always @(*) begin

        // Default: branch is not taken
        branch_taken = 1'b0;

        if (branch_out) begin

            case (branch_op_out)

                3'b000: begin
                    // BEQ
                    if (rs1_value == rs2_value)
                        branch_taken = 1'b1;
                end

                3'b001: begin
                    // BNE
                    if (rs1_value != rs2_value)
                        branch_taken = 1'b1;
                end

                3'b100: begin
                    // BLT - signed comparison
                    if ($signed(rs1_value) < $signed(rs2_value))
                        branch_taken = 1'b1;
                end

                3'b101: begin
                    // BGE - signed comparison
                    if ($signed(rs1_value) >= $signed(rs2_value))
                        branch_taken = 1'b1;
                end

                3'b110: begin
                    // BLTU - unsigned comparison
                    if (rs1_value < rs2_value)
                        branch_taken = 1'b1;
                end

                3'b111: begin
                    // BGEU - unsigned comparison
                    if (rs1_value >= rs2_value)
                        branch_taken = 1'b1;
                end

                default: begin
                    branch_taken = 1'b0;
                end

            endcase

        end

    end

endmodule