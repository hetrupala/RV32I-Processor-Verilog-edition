`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: TOP_LEVEL_CPU
// Project Name:
// Target Devices:
// Tool Versions:
// Description: RV32I Single-Cycle CPU
//
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module TOP_LEVEL_CPU(
    input wire clk,
    input wire reset
    );


    // ============================================================
    // IF_UNIT SIGNALS
    // ============================================================

    wire [31:0] pc_value;
    wire [31:0] instruction;


    // ============================================================
    // DECODER SIGNALS
    // ============================================================

    wire [6:0] opcode_out;
    wire branch_out;
    wire [1:0] result_mux_out;
    wire [2:0] branch_op_out;
    wire alu_src_a_out;
    wire mem_write_out;
    wire alu_src_b_out;
    wire reg_write_out;
    wire [5:0] alu_op_out;
    wire [2:0] imm_type_out;

    wire [4:0] rs1_addr_out;
    wire [4:0] rs2_addr_out;
    wire [4:0] rd_addr_out;


    // ============================================================
    // REG_FILE SIGNALS
    // ============================================================

    wire [31:0] rs1_value;
    wire [31:0] rs2_value;


    // ============================================================
    // IMMEDIATE GENERATOR SIGNAL
    // ============================================================

    wire [31:0] immediate;


    // ============================================================
    // ALU INPUT MUX SIGNALS
    // ============================================================

    wire [31:0] a_input;
    wire [31:0] b_input;


    // ============================================================
    // ALU SIGNAL
    // ============================================================

    wire [31:0] alu_result;


    // ============================================================
    // BRANCH LOGIC SIGNAL
    // ============================================================

    wire branch_taken;


    // ============================================================
    // JUMP LOGIC SIGNALS
    // ============================================================

    wire jump_taken;
    wire [31:0] jump_target;
    wire [31:0] link_address;


    // ============================================================
    // DATA MEMORY SIGNAL
    // ============================================================

    wire [31:0] data_out;


    // ============================================================
    // WRITEBACK SIGNAL
    // ============================================================

    wire [31:0] write_data;


    // ============================================================
    // IF_UNIT
    // ============================================================

    IF_UNIT inst1 (
        .clk(clk),
        .reset(reset),

        .branch_taken(branch_taken),
        .branch_immediate(immediate),

        .jump_taken(jump_taken),
        .jump_target(jump_target),

        .pc_out(pc_value),
        .inst_out(instruction)
    );


    // ============================================================
    // DECODER
    // ============================================================

    DECODER inst2 (
        .instruction_in(instruction),

        .opcode_out(opcode_out),
        .branch_out(branch_out),
        .result_mux_out(result_mux_out),
        .branch_op_out(branch_op_out),
        .alu_src_a_out(alu_src_a_out),
        .mem_write_out(mem_write_out),
        .alu_src_b_out(alu_src_b_out),
        .reg_write_out(reg_write_out),
        .alu_op_out(alu_op_out),
        .imm_type_out(imm_type_out),

        .rs1_addr_out(rs1_addr_out),
        .rs2_addr_out(rs2_addr_out),
        .rd_addr_out(rd_addr_out)
    );


    // ============================================================
    // REGISTER FILE
    // ============================================================

    REG_FILE inst3 (
        .clk(clk),
        .reset(reset),
        .we(reg_write_out),
        .rd(write_data),
        .rd_addr(rd_addr_out),
        .rs1_addr(rs1_addr_out),
        .rs2_addr(rs2_addr_out),
        .o_rs1(rs1_value),
        .o_rs2(rs2_value)
    );


    // ============================================================
    // IMMEDIATE GENERATOR
    // ============================================================

    IMME_GEN inst4 (
        .inst_in(instruction),
        .sel_type(imm_type_out),
        .inst_out(immediate)
    );


    // ============================================================
    // ALU INPUT MUX
    // ============================================================

    ALU_INPUT_MUX inst5 (
        .rs1_value(rs1_value),
        .pc_value(pc_value),
        .alu_src_a_out(alu_src_a_out),

        .rs2_value(rs2_value),
        .immediate(immediate),
        .alu_src_b_out(alu_src_b_out),

        .a_input(a_input),
        .b_input(b_input)
    );


    // ============================================================
    // ALU
    // ============================================================

    ALU inst6 (
        .in_a(a_input),
        .in_b(b_input),
        .alu_op(alu_op_out),
        .out(alu_result)
    );


    // ============================================================
    // BRANCH LOGIC
    // ============================================================

    BRANCH_LOGIC inst7 (
        .rs1_value(rs1_value),
        .rs2_value(rs2_value),
        .branch_out(branch_out),
        .branch_op_out(branch_op_out),
        .branch_taken(branch_taken)
    );


    // ============================================================
    // JUMP LOGIC
    // ============================================================

    JUMP_LOGIC inst8 (
        .opcode(opcode_out),
        .pc_value(pc_value),
        .rs1_value(rs1_value),
        .immediate(immediate),

        .jump_taken(jump_taken),
        .jump_target(jump_target),
        .link_address(link_address)
    );


    // ============================================================
    // DATA MEMORY
    // ============================================================

    DATA_MEMORY inst9 (
        .clk(clk),
        .mem_write_out(mem_write_out),
        .mem_size(2'b10),
        .sign_ext(1'b1),
        .rs2_value(rs2_value),
        .alu_out(alu_result),
        .data_out(data_out)
    );


    // ============================================================
    // WRITEBACK MUX
    // ============================================================

    WRITEBACK_MUX inst10 (
        .alu_out(alu_result),
        .data_out(data_out),
        .immediate(immediate),
        .link_address(link_address),
        .result_mux_out(result_mux_out),
        .write_data(write_data)
    );


endmodule