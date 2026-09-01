`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2026 21:43:35
// Design Name: 
// Module Name: DATA_MEMORY_tb
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


module DATA_MEMORY_tb;

    reg clk;
    reg mem_write_out;
    reg [1:0] mem_size;
    reg sign_ext;
    reg [31:0] rs2_value;
    reg [31:0] alu_out;
    wire [31:0] data_out;


    DATA_MEMORY uut (
        .clk(clk),
        .mem_write_out(mem_write_out),
        .mem_size(mem_size),
        .sign_ext(sign_ext),
        .rs2_value(rs2_value),
        .alu_out(alu_out),
        .data_out(data_out)
    );


    initial begin
        clk = 1'b0;
    end

    always #5 clk = ~clk;


    initial begin

        // ============================================================
        // SB
        // Store byte
        // ============================================================

        mem_write_out = 1'b1;
        mem_size = 2'b00;
        sign_ext = 1'b0;
        rs2_value = 32'h12345678;
        alu_out = 32'd10;

        #10;


        // ============================================================
        // LB
        // Load signed byte
        // ============================================================

        mem_write_out = 1'b0;
        mem_size = 2'b00;
        sign_ext = 1'b1;
        alu_out = 32'd10;

        #10;


        // ============================================================
        // LBU
        // Load unsigned byte
        // ============================================================

        mem_write_out = 1'b0;
        mem_size = 2'b00;
        sign_ext = 1'b0;
        alu_out = 32'd10;

        #10;


        // ============================================================
        // SH
        // Store halfword
        // ============================================================

        mem_write_out = 1'b1;
        mem_size = 2'b01;
        sign_ext = 1'b0;
        rs2_value = 32'h12345678;
        alu_out = 32'd20;

        #10;


        // ============================================================
        // LH
        // Load signed halfword
        // ============================================================

        mem_write_out = 1'b0;
        mem_size = 2'b01;
        sign_ext = 1'b1;
        alu_out = 32'd20;

        #10;


        // ============================================================
        // LHU
        // Load unsigned halfword
        // ============================================================

        mem_write_out = 1'b0;
        mem_size = 2'b01;
        sign_ext = 1'b0;
        alu_out = 32'd20;

        #10;


        // ============================================================
        // SW
        // Store word
        // ============================================================

        mem_write_out = 1'b1;
        mem_size = 2'b10;
        sign_ext = 1'b0;
        rs2_value = 32'h12345678;
        alu_out = 32'd30;

        #10;


        // ============================================================
        // LW
        // Load word
        // ============================================================

        mem_write_out = 1'b0;
        mem_size = 2'b10;
        sign_ext = 1'b1;
        alu_out = 32'd30;

        #10;


        // ============================================================
        // SB with different data
        // ============================================================

        mem_write_out = 1'b1;
        mem_size = 2'b00;
        sign_ext = 1'b0;
        rs2_value = 32'hFFFFFF80;
        alu_out = 32'd40;

        #10;


        // ============================================================
        // LB with negative byte
        // Expected data_out = FFFFFF80
        // ============================================================

        mem_write_out = 1'b0;
        mem_size = 2'b00;
        sign_ext = 1'b1;
        alu_out = 32'd40;

        #10;


        // ============================================================
        // LBU with same byte
        // Expected data_out = 00000080
        // ============================================================

        mem_write_out = 1'b0;
        mem_size = 2'b00;
        sign_ext = 1'b0;
        alu_out = 32'd40;

        #10;


        $finish;

    end

endmodule