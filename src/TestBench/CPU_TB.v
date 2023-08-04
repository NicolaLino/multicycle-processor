`timescale 1ns / 1ns


module CPU_tb();
    reg CLK, RST;

    CPU CPU1(CLK, RST);
	
    
    parameter ClockDelay = 400000;
	
    //Data into instruction memory
    initial begin
        $readmemb("instructions.txt", CPU1.Inst_Mem.instrmem);
    end
    
    //Data into register file
    initial begin
        $readmemb("regFile.txt", CPU1.Register_File.RegArray);
    end

    // //Data into data memory
    // initial begin
    //     $readmemb("dataMem.txt", CPU1.Data_Mem.mem);
    // end

    initial begin
        CLK = 1'b0;
        RST = 1'b1;
        #10;								    
        RST = 1'b0;
        #(ClockDelay);
        $finish;
    end


    always begin
        #(ClockDelay / 40) CLK = ~CLK;
    end


    always @(posedge CLK) begin
		$write("\n \n");
        $display("Time = %t: IF Stage - PC = %h, ID_Instruction = %b", $time, CPU1.PC, CPU1.Instruction);
        $display("Time = %t: ID Stage - Opcode = %b, rs1 = %d, rd = %d, rs2 = %d, instructionType = %b, stopBit = %b, imm14 = %d, imm24 = %d, sa = %d, ReadData1 = %d, ReadData2 = %d", $time, CPU1.Opcode, CPU1.rs1, CPU1.rd, CPU1.rs2, CPU1.instructionType, CPU1.stopBit, CPU1.imm14, CPU1.imm24, CPU1.EX_SA, CPU1.ReadData1, CPU1.ReadData2);
        $display("Time = %t: controlUnit - RegDst = %b, ALUSrc = %b, WBdata = %b, RegWrite = %b, MemRead = %b, MemWrite = %b, Branch = %b, Jump = %b ALUControl=%b ", $time, CPU1.RegDst, CPU1.ALUSrc, CPU1.WBdata, CPU1.RegWrite, CPU1.MemRead, CPU1.MemWrite, CPU1.Branch, CPU1.Jump, CPU1.EX_ALUControl);
        $display("Time = %t: EX Stage - EX_ReadData1 = %d, Bus_B_ALU = %d, negative = %b, ALU_CarryOut = %b,ALU_Result = %d", $time, CPU1.EX_ReadData1, CPU1.Bus_B_ALU, CPU1.ALU_Negative, CPU1.ALU_CarryOut ,CPU1.ALU_Result);
        $display("Time = %t: MEM Stage - WB_WriteData = %b", $time, CPU1.WB_WriteData);
    end
endmodule
