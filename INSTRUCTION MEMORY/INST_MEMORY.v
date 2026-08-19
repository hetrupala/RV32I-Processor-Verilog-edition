`timescale 1ns / 1ps

module INST_MEMORY(
    input wire [31:0] addr_in,
    output reg [31:0] inst_out
);

    reg [31:0] memory [0:11];

    initial begin
        // I-type
        memory[0]  = 32'h00A00093;  // ADDI x1, x0, 10
        memory[1]  = 32'h01400113;  // ADDI x2, x0, 20

        // R-type
        memory[2]  = 32'h002081B3;  // ADD  x3, x1, x2
        memory[3]  = 32'h40110233;  // SUB  x4, x2, x1
        memory[4]  = 32'h0020F2B3;  // AND  x5, x1, x2
        memory[5]  = 32'h0020E333;  // OR   x6, x1, x2
        memory[6]  = 32'h0020C3B3;  // XOR  x7, x1, x2
        memory[7]  = 32'h0020A433;  // SLT  x8, x1, x2
        memory[8]  = 32'h0020B4B3;  // SLTU x9, x1, x2
        memory[9]  = 32'h00209533;  // SLL  x10, x1, x2
        memory[10] = 32'h001155B3;  // SRL  x11, x2, x1
        memory[11] = 32'h40115633;  // SRA  x12, x2, x1
    end

    always @(*) begin
        case(addr_in)
            32'h00000000: inst_out = memory[0];
            32'h00000004: inst_out = memory[1];
            32'h00000008: inst_out = memory[2];
            32'h0000000C: inst_out = memory[3];
            32'h00000010: inst_out = memory[4];
            32'h00000014: inst_out = memory[5];
            32'h00000018: inst_out = memory[6];
            32'h0000001C: inst_out = memory[7];
            32'h00000020: inst_out = memory[8];
            32'h00000024: inst_out = memory[9];
            32'h00000028: inst_out = memory[10];
            32'h0000002C: inst_out = memory[11];

            default: inst_out = 32'h00000000;
        endcase
    end

endmodule