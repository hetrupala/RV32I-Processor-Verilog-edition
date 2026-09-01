`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name:
// Module Name: TOP_LEVEL_CPU_tb
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


module TOP_LEVEL_CPU_tb;

    reg clk;
    reg reset;


    TOP_LEVEL_CPU uut (
        .clk(clk),
        .reset(reset)
    );


    // ============================================================
    // CLOCK
    // ============================================================

    initial begin
        clk = 1'b0;
    end

    always #5 clk = ~clk;


    // ============================================================
    // TEST
    // ============================================================

    initial begin

        // ============================================================
        // RESET
        // ============================================================

        reset = 1'b1;

        #10;


        // ============================================================
        // START CPU
        // ============================================================

        reset = 1'b0;

        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;


        // ============================================================
        // DISPLAY RESULTS
        // ============================================================

        $display("PC        = %h", uut.pc_value);
        $display("Instruction = %h", uut.instruction);

        $display("x1        = %h", uut.inst3.Registers[1]);
        $display("x2        = %h", uut.inst3.Registers[2]);
        $display("x3        = %h", uut.inst3.Registers[3]);
        $display("x4        = %h", uut.inst3.Registers[4]);
        $display("x5        = %h", uut.inst3.Registers[5]);
        $display("x6        = %h", uut.inst3.Registers[6]);
        $display("x7        = %h", uut.inst3.Registers[7]);
        $display("x8        = %h", uut.inst3.Registers[8]);
        $display("x9        = %h", uut.inst3.Registers[9]);
        $display("x10       = %h", uut.inst3.Registers[10]);
        $display("x11       = %h", uut.inst3.Registers[11]);
        $display("x12       = %h", uut.inst3.Registers[12]);


        $finish;

    end

endmodule