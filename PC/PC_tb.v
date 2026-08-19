`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2026 14:24:13
// Design Name: 
// Module Name: PC_tb
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


module PC_tb;

    reg clk;
    reg reset;
    wire [31:0] pc_out;
    
    PC dut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
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
        
        reset = 1'b1;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b0;
        #10
        
        reset = 1'b1;
        #10
        
      $finish;   
     end   
endmodule
