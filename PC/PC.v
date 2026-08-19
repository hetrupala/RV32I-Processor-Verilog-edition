`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2026 14:17:14
// Design Name: 
// Module Name: PC
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


module PC(
    input wire clk,
    input wire reset,
    output reg [31:0] pc_out
    );
    
    
    initial begin 
        pc_out = 32'h00000000;
    end
    
    always @(posedge clk) begin      
        if(reset) begin
            pc_out <= 32'h00000000;
        end
        else begin
            pc_out <= pc_out + 32'h00000004;
        end
    end
endmodule
