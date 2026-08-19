`timescale 1ns / 1ps

module INST_MEMORY_tb;

    reg [31:0] addr_in;
    wire [31:0] inst_out;

    INST_MEMORY dut(
        .addr_in(addr_in),
        .inst_out(inst_out)
    );

    initial begin

        // ADDI x1, x0, 10
        addr_in = 32'h00000000;
        #10;

        // ADDI x2, x0, 20
        addr_in = 32'h00000004;
        #10;

        // ADD x3, x1, x2
        addr_in = 32'h00000008;
        #10;

        // SUB x4, x2, x1
        addr_in = 32'h0000000C;
        #10;

        // AND x5, x1, x2
        addr_in = 32'h00000010;
        #10;

        // OR x6, x1, x2
        addr_in = 32'h00000014;
        #10;

        // XOR x7, x1, x2
        addr_in = 32'h00000018;
        #10;

        // SLT x8, x1, x2
        addr_in = 32'h0000001C;
        #10;

        // SLTU x9, x1, x2
        addr_in = 32'h00000020;
        #10;

        // SLL x10, x1, x2
        addr_in = 32'h00000024;
        #10;

        // SRL x11, x2, x1
        addr_in = 32'h00000028;
        #10;

        // SRA x12, x2, x1
        addr_in = 32'h0000002C;
        #10;

        $finish;

    end

endmodule