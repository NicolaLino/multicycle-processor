`timescale 1 ps / 100 fs


module ALUControl(
    output reg [3:0] ALUControl,
    input [5:0] opcode,
    input [1:0] instructionType
);
    // control signals
	parameter 	AND  = 4'b0001,
				ADD  = 4'b0010,
				SUB  = 4'b0011,
				CMP = 4'b0100,
				BEQ = 4'b0101,
				SLL = 4'b1100,
				SLR = 4'b1101,
				SLLV = 4'b1110,
				SLRV = 4'b1111;

    always @*
    begin
        case (instructionType)
            2'b00: // R-Type Instructions
                case (opcode)
                    5'b00000: ALUControl = AND;
                    5'b00001: ALUControl = ADD;
                    5'b00010: ALUControl = SUB;
                    5'b00011: ALUControl = CMP;
                    default: ALUControl = 4'bxxxx;
                endcase

            2'b10: // I-Type Instructions
                case (opcode)
                    5'b00000: ALUControl = AND;
                    5'b00001: ALUControl = ADD;
                    5'b00010: ALUControl = ADD;
                    5'b00011: ALUControl = ADD;
                    5'b00100: ALUControl = BEQ;
                    default: ALUControl = 4'bxxxx;
                endcase

            2'b11: // S-Type Instructions
                case (opcode)
                    5'b00000: ALUControl = SLL;
                    5'b00001: ALUControl = SLR;
                    5'b00010: ALUControl = SLLV;
                    5'b00011: ALUControl = SLRV;
                    default: ALUControl = 4'bxxxx;
                endcase

            default: ALUControl = 4'bxxxx;
        endcase
    end
endmodule



