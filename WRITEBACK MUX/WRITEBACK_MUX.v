`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name:
// Module Name: WRITEBACK_MUX
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


module WRITEBACK_MUX(
    input wire [31:0] alu_out,
    input wire [31:0] data_out,
    input wire [31:0] immediate,
    input wire [31:0] link_address,
    input wire [1:0] result_mux_out,
    output reg [31:0] write_data
    );


    always @(*) begin

        case(result_mux_out)

            2'b00: begin
                //ALU result
                write_data = alu_out;
            end

            2'b01: begin
                //Data memory result
                write_data = data_out;
            end

            2'b10: begin
                //Immediate
                write_data = immediate;
            end

            2'b11: begin
                //PC + 4
                write_data = link_address;
            end

            default: begin
                //Invalid result selection
                write_data = 32'b0;
            end

        endcase

    end

endmodule