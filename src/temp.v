`timescale 1 ps / 100 fs
// fpga4student.com: FPGA projects, Verilog Projects, VHDL projects
// Verilog project: 32-bit 5-stage Pipelined MIPS Processor in Verilog 
// Top level Verilog code for 32-bit 5-stage Pipelined MIPS Processor 
module MIPSpipeline(clk, reset);
    input clk, reset;
    wire [31:0] PC, PCin;
    wire [31:0] PC4,ID_PC4,EX_PC4;
    wire [31:0] PCbne,PC4bne,PCj,PC4bnej,PCjr; // PC signals in MUX
    wire [31:0] Instruction,ID_Instruction,EX_Instruction; // Output of Instruction Memory
    wire [5:0] Opcode,Function; // Opcode, Function

    // Extend
    wire [15:0] imm16; // immediate in I type instruction
    wire [31:0] Im16_Ext,EX_Im16_Ext;
    wire [31:0] sign_ext_out,zero_ext_out;
    // regfile
    wire [4:0] rs,rt,rd,EX_rs,EX_rt,EX_rd,EX_WriteRegister,MEM_WriteRegister,WB_WriteRegister;
    wire [31:0] WB_WriteData, ReadData1, ReadData2,ReadData1Out,ReadData2Out, EX_ReadData1, EX_ReadData2;

    // ALU
    wire [31:0] Bus_A_ALU,Bus_B_ALU,Bus_B_forwarded;
    wire [31:0] EX_ALUResult,MEM_ALUResult,WB_ALUResult;
    wire ZeroFlag, OverflowFlag, CarryFlag, NegativeFlag,notZeroFlag;

    wire [31:0] WriteDataOfMem,MEM_ReadDataOfMem,WB_ReadDataOfMem;

    //Control signals 
    wire RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,SignZero,JRControl;
    wire ID_RegDst,ID_ALUSrc,ID_MemtoReg,ID_RegWrite,ID_MemRead,ID_MemWrite,ID_Branch,ID_JRControl;
    wire EX_RegDst,EX_ALUSrc,EX_MemtoReg,EX_RegWrite,EX_MemRead,EX_MemWrite,EX_Branch,EX_JRControl;
    wire MEM_MemtoReg,MEM_RegWrite,MEM_MemRead,MEM_MemWrite;
    wire WB_MemtoReg,WB_RegWrite;
    wire [1:0] ALUOp,ID_ALUOp,EX_ALUOp;
    wire [1:0] ALUControl;
    wire bneControl,notbneControl;
    wire JumpControl,JumpFlush;
    wire [1:0] ForwardA,ForwardB;
        //flush
    wire IF_flush,IFID_flush,notIFID_flush,Stall_flush,flush;
    //shift left
    wire [31:0] shiftleft2_bne_out,shiftleft2_jump_out; // shift left output
    // PC Write Enable, IF/ID Write Enable
    wire PC_WriteEn,IFID_WriteEn;


    //====== PC register======
    register PC_Reg(PC,PCin,PC_WriteEn,reset,clk);
    Add Add1(PC4,PC,{29'b0,3'b100}); // PC4 = PC + 4

    InstructionMem InstructionMem1(Instruction, PC);

    // register IF/ID

    register IFID_PC4(ID_PC4,PC4,IFID_WriteEn,reset,clk);
    register IFID_Instruction(ID_Instruction,Instruction,IFID_WriteEn,reset,clk);
    RegBit IF_flush_bit(IFID_flush,IF_flush, IFID_WriteEn,reset, clk);

    //========= ID STAGE===========
    assign Opcode = ID_Instruction[31:26];
    assign Function = ID_Instruction[5:0];
    assign rs = ID_Instruction[25:21];
    assign rt = ID_Instruction[20:16];
    assign rd = ID_Instruction[15:11];
    assign imm16= ID_Instruction[15:0];

    // Main Control
    Control MainControl(
    RegDst,
    ALUSrc,
    MemtoReg,
    RegWrite,
    MemRead,
    MemWrite,
    Branch,
    ALUOp,
    Jump,
    SignZero,
    Opcode
    );

    // Regfile
    regfile Register_File(
    ReadData1,
    ReadData2,
    WB_WriteData,
    rs,
    rt,
    WB_WriteRegister,
    WB_RegWrite,
    reset,
    clk);

    // forward Read Data if Write and Read at the same time
    WB_forward  WB_forward_block(ReadData1Out,ReadData2Out,ReadData1,ReadData2,rs,rt,WB_WriteRegister,WB_WriteData,WB_RegWrite);
    // Sign-extend
    sign_extend sign_extend1(sign_ext_out,imm16);
    // Zero-extend
    zero_extend zero_extend1(zero_ext_out,imm16);
    // immediate extend: sign or zero
    mux2x32to32 muxSignZero( Im16_Ext,sign_ext_out,zero_ext_out, SignZero);

    JRControl_Block JRControl_Block1( JRControl, ALUOp, Function);

    Discard_Instr Discard_Instr_Block(ID_flush,IF_flush,JumpControl,bneControl,EX_JRControl);

    or #(50) OR_flush(flush,ID_flush,IFID_flush,Stall_flush);
    flush_block flush_block1(ID_RegDst,ID_ALUSrc,ID_MemtoReg,ID_RegWrite,ID_MemRead,ID_MemWrite,ID_Branch,ID_ALUOp,
    ID_JRControl,flush,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp,JRControl);

    //==========EX STAGE=========================
    // thanh ghi ID/EX
    register IDEX_PC4(EX_PC4,ID_PC4,1'b1,reset,clk);

    register IDEX_ReadData1(EX_ReadData1,ReadData1Out,1'b1,reset,clk);
    register IDEX_ReadData2(EX_ReadData2,ReadData2Out,1'b1,reset,clk);


    register IDEX_Im16_Ext(EX_Im16_Ext,Im16_Ext,1'b1,reset,clk);
    register IDEX_rs_rt_rd(EX_Instruction[31:0],ID_Instruction,1'b1,reset,clk);
    assign EX_rs = EX_Instruction[25:21];
    assign EX_rt = EX_Instruction[20:16];
    assign EX_rd = EX_Instruction[15:11];
    // 9 control signals via ID/EX
    RegBit  IDEX_RegDst(EX_RegDst, ID_RegDst, 1'b1,reset, clk);
    RegBit  IDEX_ALUSrc(EX_ALUSrc, ID_ALUSrc, 1'b1,reset, clk);
    RegBit  IDEX_MemtoReg(EX_MemtoReg, ID_MemtoReg, 1'b1,reset, clk);
    RegBit  IDEX_RegWrite(EX_RegWrite, ID_RegWrite, 1'b1,reset, clk);
    RegBit  IDEX_MemRead(EX_MemRead, ID_MemRead, 1'b1,reset, clk);
    RegBit  IDEX_MemWrite(EX_MemWrite, ID_MemWrite, 1'b1,reset, clk);
    RegBit  IDEX_Branch(EX_Branch, ID_Branch, 1'b1,reset, clk);
    RegBit  IDEX_JRControl(EX_JRControl, ID_JRControl, 1'b1,reset, clk);
    RegBit  IDEX_ALUOp1(EX_ALUOp[1], ID_ALUOp[1], 1'b1,reset, clk);
    RegBit  IDEX_ALUOp0(EX_ALUOp[0], ID_ALUOp[0], 1'b1,reset, clk);
    //  Forwarding unit
    ForwardingUnit Forwarding_Block(ForwardA,ForwardB,MEM_RegWrite,WB_RegWrite,MEM_WriteRegister,WB_WriteRegister,EX_rs,EX_rt);
    // mux 3 x32 to 32 to choose source of ALU (forwarding)
    mux3x32to32  mux3A(Bus_A_ALU,EX_ReadData1,MEM_ALUResult,WB_WriteData,ForwardA);
    mux3x32to32  mux3B(Bus_B_forwarded,EX_ReadData2,MEM_ALUResult,WB_WriteData,ForwardB);
    // mux 2x32 to 32 to select source Bus B of ALU
    mux2x32to32 muxALUSrc( Bus_B_ALU,Bus_B_forwarded,EX_Im16_Ext, EX_ALUSrc);
    // ALU Control
    ALUControl_Block ALUControl_Block1( ALUControl, EX_ALUOp, EX_Im16_Ext[5:0]);
    // EX_Im16_Ext[5:0] is function

    // ALU
    alu alu_block(EX_ALUResult, CarryFlag, ZeroFlag, OverflowFlag, NegativeFlag, Bus_A_ALU, Bus_B_ALU, ALUControl);

    // mux 2x5 to 5 choose shift register is Rd or Rt
    mux2x5to5 muxRegDst( EX_WriteRegister,EX_rt,EX_rd, EX_RegDst);

    //==============MEM STAGE=================
    // register EX/MEM
    register EXMEM_ALUResult(MEM_ALUResult,EX_ALUResult,1'b1,reset,clk);
    register EXMEM_WriteDataOfMem(WriteDataOfMem, Bus_B_forwarded,1'b1,reset,clk);
    RegBit  EXMEM_MemtoReg(MEM_MemtoReg, EX_MemtoReg, 1'b1,reset, clk);
    RegBit  EXMEM_RegWrite(MEM_RegWrite, EX_RegWrite, 1'b1,reset, clk);
    RegBit  EXMEM_MemRead(MEM_MemRead, EX_MemRead, 1'b1,reset, clk);
    RegBit  EXMEM_MemWrite(MEM_MemWrite, EX_MemWrite, 1'b1,reset, clk);
    RegBit  EXMEM_WriteRegister4(MEM_WriteRegister[4], EX_WriteRegister[4], 1'b1,reset, clk);
    RegBit  EXMEM_WriteRegister3(MEM_WriteRegister[3], EX_WriteRegister[3], 1'b1,reset, clk);
    RegBit  EXMEM_WriteRegister2(MEM_WriteRegister[2], EX_WriteRegister[2], 1'b1,reset, clk);
    RegBit  EXMEM_WriteRegister1(MEM_WriteRegister[1], EX_WriteRegister[1], 1'b1,reset, clk);
    RegBit  EXMEM_WriteRegister0(MEM_WriteRegister[0], EX_WriteRegister[0], 1'b1,reset, clk);

    // Data Memory 
    dataMem dataMem1(MEM_ReadDataOfMem, //data 
        MEM_ALUResult,       //address
        WriteDataOfMem,       //writedata
        MEM_MemWrite,        //writeenable
        MEM_MemRead,        
        clk);
    //==========WB STAGE====================
    // register MEM/WB
    register MEMWB_ReadDataOfMem(WB_ReadDataOfMem,MEM_ReadDataOfMem,1'b1,reset,clk);
    register MEMWB_ALUResult(WB_ALUResult,MEM_ALUResult,1'b1,reset,clk);
    RegBit  MEMWB_WriteRegister4(WB_WriteRegister[4], MEM_WriteRegister[4], 1'b1,reset, clk);
    RegBit  MEMWB_WriteRegister3(WB_WriteRegister[3], MEM_WriteRegister[3], 1'b1,reset, clk);
    RegBit  MEMWB_WriteRegister2(WB_WriteRegister[2], MEM_WriteRegister[2], 1'b1,reset, clk);
    RegBit  MEMWB_WriteRegister1(WB_WriteRegister[1], MEM_WriteRegister[1], 1'b1,reset, clk);
    RegBit  MEMWB_WriteRegister0(WB_WriteRegister[0], MEM_WriteRegister[0], 1'b1,reset, clk);

    RegBit  MEMWB_MemtoReg(WB_MemtoReg, MEM_MemtoReg, 1'b1,reset, clk);
    RegBit  MEMWB_RegWrite(WB_RegWrite, MEM_RegWrite, 1'b1,reset, clk);

    // Select Data to WriteData for regfile
    mux2x32to32 muxMemtoReg( WB_WriteData, WB_ALUResult, WB_ReadDataOfMem,WB_MemtoReg);

    //Stalling
    StallControl StallControl_block(PC_WriteEn,IFID_WriteEn,Stall_flush,EX_MemRead,EX_rt,rs,rt,Opcode);

    //Jump,bne, JRs
    // bne: Branch if not equal
    shift_left_2 shiftleft2_bne(shiftleft2_bne_out, EX_Im16_Ext);
    Add Add_bne(PCbne,EX_PC4,shiftleft2_bne_out);
    not #(50) notZero(notZeroFlag,ZeroFlag);
    and #(50) andbneControl(bneControl,EX_Branch,notZeroFlag);
    mux2x32to32  muxbneControl( PC4bne,PC4, PCbne, bneControl);
    // jump
    shift_left_2 shiftleft2_jump(shiftleft2_jump_out, {6'b0,ID_Instruction[25:0]});
    assign PCj = {ID_PC4[31:28],shiftleft2_jump_out[27:0]};

    not #(50) notIFIDFlush(notIFID_flush,IFID_flush);
    and #(50) andJumpFlush(JumpFlush,Jump,notIFID_flush);
    not #(50) notbne(notbneControl,bneControl);
    and #(50) andJumpBNE(JumpControl,JumpFlush,notbneControl);
    mux2x32to32  muxJump( PC4bnej,PC4bne, PCj, JumpControl);

    // JR: Jump Register
    assign PCjr = Bus_A_ALU;
    mux2x32to32  muxJR( PCin,PC4bnej, PCjr, EX_JRControl);
    
endmodule