`timescale 1 ps / 100 fs


////////////////////////////////////////////////// ALU 32bit 
module alu(Output, CarryOut, zero, overflow, negative, BussA, BussB, InstructionType, Function);
	output reg CarryOut, overflow, negative, zero;
	output reg [31:0] Output;
	input [31:0] BussA, BussB;
	input [1:0] InstructionType;
	input [4:0] Function;
	wire notcr31;
	wire [31:0] crrout;
	wire [31:0] addsubOut;
	reg ArithmeticControl;


	addsub addsub0(addsubOut[0], crrout[0], BussA[0], BussB[0], ArithmeticControl, ArithmeticControl);
	addsub addsub1(addsubOut[1], crrout[1], BussA[1], BussB[1], crrout[0], ArithmeticControl);
	addsub addsub2(addsubOut[2], crrout[2], BussA[2], BussB[2], crrout[1], ArithmeticControl);
	addsub addsub3(addsubOut[3], crrout[3], BussA[3], BussB[3], crrout[2], ArithmeticControl);
	addsub addsub4(addsubOut[4], crrout[4], BussA[4], BussB[4], crrout[3], ArithmeticControl);
	addsub addsub5(addsubOut[5], crrout[5], BussA[5], BussB[5], crrout[4], ArithmeticControl);
	addsub addsub6(addsubOut[6], crrout[6], BussA[6], BussB[6], crrout[5], ArithmeticControl);
	addsub addsub7(addsubOut[7], crrout[7], BussA[7], BussB[7], crrout[6], ArithmeticControl);
	addsub addsub8(addsubOut[8], crrout[8], BussA[8], BussB[8], crrout[7], ArithmeticControl);
	addsub addsub9(addsubOut[9], crrout[9], BussA[9], BussB[9], crrout[8], ArithmeticControl);
	addsub addsub10(addsubOut[10], crrout[10], BussA[10], BussB[10], crrout[9], ArithmeticControl);
	addsub addsub11(addsubOut[11], crrout[11], BussA[11], BussB[11], crrout[10], ArithmeticControl);
	addsub addsub12(addsubOut[12], crrout[12], BussA[12], BussB[12], crrout[11], ArithmeticControl);
	addsub addsub13(addsubOut[13], crrout[13], BussA[13], BussB[13], crrout[12], ArithmeticControl);
	addsub addsub14(addsubOut[14], crrout[14], BussA[14], BussB[14], crrout[13], ArithmeticControl);
	addsub addsub15(addsubOut[15], crrout[15], BussA[15], BussB[15], crrout[14], ArithmeticControl);
	addsub addsub16(addsubOut[16], crrout[16], BussA[16], BussB[16], crrout[15], ArithmeticControl);
	addsub addsub17(addsubOut[17], crrout[17], BussA[17], BussB[17], crrout[16], ArithmeticControl);
	addsub addsub18(addsubOut[18], crrout[18], BussA[18], BussB[18], crrout[17], ArithmeticControl);
	addsub addsub19(addsubOut[19], crrout[19], BussA[19], BussB[19], crrout[18], ArithmeticControl);
	addsub addsub20(addsubOut[20], crrout[20], BussA[20], BussB[20], crrout[19], ArithmeticControl);
	addsub addsub21(addsubOut[21], crrout[21], BussA[21], BussB[21], crrout[20], ArithmeticControl);
	addsub addsub22(addsubOut[22], crrout[22], BussA[22], BussB[22], crrout[21], ArithmeticControl);
	addsub addsub23(addsubOut[23], crrout[23], BussA[23], BussB[23], crrout[22], ArithmeticControl);
	addsub addsub24(addsubOut[24], crrout[24], BussA[24], BussB[24], crrout[23], ArithmeticControl);
	addsub addsub25(addsubOut[25], crrout[25], BussA[25], BussB[25], crrout[24], ArithmeticControl);
	addsub addsub26(addsubOut[26], crrout[26], BussA[26], BussB[26], crrout[25], ArithmeticControl);
	addsub addsub27(addsubOut[27], crrout[27], BussA[27], BussB[26], crrout[26], ArithmeticControl);
	addsub addsub28(addsubOut[28], crrout[28], BussA[28], BussB[28], crrout[27], ArithmeticControl);
	addsub addsub29(addsubOut[29], crrout[29], BussA[29], BussB[29], crrout[28], ArithmeticControl);
	addsub addsub30(addsubOut[30], crrout[30], BussA[30], BussB[30], crrout[29], ArithmeticControl);
	addsub addsub31(addsubOut[31], crrout[31], BussA[31], BussB[31], crrout[30], ArithmeticControl);

	not #(50) notcarry(notcr31, crrout[31]);

	// Carryout = Not carry out 31 if it is subtraction
	mux21 muxcarry31(CarryOut, crrout[31], notcr31, ArithmeticControl);

	// Overflow Flag
	xor #(50) xor5(overflow, crrout[30], crrout[31]);

	// Negative Flag: if most significant bit == 1 negative, OW non-negative
	assign negative = addsubOut[31];

	always @(*) begin
		case (InstructionType)
			2'b00: // R-Type Instructions
				case (Function)
					5'b00000: Output = BussA & BussB; // AND
					5'b00001: begin // ADD
						Output = addsubOut;
						ArithmeticControl = 0;
						zero = (Output == 0) ? 1 : 0;
					end 
					5'b00010: begin	// SUB
						ArithmeticControl = 1;
						if (negative)
							Output = ~addsubOut + 1;
						else
							Output = addsubOut;
							zero = (Output == 0) ? 1 : 0;
					end
					5'b00011: begin	// CMP
						ArithmeticControl = 1;
						if (negative)
							Output = ~addsubOut + 1;
						else
							Output = addsubOut;
							zero = (Output == 0) ? 1 : 0;
					end
					default: Output = 0;
				endcase

			2'b10: // I-Type Instructions
				case (Function)
					5'b00000: Output = BussA & BussB; // ANDI
					5'b00001: begin // ADDI
						Output = addsubOut;
						zero = (Output == 0) ? 1 : 0;
						ArithmeticControl = 0;
					end 
					5'b00010: begin // LW (Load Word)
						Output = addsubOut;
						zero = (Output == 0) ? 1 : 0;
						ArithmeticControl = 0;
					end 
					5'b00011: begin // SW (Store Word)
						Output = addsubOut;
						zero = (Output == 0) ? 1 : 0; 
						ArithmeticControl = 0;
					end  
					5'b00100: zero = (BussA == BussA) ? 1 : 0;// BEQ (Branch if Equal)
					default: Output = 0;
				endcase

			2'b11: // S-Type Instructions
				case (Function)
					5'b00000: Output = BussA << BussB[4:0]; // SLL
					5'b00001: Output = BussA >> BussB[4:0]; // SLR
					5'b00010: Output = BussA << BussB; // SLLV
					5'b00011: Output = BussA >> BussB; // SLRV
					default: Output = 0;
				endcase
		endcase
	end
endmodule
zz