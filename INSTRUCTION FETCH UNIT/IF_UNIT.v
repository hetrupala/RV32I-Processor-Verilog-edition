`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2026 14:50:05
// Design Name: 
// Module Name: IF_UNIT
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


module IF_UNIT(
    input wire clk,
    input wire reset,
    output wire [31:0] pc_out,
    output wire [31:0] inst_out
    );
    
    wire [31:0] out1;
    wire [31:0] instruction;
    
    PC inst1 ( .clk(clk), 
               .reset(reset),
               .pc_out(out1)
               );
               
    INST_MEMORY inst2 ( .addr_in(out1),
                        .inst_out(instruction)
                        );
                        
    assign pc_out = out1;
    assign inst_out = instruction;
                        
               
    
endmodule
