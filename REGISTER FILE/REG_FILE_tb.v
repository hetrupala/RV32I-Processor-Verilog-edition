`timescale 1ns/1ps

module REG_FILE_tb;

    reg clk;
    reg reset;
    reg we;

    reg [31:0] rd;
    reg [4:0] rd_addr;
    reg [4:0] rs1_addr;
    reg [4:0] rs2_addr;

    wire [31:0] o_rs1;
    wire [31:0] o_rs2;

    REG_FILE dut (
        .clk(clk),
        .reset(reset),
        .we(we),
        .rd(rd),
        .rd_addr(rd_addr),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .o_rs1(o_rs1),
        .o_rs2(o_rs2)
    );

    initial begin
        clk = 0;
    end

    always #5 clk = ~clk;

    initial begin

        // Initial values
        reset = 1;
        we = 0;
        rd = 0;
        rd_addr = 0;
        rs1_addr = 0;
        rs2_addr = 0;

        #10;

        // Release reset
        reset = 0;

        // Read x0 and x0
        rs1_addr = 5'd0;
        rs2_addr = 5'd0;

        #10;

        // Write 100 to x1
        we = 1;
        rd_addr = 5'd1;
        rd = 32'd100;

        #10;

        // Read x1
        we = 0;
        rs1_addr = 5'd1;

        #10;

        // Write 200 to x2
        we = 1;
        rd_addr = 5'd2;
        rd = 32'd200;

        #10;

        // Read x1 and x2 simultaneously
        we = 0;
        rs1_addr = 5'd1;
        rs2_addr = 5'd2;

        #10;

        // Try writing to x0
        we = 1;
        rd_addr = 5'd0;
        rd = 32'hFFFFFFFF;

        #10;

        // x0 should still be zero
        we = 0;
        rs1_addr = 5'd0;

        #10;

        $finish;

    end

endmodule