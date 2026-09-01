`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2026 21:43:35
// Design Name: 
// Module Name: DATA_MEMORY
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


module DATA_MEMORY(
    input wire clk,
    input wire mem_write_out,
    input wire [1:0] mem_size,
    input wire sign_ext,
    input wire [31:0] rs2_value,
    input wire [31:0] alu_out,
    output reg [31:0] data_out
    );
    
    reg [7:0] memory [0:1023];
    
    always @(posedge clk) begin
        if(mem_write_out == 1) begin
            //Store 
            case(mem_size)
                2'b00: begin
                    //SB - store byte
                    memory[alu_out] <= rs2_value[7:0];
                end
                
                2'b01: begin
                    //SH - store halfword
                    memory[alu_out] <= rs2_value[7:0];
                    memory[alu_out + 1] <= rs2_value[15:8];
                end
                
                2'b10: begin
                    //SW - store word
                    memory[alu_out] <= rs2_value[7:0];
                    memory[alu_out + 1] <= rs2_value[15:8];
                    memory[alu_out + 2] <= rs2_value[23:16];
                    memory[alu_out + 3] <= rs2_value[31:24];
                end
                
                default: begin
                    //Invalid mem_size
                end
            endcase
        end
        
        else begin
            //Load
            case(mem_size)
                2'b00: begin

                    if(sign_ext == 1) begin
                    //LB - load byte (signed)
                        data_out = {{24{memory[alu_out][7]}}, memory[alu_out]};
                    end
                    else begin
                    //LBU - load byte unsigned
                        data_out = {24'b0, memory[alu_out]};
                    end
                end
                
                2'b01: begin

                    if(sign_ext == 1) begin
                    //LH - load halfword (sigend)
                        data_out = {{16{memory[alu_out + 1][7]}}, memory[alu_out + 1], memory[alu_out]};
                    end
                    else begin
                    //LHU - load halfword (unsigned)
                        data_out = {16'b0, memory[alu_out + 1], memory[alu_out]};
                    end
                end
                
                2'b10: begin
                   //LW - load word
                    data_out = {memory[alu_out + 3],
                                memory[alu_out + 2],
                                memory[alu_out + 1],
                                memory[alu_out]};
                end
                
                default: begin
                    data_out = 32'b0;
                end
            endcase
        end
    end

endmodule