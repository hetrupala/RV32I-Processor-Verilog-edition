`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2026 22:06:24
// Design Name: 
// Module Name: DECODER
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


module DECODER(
    input wire [31:0] instruction_in,
    output reg [6:0] opcode_out,
    output reg branch_out,
    output reg [1:0] result_mux_out,
    output reg [2:0] branch_op_out,
    output reg alu_src_a_out,
    output reg mem_write_out,
    output reg alu_src_b_out,
    output reg reg_write_out,
    output reg [5:0] alu_op_out,
    output reg [4:0] rs1_addr_out,
    output reg [4:0] rs2_addr_out,
    output reg [4:0] rd_addr_out
    );
    
    always @(*) begin

    // Default values
    opcode_out = 7'b0;
    branch_out = 1'b0;
    result_mux_out = 2'b00;
    branch_op_out = 3'b000;
    alu_src_a_out = 1'b0;
    mem_write_out = 1'b0;
    alu_src_b_out = 1'b0;
    reg_write_out = 1'b0;
    alu_op_out = 6'b0;
    rs1_addr_out = instruction_in[19:15];
    rs2_addr_out = instruction_in[24:20];
    rd_addr_out = instruction_in[11:7];

    if(instruction_in[6:0] == 7'b0110011) begin

        opcode_out = instruction_in[6:0];    //FOR R TYPE INSTRUCTIONS

        case(instruction_in[14:12])

            3'b000: begin
                if(instruction_in[31:25] == 7'b0000000) begin
                    // ADD
                    alu_op_out = 6'b000000;
                    reg_write_out = 1'b1;
                end

                else if(instruction_in[31:25] == 7'b0100000) begin
                    // SUB
                    alu_op_out = 6'b000001;
                    reg_write_out = 1'b1;
                end
            end

            3'b001: begin
                // SLL
                if(instruction_in[31:25] == 7'b0000000) begin
                    alu_op_out = 6'b000111;
                    reg_write_out = 1'b1;
                end
            end

            3'b010: begin
                // SLT
                if(instruction_in[31:25] == 7'b0000000) begin
                    alu_op_out = 6'b000101;
                    reg_write_out = 1'b1;
                end
            end

            3'b011: begin
                // SLTU
                if(instruction_in[31:25] == 7'b0000000) begin
                    alu_op_out = 6'b000110;
                    reg_write_out = 1'b1;
                end
            end

            3'b100: begin
                // XOR
                if(instruction_in[31:25] == 7'b0000000) begin
                    alu_op_out = 6'b000100;
                    reg_write_out = 1'b1;
                end
            end

            3'b101: begin
                if(instruction_in[31:25] == 7'b0000000) begin
                    // SRL
                    alu_op_out = 6'b001000;
                    reg_write_out = 1'b1;
                end

                else if(instruction_in[31:25] == 7'b0100000) begin
                    // SRA
                    alu_op_out = 6'b001001;
                    reg_write_out = 1'b1;
                end
            end

            3'b110: begin
                // OR
                if(instruction_in[31:25] == 7'b0000000) begin
                    alu_op_out = 6'b000011;
                    reg_write_out = 1'b1;
                end
            end

            3'b111: begin
                // AND
                if(instruction_in[31:25] == 7'b0000000) begin
                    alu_op_out = 6'b000010;
                    reg_write_out = 1'b1;
                end
            end

        endcase
    end
    
    else if (instruction_in[6:0] == 7'b0010011) begin
        opcode_out = instruction_in[6:0];    //FOR I TYPE OP-IIM(OPERATION - IMMEDIATE) INSTRUCTIONS
        
        case(instruction_in[14:12])
            3'b000: begin
            //ADDI
                alu_op_out = 6'b000000;
                alu_src_b_out = 1'b1;
                reg_write_out = 1'b1;
            end
            
            3'b001: begin
                if(instruction_in[31:25] == 7'b000000)begin
                 //SLLI
                    alu_op_out = 6'b000111;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
                end    
            end
            
            3'b010: begin
                //SLTI
                    alu_op_out = 6'b000101;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
            end
            
            3'b011: begin
                //SLTIU
                    alu_op_out = 6'b000110;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
            end
            
            3'b100: begin
                //XORI
                    alu_op_out = 6'b000100;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
            end
            
            3'b101: begin
                if(instruction_in[31:25] == 7'b000000)begin
                 //SRLI
                    alu_op_out = 6'b001000;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
                end
                else if(instruction_in[31:25] == 7'b010000)begin
                 //SRAI
                    alu_op_out = 6'b001001;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
                end    
            end        
                
            3'b110: begin
                //ORI
                    alu_op_out = 6'b000011;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
            end
                    
            3'b111: begin
                //ANDI
                    alu_op_out = 6'b000010;
                    alu_src_b_out = 1'b1;
                    reg_write_out = 1'b1;
            end
        endcase
    end
    
    else if (instruction_in[6:0] == 7'b0000011) begin

    opcode_out = instruction_in[6:0];    // FOR LOAD INSTRUCTIONS

    case(instruction_in[14:12])

        3'b000: begin
            // LB - Load Byte
            alu_op_out = 6'b000000;      // ADD: rs1 + immediate
            alu_src_b_out = 1'b1;        // Select immediate as ALU B input
            reg_write_out = 1'b1;        // Write loaded data to rd
        end

        3'b001: begin
            // LH - Load Halfword
            alu_op_out = 6'b000000;      // ADD: rs1 + immediate
            alu_src_b_out = 1'b1;
            reg_write_out = 1'b1;
        end

        3'b010: begin
            // LW - Load Word
            alu_op_out = 6'b000000;      // ADD: rs1 + immediate
            alu_src_b_out = 1'b1;
            reg_write_out = 1'b1;
        end

        3'b100: begin
            // LBU - Load Byte Unsigned
            alu_op_out = 6'b000000;      // ADD: rs1 + immediate
            alu_src_b_out = 1'b1;
            reg_write_out = 1'b1;
        end

        3'b101: begin
            // LHU - Load Halfword Unsigned
            alu_op_out = 6'b000000;      // ADD: rs1 + immediate
            alu_src_b_out = 1'b1;
            reg_write_out = 1'b1;
        end

    endcase
    end
    
    else if (instruction_in[6:0] == 7'b0100011) begin

        opcode_out = instruction_in[6:0];    // FOR STORE INSTRUCTIONS

        case(instruction_in[14:12])

        3'b000: begin
            // SB
            alu_op_out = 6'b000000;
            mem_write_out = 1'b1;
            alu_src_b_out = 1'b1;
        end

        3'b001: begin
            // SH
            alu_op_out = 6'b000000;
            mem_write_out = 1'b1;
            alu_src_b_out = 1'b1;
        end

        3'b010: begin
            // SW
            alu_op_out = 6'b000000;
            mem_write_out = 1'b1;
            alu_src_b_out = 1'b1;
        end

    endcase

end

    else if (instruction_in[6:0] == 7'b1100011) begin

      opcode_out = instruction_in[6:0];    // FOR B-TYPE / BRANCH INSTRUCTIONS

        case(instruction_in[14:12])

        3'b000: begin
            // BEQ
                branch_out = 1'b1;
                branch_op_out = 3'b000;
            end    

        3'b001: begin
            // BNE
                branch_out = 1'b1;
                branch_op_out = 3'b001;
        end

        3'b100: begin
            // BLT
                branch_out = 1'b1;
                branch_op_out = 3'b100;
        end

        3'b101: begin
            // BGE
                branch_out = 1'b1;
                branch_op_out = 3'b101;
        end

        3'b110: begin
            // BLTU
                branch_out = 1'b1;
                branch_op_out = 3'b110;
        end

        3'b111: begin
            // BGEU
                branch_out = 1'b1;
                branch_op_out = 3'b111;
        end

    endcase

end
    else if (instruction_in[6:0] == 7'b0110111) begin

    opcode_out = instruction_in[6:0];    // FOR LUI

    // LUI
    // Immediate Generator provides U-type immediate
    // No ALU calculation required

    reg_write_out = 1'b1;

end

else if (instruction_in[6:0] == 7'b0010111) begin

    opcode_out = instruction_in[6:0];    // FOR AUIPC

    // AUIPC
    // ALU performs PC + U-type immediate

    alu_src_a_out = 1'b1;    // Select PC as ALU input A
    reg_write_out = 1'b1;    // Write result to rd

end      
else if (instruction_in[6:0] == 7'b1101111) begin

    opcode_out = instruction_in[6:0];    // FOR JAL

    // JAL
    // rd = PC + 4
    // PC = PC + J-type immediate
    // Immediate Generator handles the immediate construction

    reg_write_out = 1'b1;

end                     
end    
endmodule
