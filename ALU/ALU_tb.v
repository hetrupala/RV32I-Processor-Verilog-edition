`timescale 1ns / 1ps

module ALU_tb;

    reg [31:0] in_a;
    reg [31:0] in_b;
    reg [5:0]  alu_op;
    wire [31:0] out;

    // Instantiate ALU
    ALU uut (
        .in_a(in_a),
        .in_b(in_b),
        .alu_op(alu_op),
        .out(out)
    );

    initial begin

        // ADD
        // 10 + 20 = 30
        in_a = 32'd10;
        in_b = 32'd20;
        alu_op = 6'b000000;
        #10;

        // SUB
        // 20 - 10 = 10
        in_a = 32'd20;
        in_b = 32'd10;
        alu_op = 6'b000001;
        #10;

        // AND
        // 1010 & 1100 = 1000
        in_a = 32'b1010;
        in_b = 32'b1100;
        alu_op = 6'b000010;
        #10;

        // OR
        // 1010 | 1100 = 1110
        in_a = 32'b1010;
        in_b = 32'b1100;
        alu_op = 6'b000011;
        #10;

        // XOR
        // 1010 ^ 1100 = 0110
        in_a = 32'b1010;
        in_b = 32'b1100;
        alu_op = 6'b000100;
        #10;

        // SLT signed
        // 5 < 10 ? 1
        in_a = 32'sd5;
        in_b = 32'sd10;
        alu_op = 6'b000101;
        #10;

        // SLT signed
        // -10 < 5 ? 1
        in_a = -32'sd10;
        in_b = 32'sd5;
        alu_op = 6'b000101;
        #10;

        // SLTU unsigned
        // 5 < 10 ? 1
        in_a = 32'd5;
        in_b = 32'd10;
        alu_op = 6'b000110;
        #10;

        // SLTU unsigned
        // 32'hFFFFFFFF > 10 ? 0
        in_a = 32'hFFFFFFFF;
        in_b = 32'd10;
        alu_op = 6'b000110;
        #10;

        // SLL
        // 1 << 4 = 16
        in_a = 32'd1;
        in_b = 32'd4;
        alu_op = 6'b000111;
        #10;

        // SRL
        // 32 >> 2 = 8
        in_a = 32'd32;
        in_b = 32'd2;
        alu_op = 6'b001000;
        #10;

        // SRA
        // -16 >>> 2 = -4
        in_a = -32'sd16;
        in_b = 32'd2;
        alu_op = 6'b001001;
        #10;

        $finish;

    end

endmodule