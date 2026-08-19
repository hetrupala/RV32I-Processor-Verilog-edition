`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2026 15:01:50
// Design Name: 
// Module Name: IF_UNIT_tb
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


module IF_UNIT_tb;

     reg clk;
     reg reset;
     wire [31:0] pc_out;
     wire [31:0] inst_out;
     
     IF_UNIT DUT (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .inst_out(inst_out)
        );
        
     initial begin
        clk = 1'b0;
     end   
     
     always #5 clk = ~clk;
     
     initial begin
        reset = 1'b0;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b1;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b1;
        #10
        
        reset = 1'b0;
        #10
        
        $finish;
     end
endmodule
