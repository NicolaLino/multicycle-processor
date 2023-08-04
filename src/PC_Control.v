`timescale 1 ps / 100 fs


module PC_Control(PCSrc,PC4Signal, Jump, stopBit, Branch, ZeroFlag);
    output [1:0] PCSrc;
    input Jump, Branch, ZeroFlag, stopBit, PC4Signal;

    reg [1:0] PCSrc;

    always @*
    begin
        if (Branch && ZeroFlag)
            PCSrc = 2'b10; // Branch and ZeroFlag == 1
        else if (Jump)
            PCSrc = 2'b01; // Jump == 1
        else if (stopBit)
            PCSrc = 2'b11; // JAL == 1
        else if (PC4Signal && stopBit)
            PCSrc = 2'b11; // PC4 == 1
        else if (PC4Signal)
            PCSrc = 2'b00; // PC4 == 1
        else
            PCSrc = 2'bxx; // Default case (All other cases)
    end
endmodule

