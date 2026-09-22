// RISC-V RV32I Base Instruction Set Decoder
// Designed by Rajeswari S

module riscv_decoder (
    input  [31:0] instr,        // 32-bit instruction word
    output [6:0]  opcode,       // Opcode field [6:0]
    output [4:0]  rd,           // Destination register [11:7]
    output [2:0]  funct3,       // Function 3 field [14:12]
    output [4:0]  rs1,          // Source register 1 [19:15]
    output [4:0]  rs2,          // Source register 2 [24:20]
    output [6:0]  funct7,       // Function 7 field [31:25]
    output reg [31:0] imm_ext,  // Sign-extended 32-bit immediate
    output reg [2:0]  alu_op,   // ALU Control signal
    output reg        reg_write,// Register File Write Enable
    output reg        mem_read, // Data Memory Read Enable
    output reg        mem_write // Data Memory Write Enable
);

    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct7 = instr[31:25];

    always @(*) begin
        // Default control states
        reg_write = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        alu_op    = 3'b000;
        imm_ext   = 32'h00000000;

        case (opcode)
            7'b0110011: begin // R-Type (ADD, SUB, AND, OR, XOR)
                reg_write = 1'b1;
                alu_op    = 3'b010;
            end
            7'b0010011: begin // I-Type Arithmetic (ADDI, ANDI)
                reg_write = 1'b1;
                alu_op    = 3'b000;
                imm_ext   = {{20{instr[31]}}, instr[31:20]};
            end
            7'b0000011: begin // I-Type Load (LW)
                reg_write = 1'b1;
                mem_read  = 1'b1;
                alu_op    = 3'b000;
                imm_ext   = {{20{instr[31]}}, instr[31:20]};
            end
            7'b0100011: begin // S-Type Store (SW)
                mem_write = 1'b1;
                alu_op    = 3'b000;
                imm_ext   = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end
            7'b1100011: begin // B-Type Branch (BEQ, BNE)
                alu_op    = 3'b001;
                imm_ext   = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
            end
            default: begin
                reg_write = 1'b0;
                mem_read  = 1'b0;
                mem_write = 1'b0;
                alu_op    = 3'b000;
            end
        endcase
    end

endmodule
