`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name:
// Module Name: WRITEBACK_MUX_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
// 
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module WRITEBACK_MUX_tb;

    reg [31:0] alu_out;
    reg [31:0] data_out;
    reg [31:0] immediate;
    reg [31:0] link_address;
    reg [1:0] result_mux_out;

    wire [31:0] write_data;


    WRITEBACK_MUX uut (
        .alu_out(alu_out),
        .data_out(data_out),
        .immediate(immediate),
        .link_address(link_address),
        .result_mux_out(result_mux_out),
        .write_data(write_data)
    );


    initial begin

        // ============================================================
        // ALU RESULT
        // ============================================================

        result_mux_out = 2'b00;
        alu_out = 32'h12345678;
        data_out = 32'hAAAAAAAA;
        immediate = 32'hBBBBBBBB;
        link_address = 32'hCCCCCCCC;

        #10;


        // ============================================================
        // DATA MEMORY RESULT
        // ============================================================

        result_mux_out = 2'b01;
        alu_out = 32'h12345678;
        data_out = 32'h87654321;
        immediate = 32'hBBBBBBBB;
        link_address = 32'hCCCCCCCC;

        #10;


        // ============================================================
        // IMMEDIATE
        // ============================================================

        result_mux_out = 2'b10;
        alu_out = 32'h12345678;
        data_out = 32'h87654321;
        immediate = 32'hABCDEF00;
        link_address = 32'hCCCCCCCC;

        #10;


        // ============================================================
        // LINK ADDRESS
        // ============================================================

        result_mux_out = 2'b11;
        alu_out = 32'h12345678;
        data_out = 32'h87654321;
        immediate = 32'hABCDEF00;
        link_address = 32'h00001004;

        #10;


        // ============================================================
        // DIFFERENT ALU RESULT
        // ============================================================

        result_mux_out = 2'b00;
        alu_out = 32'h00000030;

        #10;


        // ============================================================
        // DIFFERENT DATA MEMORY RESULT
        // ============================================================

        result_mux_out = 2'b01;
        data_out = 32'h00000040;

        #10;


        // ============================================================
        // DIFFERENT IMMEDIATE
        // ============================================================

        result_mux_out = 2'b10;
        immediate = 32'h12345000;

        #10;


        // ============================================================
        // DIFFERENT LINK ADDRESS
        // ============================================================

        result_mux_out = 2'b11;
        link_address = 32'h00000104;

        #10;


        $finish;

    end

endmodule