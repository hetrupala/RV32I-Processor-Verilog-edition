# Immediate Generator

The Immediate Generator is a combinational component of the RV32I processor responsible for extracting immediate values from 32-bit RISC-V instructions and converting them into a 32-bit immediate value.

RISC-V uses different instruction formats, and the immediate field is located at different positions depending on the instruction type. The Immediate Generator reconstructs the immediate value according to the corresponding instruction format and produces the value required by the processor datapath.

## Interface

| Signal   |   Width | Direction | Description                |
| -------- | ------: | --------- | -------------------------- |
| `i_inst` | 32 bits | Input     | 32-bit RISC-V instruction  |
| `o_imm`  | 32 bits | Output    | Generated 32-bit immediate |

The exact port names are defined by `IMME_GEN.v`.

## Function

The Immediate Generator performs three main operations:

1. Identifies the required immediate encoding.
2. Extracts and rearranges the appropriate instruction bits.
3. Extends the resulting immediate to the processor's 32-bit data width.

The generated immediate can then be used by the ALU, memory-address calculation logic, branch logic, or jump logic.

## RV32I Immediate Formats

The RV32I instruction set uses five immediate formats:

* I-Type
* S-Type
* B-Type
* U-Type
* J-Type

Each format places its immediate bits differently within the 32-bit instruction.

### I-Type Immediate

The I-Type immediate is 12 bits wide and is located in instruction bits `[31:20]`.

The immediate is formed as:

`imm[11:0] = instruction[31:20]`

The 12-bit value is sign-extended to 32 bits.

I-Type immediates are used by:

* `ADDI`
* `SLTI`
* `SLTIU`
* `XORI`
* `ORI`
* `ANDI`
* `SLLI`
* `SRLI`
* `SRAI`
* Load instructions
* `JALR`

For an I-Type instruction, the generated immediate is:

`o_imm = {{20{instruction[31]}}, instruction[31:20]}`

## S-Type Immediate

The S-Type immediate is 12 bits wide and is divided between two parts of the instruction.

The immediate is formed as:

`imm[11:5] = instruction[31:25]`

`imm[4:0] = instruction[11:7]`

The complete immediate is:

`imm[11:0] = {instruction[31:25], instruction[11:7]}`

The result is then sign-extended to 32 bits.

S-Type immediates are used by store instructions:

* `SB`
* `SH`
* `SW`

## B-Type Immediate

The B-Type immediate is 13 bits wide and is distributed across several instruction fields.

The immediate is formed as:

`imm[12] = instruction[31]`

`imm[11] = instruction[7]`

`imm[10:5] = instruction[30:25]`

`imm[4:1] = instruction[11:8]`

`imm[0] = 1'b0`

Therefore:

`imm[12:0] = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}`

The resulting value is sign-extended to 32 bits.

B-Type immediates are used by conditional branch instructions:

* `BEQ`
* `BNE`
* `BLT`
* `BGE`
* `BLTU`
* `BGEU`

The least significant bit is always zero because branch targets are aligned.

## U-Type Immediate

The U-Type immediate uses the upper 20 bits of the instruction.

The immediate is formed as:

`imm[31:12] = instruction[31:12]`

`imm[11:0] = 12'b0`

Therefore:

`o_imm = {instruction[31:12], 12'b0}`

Unlike the I-Type, S-Type, B-Type, and J-Type formats, the U-Type immediate does not require sign extension in the same manner. The lower 12 bits are explicitly filled with zeros.

U-Type immediates are used by:

* `LUI`
* `AUIPC`

## J-Type Immediate

The J-Type immediate is 21 bits wide and is distributed across several instruction fields.

The immediate is formed as:

`imm[20] = instruction[31]`

`imm[19:12] = instruction[19:12]`

`imm[11] = instruction[20]`

`imm[10:1] = instruction[30:21]`

`imm[0] = 1'b0`

Therefore:

`imm[20:0] = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}`

The resulting 21-bit immediate is sign-extended to 32 bits.

J-Type immediates are used by:

* `JAL`

The least significant bit is zero because jump targets are aligned.

## Immediate Format Summary

| Format | Immediate Width | Instruction Bits Used                     | Primary Instructions       |
| ------ | --------------: | ----------------------------------------- | -------------------------- |
| I-Type |         12 bits | `[31:20]`                                 | ALU immediate, loads, JALR |
| S-Type |         12 bits | `[31:25]`, `[11:7]`                       | Stores                     |
| B-Type |         13 bits | `[31]`, `[7]`, `[30:25]`, `[11:8]`, `0`   | Branches                   |
| U-Type |   32-bit result | `[31:12]`, `12'b0`                        | LUI, AUIPC                 |
| J-Type |         21 bits | `[31]`, `[19:12]`, `[20]`, `[30:21]`, `0` | JAL                        |

## Sign Extension

The processor uses 32-bit data values, while several RV32I immediate formats contain fewer than 32 bits.

For signed immediate formats, the sign bit is replicated into the upper bits of the 32-bit result.

For example, a 12-bit immediate is extended as:

`{{20{imm[11]}}, imm[11:0]}`

Similarly, a 13-bit branch immediate is extended using its sign bit:

`{{19{imm[12]}}, imm[12:0]}`

A 21-bit jump immediate is extended using:

`{{11{imm[20]}}, imm[20:0]}`

This preserves the signed value of the original immediate when it is used by the 32-bit datapath.

## Usage in the Processor

The Immediate Generator operates directly on the current instruction. Its output can be used by other processor components depending on the instruction being executed.

For arithmetic-immediate instructions, the generated immediate is used as an ALU operand.

For load and store instructions, the immediate is used for effective-address calculation.

For branch instructions, the generated immediate is used to calculate the branch target.

For `JAL` and `JALR`, the immediate contributes to the jump target calculation.

For `LUI` and `AUIPC`, the immediate forms part of the value written to the destination register.

## Example

For an instruction containing an I-Type immediate:

`ADDI rd, rs1, imm`

the Immediate Generator extracts `instruction[31:20]` and produces the corresponding sign-extended 32-bit value.

The processor can then perform:

`Register[rd] = Register[rs1] + o_imm`

The Immediate Generator itself does not perform the arithmetic operation. It only produces the correctly formatted immediate value.

## Design Characteristics

* ISA: RISC-V RV32I
* Instruction width: 32 bits
* Processor data width: 32 bits
* Supported immediate formats: I, S, B, U, J
* Output width: 32 bits
* Logic type: Combinational
* HDL: Verilog

## Module Files

```text
IMME_GEN/
├── IMME_GEN.v
├── IMME_GEN_tb.v
└── README.md
```

`IMME_GEN.v` contains the synthesizable immediate-generation logic, while `IMME_GEN_tb.v` provides the simulation environment for verifying the generated immediate values for the supported instruction formats.

## Role in RV32I

The Immediate Generator bridges the encoded immediate fields within a RISC-V instruction and the 32-bit processor datapath.

It ensures that immediate values are correctly extracted, reconstructed, aligned, and extended before they are consumed by the execution, memory, or control-flow logic.
