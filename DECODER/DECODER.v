`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2026 22:06:24
// Design Name: 
// Module Name: DECODER
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: RV32I Instruction Decoder
// 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DECODER(
    input wire [31:0] instruction_in,

    output reg [6:0] opcode_out,
    output reg branch_out,
    output reg [1:0] result_mux_out,
    output reg [2:0] branch_op_out,
    output reg alu_src_a_out,
    output reg mem_write_out,
    output reg alu_src_b_out,
    output reg reg_write_out,
    output reg [5:0] alu_op_out,

    output reg [2:0] imm_type_out,

    output reg [4:0] rs1_addr_out,
    output reg [4:0] rs2_addr_out,
    output reg [4:0] rd_addr_out
);


    always @(*) begin

        // ============================================================
        // DEFAULT VALUES
        // ============================================================

        opcode_out     = 7'b0;
        branch_out     = 1'b0;
        result_mux_out = 2'b00;
        branch_op_out  = 3'b000;
        alu_src_a_out  = 1'b0;
        mem_write_out  = 1'b0;
        alu_src_b_out  = 1'b0;
        reg_write_out  = 1'b0;
        alu_op_out     = 6'b0;

        // Immediate type selection
        //
        // 000 -> I-Type
        // 001 -> S-Type
        // 010 -> B-Type
        // 011 -> U-Type
        // 100 -> J-Type
        // 101 -> R-Type
        //
        imm_type_out = 3'b101;

        // Register addresses
        rs1_addr_out = instruction_in[19:15];
        rs2_addr_out = instruction_in[24:20];
        rd_addr_out  = instruction_in[11:7];


        // ============================================================
        // OPCODE-FIRST DECODING
        // ============================================================

        case (instruction_in[6:0])


            // ========================================================
            // R-TYPE
            // Opcode = 0110011
            // ========================================================

            7'b0110011: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b101;

                case (instruction_in[14:12])

                    3'b000: begin

                        // ADD / SUB

                        if (instruction_in[31:25] == 7'b0000000) begin

                            // ADD
                            alu_op_out    = 6'b000000;
                            reg_write_out = 1'b1;

                        end

                        else if (instruction_in[31:25] == 7'b0100000) begin

                            // SUB
                            alu_op_out    = 6'b000001;
                            reg_write_out = 1'b1;

                        end

                    end


                    3'b001: begin

                        // SLL

                        if (instruction_in[31:25] == 7'b0000000) begin

                            alu_op_out    = 6'b000111;
                            reg_write_out = 1'b1;

                        end

                    end


                    3'b010: begin

                        // SLT

                        if (instruction_in[31:25] == 7'b0000000) begin

                            alu_op_out    = 6'b000101;
                            reg_write_out = 1'b1;

                        end

                    end


                    3'b011: begin

                        // SLTU

                        if (instruction_in[31:25] == 7'b0000000) begin

                            alu_op_out    = 6'b000110;
                            reg_write_out = 1'b1;

                        end

                    end


                    3'b100: begin

                        // XOR

                        if (instruction_in[31:25] == 7'b0000000) begin

                            alu_op_out    = 6'b000100;
                            reg_write_out = 1'b1;

                        end

                    end


                    3'b101: begin

                        // SRL / SRA

                        if (instruction_in[31:25] == 7'b0000000) begin

                            // SRL
                            alu_op_out    = 6'b001000;
                            reg_write_out = 1'b1;

                        end

                        else if (instruction_in[31:25] == 7'b0100000) begin

                            // SRA
                            alu_op_out    = 6'b001001;
                            reg_write_out = 1'b1;

                        end

                    end


                    3'b110: begin

                        // OR

                        if (instruction_in[31:25] == 7'b0000000) begin

                            alu_op_out    = 6'b000011;
                            reg_write_out = 1'b1;

                        end

                    end


                    3'b111: begin

                        // AND

                        if (instruction_in[31:25] == 7'b0000000) begin

                            alu_op_out    = 6'b000010;
                            reg_write_out = 1'b1;

                        end

                    end

                endcase

            end


            // ========================================================
            // I-TYPE OP-IMM
            // Opcode = 0010011
            // ========================================================

            7'b0010011: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b000;

                case (instruction_in[14:12])

                    3'b000: begin

                        // ADDI
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b001: begin

                        // SLLI

                        if (instruction_in[31:25] == 7'b0000000) begin

                            alu_op_out     = 6'b000111;
                            alu_src_b_out  = 1'b1;
                            reg_write_out  = 1'b1;

                        end

                    end


                    3'b010: begin

                        // SLTI
                        alu_op_out     = 6'b000101;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b011: begin

                        // SLTIU
                        alu_op_out     = 6'b000110;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b100: begin

                        // XORI
                        alu_op_out     = 6'b000100;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b101: begin

                        // SRLI / SRAI

                        if (instruction_in[31:25] == 7'b0000000) begin

                            // SRLI
                            alu_op_out     = 6'b001000;
                            alu_src_b_out  = 1'b1;
                            reg_write_out  = 1'b1;

                        end

                        else if (instruction_in[31:25] == 7'b0100000) begin

                            // SRAI
                            alu_op_out     = 6'b001001;
                            alu_src_b_out  = 1'b1;
                            reg_write_out  = 1'b1;

                        end

                    end


                    3'b110: begin

                        // ORI
                        alu_op_out     = 6'b000011;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b111: begin

                        // ANDI
                        alu_op_out     = 6'b000010;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end

                endcase

            end


            // ========================================================
            // I-TYPE LOAD
            // Opcode = 0000011
            // ========================================================

            7'b0000011: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b000;

                case (instruction_in[14:12])

                    3'b000: begin

                        // LB
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b001: begin

                        // LH
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b010: begin

                        // LW
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b100: begin

                        // LBU
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end


                    3'b101: begin

                        // LHU
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        reg_write_out  = 1'b1;

                    end

                endcase

            end


            // ========================================================
            // S-TYPE STORE
            // Opcode = 0100011
            // ========================================================

            7'b0100011: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b001;

                case (instruction_in[14:12])

                    3'b000: begin

                        // SB
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        mem_write_out  = 1'b1;

                    end


                    3'b001: begin

                        // SH
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        mem_write_out  = 1'b1;

                    end


                    3'b010: begin

                        // SW
                        alu_op_out     = 6'b000000;
                        alu_src_b_out  = 1'b1;
                        mem_write_out  = 1'b1;

                    end

                endcase

            end


            // ========================================================
            // B-TYPE BRANCH
            // Opcode = 1100011
            // ========================================================

            7'b1100011: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b010;

                case (instruction_in[14:12])

                    3'b000: begin

                        // BEQ
                        branch_out    = 1'b1;
                        branch_op_out = 3'b000;

                    end


                    3'b001: begin

                        // BNE
                        branch_out    = 1'b1;
                        branch_op_out = 3'b001;

                    end


                    3'b100: begin

                        // BLT
                        branch_out    = 1'b1;
                        branch_op_out = 3'b100;

                    end


                    3'b101: begin

                        // BGE
                        branch_out    = 1'b1;
                        branch_op_out = 3'b101;

                    end


                    3'b110: begin

                        // BLTU
                        branch_out    = 1'b1;
                        branch_op_out = 3'b110;

                    end


                    3'b111: begin

                        // BGEU
                        branch_out    = 1'b1;
                        branch_op_out = 3'b111;

                    end

                endcase

            end


            // ========================================================
            // U-TYPE LUI
            // Opcode = 0110111
            // ========================================================

            7'b0110111: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b011;

                // LUI
                // Immediate Generator provides U-type immediate

                reg_write_out = 1'b1;

            end


            // ========================================================
            // U-TYPE AUIPC
            // Opcode = 0010111
            // ========================================================

            7'b0010111: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b011;

                // AUIPC
                // ALU performs PC + U-type immediate

                alu_src_a_out = 1'b1;
                alu_src_b_out = 1'b1;
                alu_op_out    = 6'b000000;
                reg_write_out = 1'b1;

            end


            // ========================================================
            // J-TYPE JAL
            // Opcode = 1101111
            // ========================================================

            7'b1101111: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b100;

                // JAL
                // rd = PC + 4
                // PC = PC + J-type immediate
                // Immediate Generator handles the J-type immediate

                reg_write_out = 1'b1;

            end


            // ========================================================
            // I-TYPE JALR
            // Opcode = 1100111
            // funct3 = 000
            // ========================================================

            7'b1100111: begin

                opcode_out   = instruction_in[6:0];
                imm_type_out = 3'b000;

                case (instruction_in[14:12])

                    3'b000: begin

                        // JALR
                        // rd = PC + 4
                        // PC = (rs1 + immediate) & ~1
                        // Immediate Generator handles the I-type immediate

                        reg_write_out = 1'b1;

                    end

                endcase

            end


            // ========================================================
            // DEFAULT
            // ========================================================

            default: begin

                opcode_out = instruction_in[6:0];

            end

        endcase

    end

endmodule
