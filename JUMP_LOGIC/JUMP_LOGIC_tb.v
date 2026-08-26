`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: JUMP_LOGIC_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description: JAL and JALR Testbench
//
//////////////////////////////////////////////////////////////////////////////////

module JUMP_LOGIC_tb;

    reg [6:0] opcode;
    reg [31:0] pc_value;
    reg [31:0] rs1_value;
    reg [31:0] immediate;

    wire jump_taken;
    wire [31:0] jump_target;
    wire [31:0] link_address;


    JUMP_LOGIC uut (
        .opcode(opcode),
        .pc_value(pc_value),
        .rs1_value(rs1_value),
        .immediate(immediate),
        .jump_taken(jump_taken),
        .jump_target(jump_target),
        .link_address(link_address)
    );


    initial begin

        // ============================================================
        // JAL
        // PC = 100
        // Immediate = 16
        //
        // Expected:
        // jump_taken  = 1
        // jump_target = 116
        // link        = 104
        // ============================================================

        opcode = 7'b1101111;
        pc_value = 32'd100;
        rs1_value = 32'd0;
        immediate = 32'd16;
        #10;


        // ============================================================
        // JAL
        // PC = 100
        // Immediate = 100
        //
        // Expected:
        // jump_target = 200
        // link        = 104
        // ============================================================

        opcode = 7'b1101111;
        pc_value = 32'd100;
        rs1_value = 32'd0;
        immediate = 32'd100;
        #10;


        // ============================================================
        // JAL with negative offset
        //
        // PC = 100
        // Immediate = -20
        //
        // Expected:
        // jump_target = 80
        // link        = 104
        // ============================================================

        opcode = 7'b1101111;
        pc_value = 32'd100;
        rs1_value = 32'd0;
        immediate = -32'sd20;
        #10;


        // ============================================================
        // JALR
        //
        // rs1 = 1000
        // Immediate = 16
        //
        // Expected:
        // jump_target = 1016
        // link        = 104
        // ============================================================

        opcode = 7'b1100111;
        pc_value = 32'd100;
        rs1_value = 32'd1000;
        immediate = 32'd16;
        #10;


        // ============================================================
        // JALR
        //
        // rs1 = 1001
        // Immediate = 16
        //
        // Expected:
        // raw target = 1017
        // bit 0 cleared ? 1016
        // link = 104
        // ============================================================

        opcode = 7'b1100111;
        pc_value = 32'd100;
        rs1_value = 32'd1001;
        immediate = 32'd16;
        #10;


        // ============================================================
        // Invalid opcode
        //
        // Expected:
        // jump_taken  = 0
        // jump_target = 0
        // ============================================================

        opcode = 7'b0000000;
        pc_value = 32'd100;
        rs1_value = 32'd1000;
        immediate = 32'd16;
        #10;


        $finish;

    end

endmodule