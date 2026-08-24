`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2026 11:25:57
// Design Name: 
// Module Name: DECODER_tb
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


module DECODER_tb;

    reg [31:0] instruction_in;

    wire [6:0] opcode_out;
    wire branch_out;
    wire [1:0] result_mux_out;
    wire [2:0] branch_op_out;
    wire alu_src_a_out;
    wire mem_write_out;
    wire alu_src_b_out;
    wire reg_write_out;
    wire [5:0] alu_op_out;

    // New output from DECODER
    wire [2:0] imm_type_out;

    wire [4:0] rs1_addr_out;
    wire [4:0] rs2_addr_out;
    wire [4:0] rd_addr_out;


    DECODER uut (
        .instruction_in(instruction_in),
        .opcode_out(opcode_out),
        .branch_out(branch_out),
        .result_mux_out(result_mux_out),
        .branch_op_out(branch_op_out),
        .alu_src_a_out(alu_src_a_out),
        .mem_write_out(mem_write_out),
        .alu_src_b_out(alu_src_b_out),
        .reg_write_out(reg_write_out),
        .alu_op_out(alu_op_out),

        // New decoder output
        .imm_type_out(imm_type_out),

        .rs1_addr_out(rs1_addr_out),
        .rs2_addr_out(rs2_addr_out),
        .rd_addr_out(rd_addr_out)
    );


    initial begin


        // ============================================================
        // R-TYPE INSTRUCTIONS
        // imm_type = 101
        // ============================================================

        // ADD x3, x1, x2
        instruction_in = 32'h002081B3;
        #10;

        // SUB x4, x2, x1
        instruction_in = 32'h40110233;
        #10;

        // SLL x5, x1, x2
        instruction_in = 32'h002092B3;
        #10;

        // SLT x6, x1, x2
        instruction_in = 32'h0020A333;
        #10;

        // SLTU x7, x1, x2
        instruction_in = 32'h0020B3B3;
        #10;

        // XOR x8, x1, x2
        instruction_in = 32'h0020C433;
        #10;

        // SRL x9, x1, x2
        instruction_in = 32'h0020D4B3;
        #10;

        // SRA x10, x1, x2
        instruction_in = 32'h4020D533;
        #10;

        // OR x11, x1, x2
        instruction_in = 32'h0020E5B3;
        #10;

        // AND x12, x1, x2
        instruction_in = 32'h0020F633;
        #10;


        // ============================================================
        // I-TYPE OP-IMM INSTRUCTIONS
        // imm_type = 000
        // ============================================================

        // ADDI x3, x1, 10
        instruction_in = 32'h00A08193;
        #10;

        // SLLI x9, x1, 3
        instruction_in = 32'h00309493;
        #10;

        // SLTI x4, x2, 5
        instruction_in = 32'h00512213;
        #10;

        // SLTIU x5, x2, 5
        instruction_in = 32'h00513293;
        #10;

        // XORI x6, x1, 10
        instruction_in = 32'h00A0C313;
        #10;

        // SRLI x10, x1, 3
        instruction_in = 32'h0030D513;
        #10;

        // SRAI x11, x1, 3
        instruction_in = 32'h4030D593;
        #10;

        // ORI x7, x1, 10
        instruction_in = 32'h00A0E393;
        #10;

        // ANDI x8, x1, 10
        instruction_in = 32'h00A0F413;
        #10;


        // ============================================================
        // LOAD TYPE INSTRUCTIONS
        // imm_type = 000
        // ============================================================

        // LB x3, 8(x1)
        // opcode = 0000011
        // funct3 = 000
        instruction_in = 32'h00808183;
        #10;

        // LH x4, 8(x1)
        // opcode = 0000011
        // funct3 = 001
        instruction_in = 32'h00809203;
        #10;

        // LW x5, 8(x1)
        // opcode = 0000011
        // funct3 = 010
        instruction_in = 32'h0080A283;
        #10;

        // LBU x6, 8(x1)
        // opcode = 0000011
        // funct3 = 100
        instruction_in = 32'h0080C303;
        #10;

        // LHU x7, 8(x1)
        // opcode = 0000011
        // funct3 = 101
        instruction_in = 32'h0080D383;
        #10;


        // ============================================================
        // S-TYPE / STORE INSTRUCTIONS
        // imm_type = 001
        // ============================================================

        // SB x5, 8(x1)
        // opcode = 0100011
        // funct3 = 000
        instruction_in = 32'h00508423;
        #10;

        // SH x5, 8(x1)
        // opcode = 0100011
        // funct3 = 001
        instruction_in = 32'h00509423;
        #10;

        // SW x5, 8(x1)
        // opcode = 0100011
        // funct3 = 010
        instruction_in = 32'h0050A423;
        #10;


        // ============================================================
        // B-TYPE / BRANCH INSTRUCTIONS
        // imm_type = 010
        // ============================================================

        // BEQ x1, x2, 16
        // opcode = 1100011
        // funct3 = 000
        instruction_in = 32'h00208863;
        #10;

        // BNE x1, x2, 16
        // opcode = 1100011
        // funct3 = 001
        instruction_in = 32'h00209863;
        #10;

        // BLT x1, x2, 16
        // opcode = 1100011
        // funct3 = 100
        instruction_in = 32'h0020C863;
        #10;

        // BGE x1, x2, 16
        // opcode = 1100011
        // funct3 = 101
        instruction_in = 32'h0020D863;
        #10;

        // BLTU x1, x2, 16
        // opcode = 1100011
        // funct3 = 110
        instruction_in = 32'h0020E863;
        #10;

        // BGEU x1, x2, 16
        // opcode = 1100011
        // funct3 = 111
        instruction_in = 32'h0020F863;
        #10;


        // ============================================================
        // U-TYPE INSTRUCTIONS
        // imm_type = 011
        // ============================================================

        // LUI x5, 0x12345
        // opcode = 0110111
        // rd = x5
        instruction_in = 32'h123452B7;
        #10;

        // LUI x10, 0xABCDE
        // opcode = 0110111
        // rd = x10
        instruction_in = 32'hABCDE537;
        #10;

        // AUIPC x5, 0x12345
        // opcode = 0010111
        // rd = x5
        instruction_in = 32'h12345297;
        #10;

        // AUIPC x10, 0xABCDE
        // opcode = 0010111
        // rd = x10
        instruction_in = 32'hABCDE517;
        #10;


        // ============================================================
        // J-TYPE INSTRUCTIONS
        // imm_type = 100
        // ============================================================

        // JAL x5, 100
        // opcode = 1101111
        // rd = x5
        // immediate = 100
        instruction_in = 32'h064002EF;
        #10;

        // JAL x10, 200
        // opcode = 1101111
        // rd = x10
        // immediate = 200
        instruction_in = 32'h0C80056F;
        #10;

        // JAL x1, 16
        // opcode = 1101111
        // rd = x1
        // immediate = 16
        instruction_in = 32'h010000EF;
        #10;


        $finish;

    end
endmodule
