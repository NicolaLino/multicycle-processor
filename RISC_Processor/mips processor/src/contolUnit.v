`timescale 1 ps / 100 fs

module controlUnit(
    input [5:0] Opcode,
    input [1:0] instructionType,
    output reg RegDst,
    output reg ALUSrc,
    output reg WBdata,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg Jump
);

    always @(*)
    begin
        case (instructionType)
            2'b00: // R-Type Instructions
                case (Opcode)
                    5'b00000: begin // AND
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00001: begin // ADD
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00010: begin // SUB
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00011: begin // CMP
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    default: begin
                        RegDst = 1'bx;
                        ALUSrc = 1'bx;
                        WBdata = 1'bx;
                        RegWrite = 1'bx;
                        MemRead = 1'bx;
                        MemWrite = 1'bx;
                        Branch = 1'bx;
                        Jump = 1'bx;
                    end
                endcase

            2'b01: // I-Type Instructions
                case (Opcode)
                    5'b00000: begin // ANDI
                        RegDst = 1'b1;
                        ALUSrc = 1'b1;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00001: begin // ADDI
                        RegDst = 1'b1;
                        ALUSrc = 1'b1;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00010: begin // LW
                        RegDst = 1'b1;
                        ALUSrc = 1'b1;
                        WBdata = 1'b1;
                        RegWrite = 1'b1;
                        MemRead = 1'b1;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00011: begin // SW
                        RegDst = 1'b1;
                        ALUSrc = 1'b1;
                        WBdata = 1'b0;
                        RegWrite = 1'b0;
                        MemRead = 1'b0;
                        MemWrite = 1'b1;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00100: begin // BEQ
                        RegDst = 1'b0;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b0;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b1;
                        Jump = 1'b0;
                    end
                    default: begin
                        RegDst = 1'bx;
                        ALUSrc = 1'bx;
                        WBdata = 1'bx;
                        RegWrite = 1'bx;
                        MemRead = 1'bx;
                        MemWrite = 1'bx;
                        Branch = 1'bx;
                        Jump = 1'bx;
                    end
                endcase

            2'b10: // J-Type Instructions
                case (Opcode)
                    5'b00000: begin // J
                        RegDst = 1'b0;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b0;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b1;
                    end
                    5'b00001: begin // JAL
                        RegDst = 1'b0;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b0;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b1;
                    end
                    default: begin
                        RegDst = 1'bx;
                        ALUSrc = 1'bx;
                        WBdata = 1'bx;
                        RegWrite = 1'bx;
                        MemRead = 1'bx;
                        MemWrite = 1'bx;
                        Branch = 1'bx;
                        Jump = 1'bx;
                    end
                endcase

            2'b11: // S-Type Instructions
                case (Opcode)
                    5'b00000: begin // SLL
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00001: begin // SLR
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00010: begin // SLLV
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    5'b00011: begin // SLRV
                        RegDst = 1'b1;
                        ALUSrc = 1'b0;
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        Branch = 1'b0;
                        Jump = 1'b0;
                    end
                    default: begin
                        RegDst = 1'bx;
                        ALUSrc = 1'bx;
                        WBdata = 1'bx;
                        RegWrite = 1'bx;
                        MemRead = 1'bx;
                        MemWrite = 1'bx;
                        Branch = 1'bx;
                        Jump = 1'bx;
                    end
                endcase

            default: begin
                RegDst = 1'bx;
                ALUSrc = 1'bx;
                WBdata = 1'bx;
                RegWrite = 1'bx;
                MemRead = 1'bx;
                MemWrite = 1'bx;
                Branch = 1'bx;
                Jump = 1'bx;
            end
        endcase
    end
endmodule
