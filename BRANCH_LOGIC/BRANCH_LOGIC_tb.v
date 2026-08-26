`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: BRANCH_LOGIC_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Branch Logic Testbench
//
//////////////////////////////////////////////////////////////////////////////////

module BRANCH_LOGIC_tb;

    reg [31:0] rs1_value;
    reg [31:0] rs2_value;
    reg branch_out;
    reg [2:0] branch_op_out;

    wire branch_taken;


    BRANCH_LOGIC uut (
        .rs1_value(rs1_value),
        .rs2_value(rs2_value),
        .branch_out(branch_out),
        .branch_op_out(branch_op_out),
        .branch_taken(branch_taken)
    );


    initial begin

        // ============================================================
        // BEQ
        // ============================================================

        // 10 == 10 ? branch taken
        branch_out = 1'b1;
        branch_op_out = 3'b000;
        rs1_value = 32'd10;
        rs2_value = 32'd10;
        #10;

        // 10 != 20 ? branch not taken
        rs1_value = 32'd10;
        rs2_value = 32'd20;
        #10;


        // ============================================================
        // BNE
        // ============================================================

        // 10 != 20 ? branch taken
        branch_op_out = 3'b001;
        rs1_value = 32'd10;
        rs2_value = 32'd20;
        #10;

        // 10 == 10 ? branch not taken
        rs1_value = 32'd10;
        rs2_value = 32'd10;
        #10;


        // ============================================================
        // BLT - SIGNED
        // ============================================================

        // 10 < 20 ? branch taken
        branch_op_out = 3'b100;
        rs1_value = 32'd10;
        rs2_value = 32'd20;
        #10;

        // 20 < 10 ? branch not taken
        rs1_value = 32'd20;
        rs2_value = 32'd10;
        #10;

        // -10 < 10 ? branch taken
        rs1_value = -32'sd10;
        rs2_value = 32'sd10;
        #10;


        // ============================================================
        // BGE - SIGNED
        // ============================================================

        // 20 >= 10 ? branch taken
        branch_op_out = 3'b101;
        rs1_value = 32'd20;
        rs2_value = 32'd10;
        #10;

        // 10 >= 20 ? branch not taken
        rs1_value = 32'd10;
        rs2_value = 32'd20;
        #10;

        // -5 >= -10 ? branch taken
        rs1_value = -32'sd5;
        rs2_value = -32'sd10;
        #10;


        // ============================================================
        // BLTU - UNSIGNED
        // ============================================================

        // 10 < 20 ? branch taken
        branch_op_out = 3'b110;
        rs1_value = 32'd10;
        rs2_value = 32'd20;
        #10;

        // 20 < 10 ? branch not taken
        rs1_value = 32'd20;
        rs2_value = 32'd10;
        #10;

        // 0xFFFFFFFF < 1 ? false for unsigned
        rs1_value = 32'hFFFFFFFF;
        rs2_value = 32'h00000001;
        #10;


        // ============================================================
        // BGEU - UNSIGNED
        // ============================================================

        // 20 >= 10 ? branch taken
        branch_op_out = 3'b111;
        rs1_value = 32'd20;
        rs2_value = 32'd10;
        #10;

        // 10 >= 20 ? branch not taken
        rs1_value = 32'd10;
        rs2_value = 32'd20;
        #10;

        // 0xFFFFFFFF >= 1 ? branch taken for unsigned
        rs1_value = 32'hFFFFFFFF;
        rs2_value = 32'h00000001;
        #10;


        // ============================================================
        // branch_out = 0
        // Even if branch_op is valid, branch must not be taken.
        // ============================================================

        branch_out = 1'b0;
        branch_op_out = 3'b000;
        rs1_value = 32'd10;
        rs2_value = 32'd10;
        #10;


        $finish;

    end

endmodule