`timescale 1 ps / 100 fs	  



module controlState(    
    output reg RegDst,
    output reg ALUSrc,
    output reg WBdata,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg Jump,
    output reg JumpJAL,
    output reg [2:0] Next_State,
    input [2:0] Present_State,
    input [6:0] Opcode		 // Opcode = {instructionType, Opcode}
);

    // OpCodes
    localparam AND   = 7'b0000000,
                ADD   = 7'b0000001,
                SUB   = 7'b0000010,
                CMP   = 7'b0000011,
                ANDI  = 7'b0100000,
                ADDI  = 7'b0100001,
                LW    = 7'b0100010,
                SW    = 7'b0100011,
                BEQ   = 7'b0100100,
                J     = 7'b1000000,
                JAL   = 7'b1000001,
                SLL   = 7'b1100000,
                SLR   = 7'b1100001,
                SLLV  = 7'b1100010,
                SLRV  = 7'b1100011;

    // Stages
    localparam IF = 3'b000,
                ID = 3'b001,
                EX = 3'b010,
                MEM = 3'b011,
                WB = 3'b100;

    always @(Opcode, Present_State)
    begin
        case (Present_State)
            IF: begin // Fetch 
                RegDst = 1'bx;
                ALUSrc = 1'bx;
                WBdata = 1'bx;
                RegWrite = 1'bx;
                MemRead = 1'bx;
                MemWrite = 1'bx;
                Branch = 1'bx;
                Jump = 1'bx;
                JumpJAL = 1'bx;
                Next_State = ID;
            end
            
            ID: begin // Decode
                case (Opcode)
                    AND: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    ADD: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    SUB: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    CMP: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    ANDI: begin
                        RegDst = 1'bx;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    ADDI: begin
                        RegDst = 1'bx;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    LW: begin
                        RegDst = 1'bx;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    SW: begin
                        RegDst = 1'b0;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    BEQ: begin
                        RegDst = 1'b0;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    J: begin
                        RegDst = 1'bx;
                        Jump = 1'b1;
                        JumpJAL = 1'b0;
                        Next_State = IF;
                    end
                    JAL: begin
                        RegDst = 1'bx;
                        Jump = 1'b1;
                        JumpJAL = 1'b1;
                        Next_State = IF;
                    end
                    SLL: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    SLR: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    SLLV: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    SLRV: begin
                        RegDst = 1'b1;
                        Jump = 1'b0;
                        JumpJAL = 1'b0;
                        Next_State = EX;
                    end
                    default: begin
                        // Handle unrecognized opcode
                        RegDst = 1'bx;
                        Jump = 1'bx;
                        JumpJAL = 1'bx;
                        Next_State = IF;
                    end
                endcase
            end
            EX: begin // Execute
                case (Opcode)
                    AND: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    ADD: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    SUB: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    CMP: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = IF;
                    end
                    ANDI: begin
                        ALUSrc = 1'b1;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    ADDI: begin
                        ALUSrc = 1'b1;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    LW: begin
                        ALUSrc = 1'b1;
                        Branch = 1'b0;
                        Next_State = MEM;
                    end
                    SW: begin
                        ALUSrc = 1'b1;
                        Branch = 1'b0;
                        Next_State = MEM;
                    end
                    BEQ: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b1;
                        Next_State = IF;
                    end
                    SLL: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    SLR: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    SLLV: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    SLRV: begin
                        ALUSrc = 1'b0;
                        Branch = 1'b0;
                        Next_State = WB;
                    end
                    default: begin
                        ALUSrc = 1'bx;
                        Branch = 1'bx;
                        Next_State = IF;
                    end
                endcase
            end
            MEM: begin // Memory
                case (Opcode)
                    LW: begin
                        MemRead = 1'b1;
                        MemWrite = 1'b0;
                        Next_State = WB;
                    end
                    SW: begin
                        MemRead = 1'b0;
                        MemWrite = 1'b1;
                        Next_State = IF;
                    end
                    default: begin
                        // Handle unrecognized opcode
                        MemRead = 1'bx;
                        MemWrite = 1'bx;
                        Next_State = IF;
                    end
                endcase
            end
            
            WB: begin // Writeback
                case (Opcode)
                    AND: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    ADD: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    SUB: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    ANDI: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    ADDI: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    LW: begin
                        WBdata = 1'b1;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    SLL: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    SLR: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    SLLV: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    SLRV: begin
                        WBdata = 1'b0;
                        RegWrite = 1'b1;
                        Next_State = IF;
                    end
                    default: begin
                        // Handle unrecognized opcode
                        WBdata = 1'bx;
                        RegWrite = 1'bx;
                        Next_State = IF;
                    end
                endcase
            end
        endcase
    end
endmodule
