`timescale 1 ps / 100 fs


module CPU(clk, reset);
    input clk, reset;
    
    wire [31:0] PC, PCin;
    wire [31:0] PC4,ID_PC4,EX_PC4;
    wire [31:0] PCbne,PC4bne,PCj,PC4bnej,PCjr; // PC signals in MUX
    wire [31:0] Instruction,ID_Instruction,EX_Instruction; // Output of Instruction Memory
    wire [5:0] Opcode,Function; // Opcode, Function

    //Extend
    wire [15:0] imm14; // immediate in I-type instruction
    wire [31:0] imm14_Ext, EX_imm14_Ext;
    wire [31:0] sign_ext_out, zero_ext_out;

    //Register File
    wire [4:0] rs,rt,rd,EX_rs,EX_rt,EX_rd,EX_WriteRegister,MEM_WriteRegister,WB_WriteRegister;
    wire [31:0] WB_WriteData, ReadData1, ReadData2,ReadData1Out,ReadData2Out, EX_ReadData1, EX_ReadData2;

    //ALU
    wire [31:0] Bus_A_ALU,Bus_B_ALU,Bus_B_forwarded;
    wire [31:0] EX_ALUResult,MEM_ALUResult,WB_ALUResult;
    wire ZeroFlag, OverflowFlag, NegativeFlag,notZeroFlag;

    wire [31:0] WriteDataOfMem,MEM_ReadDataOfMem,WB_ReadDataOfMem;

    //Control signals
    wire RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,SignZero,JRControl;
    
    //========================IF STAGE========================//

    //========================ID STAGE========================//

    //========================EX STAGE========================//

    //========================MEM STAGE========================//

    //========================WB STAGE========================//





endmodule