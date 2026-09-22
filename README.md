# ⚙️ Synthesizable RISC-V (RV32I) Instruction Decoder

A Register-Transfer Level (RTL) instruction decoding unit modeled in synthesizable Verilog HDL for the open-source RISC-V RV32I base integer architecture.

## 📌 Architecture & Design Highlights
* **Instruction Parsing:** Dynamically extracts `opcode`, source registers (`rs1`, `rs2`), destination register (`rd`), and function flags (`funct3`, `funct7`).
* **Format Decoding:** Supports standard RISC-V formats including **R-type** (register-register), **I-type** (immediates/loads), **S-type** (store instructions), and **B-type** (conditional branches).
* **Sign-Extension Unit:** Generates sign-extended 32-bit immediate offsets based on explicit instruction format specifications.
* **Control Unit Generation:** Drives pipeline control signals including `reg_write`, `mem_read`, `mem_write`, and primary `alu_op` codes.

## 🛠️ Design Specifications
* **HDL:** Verilog HDL (IEEE 1364 standard)
* **ISA Standard:** RISC-V Base Integer Instruction Set (RV32I)
* **Bus Architecture:** 32-bit unified instruction bus

---
*Developed by Rajeswari S. | Electronics and Communication Engineering (2023–2027)*
