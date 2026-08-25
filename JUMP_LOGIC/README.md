# Jump Logic

The **Jump Logic** module is responsible for handling the jump instructions in the RV32I single-cycle processor.

It supports both `JAL` and `JALR`. The module determines the jump target address and generates the link address (`PC + 4`) that is written to the destination register.

Unlike conditional branch instructions, jump instructions do not require a comparison between two register values to determine whether the jump occurs.

## Supported Instructions

| Instruction | Opcode | Target Address | Link Address |
|---|---|---|---|
| `JAL` | `1101111` | `PC + J-immediate` | `PC + 4` |
| `JALR` | `1100111` | `(rs1 + I-immediate) & ~1` | `PC + 4` |

## Module Interface

```verilog
module JUMP_LOGIC(
    input wire [6:0] opcode,
    input wire [31:0] pc_value,
    input wire [31:0] rs1_value,
    input wire [31:0] immediate,
    output reg jump_taken,
    output reg [31:0] jump_target,
    output reg [31:0] link_address
);
