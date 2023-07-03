`timescale 1 ps / 100 fs


module PC_Control(PCSrc, Jump, Branch, ZeroFlag);
    output [1:0] PCSrc;
    input Jump, Branch, ZeroFlag;

    reg [1:0] PCSrc;

    always @*
    begin
        if (Branch && ZeroFlag)
        PCSrc = 2'b10; // Branch and ZeroFlag == 1
        else if (Jump)
        PCSrc = 2'b01; // Jump == 1
        else
        PCSrc = 2'b00; // All other cases
    end

endmodule
