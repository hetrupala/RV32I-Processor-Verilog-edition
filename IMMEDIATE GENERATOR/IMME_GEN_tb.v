`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2026 12:18:26
// Design Name: 
// Module Name: IMME_GEN_tb
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


module IMME_GEN_tb;
    reg [31:0] inst_in;
    reg [2:0] sel_type;
    wire [31:0] inst_out;
    
    IMME_GEN uut (
        .inst_in(inst_in),
        .sel_type(sel_type),
        .inst_out(inst_out)
        );
        
    initial begin
        //I type
        inst_in = 32'h00510093;
        sel_type = 3'b000;
        #10;
        
        //S type
        inst_in = 32'h0020A423;
        sel_type = 3'b001;
        #10;
        
        //B type
        inst_in = 32'h00208863;
        sel_type = 3'b010;
        #10;
        
        //U type
        inst_in = 32'h123450B7;
        sel_type = 3'b011;
        #10;
        
        //J type
        inst_in = 32'h010000EF;
        sel_type = 3'b100;
        #10;
        
        //R type
        inst_in = 32'h11001111;
        sel_type = 3'b101;
        #10;
        
        $finish;
    end
endmodule
