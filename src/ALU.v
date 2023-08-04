`timescale 1 ps / 100 fs


////////////////////////////////////////////////// ALU 32bit 
module alu(Output, carryOut, zero, overflow, negative, BussA, BussB, Shamt, controlSignal);
	// alu outputs
	output overflow, negative, zero, carryOut;
	output signed [31:0] Output;
	// alu inputs
	input signed [31:0] BussA;
	input signed [31:0] BussB;
	input [4:0] Shamt;
	input [3:0] controlSignal;

	// registers declarations
	reg signed [31:0] BussBComp;
	reg signed [31:0] Output;
	reg overflow, negative, zero, carryOut;

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

	
	always @(BussA, BussB, controlSignal, Shamt) begin
		case (controlSignal)
			AND: begin
				Output = BussA & BussB;
				overflow = 1'b0;
				carryOut = 1'b0;
			end
			ADD: begin
				Output = BussA + BussB;
				carryOut = (BussA[31] && BussB[31]) || (!Output[31] && (BussA[31] || BussB[31]));
				if ((BussA[31] && BussB[31]) && !Output[31]) overflow = 1'b1;
				else if ((!BussA[31] && !BussB[31]) && Output[31]) overflow = 1'b1;
				else overflow = 1'b0;
			end
			SUB: begin
				BussBComp = ~BussB + 1;
				Output = BussA + BussBComp;
				carryOut = (BussA[31] && BussBComp[31]) || (!Output[31] && (BussA[31] || BussBComp[31]));
				if ((BussA[31] && BussBComp[31]) && !Output[31]) overflow = 1'b1;
				else if ((!BussA[31] && !BussBComp[31]) && Output[31]) overflow = 1'b1;
				else overflow = 1'b0;
			end
			CMP: begin
				BussBComp = ~BussB + 1;
				Output = BussA + BussBComp;
				carryOut = (BussA[31] && BussBComp[31]) || (!Output[31] && (BussA[31] || BussBComp[31]));
			end
			BEQ: begin
				if (BussA == BussB) Output = 32'b0;
				else Output = 32'b1;
				overflow = 1'b0;
				carryOut = 1'b0;
			end
			SLL: begin
				Output = BussA << Shamt;
				overflow = 1'b0;
				carryOut = 1'b0;
			end
			SLR: begin
				Output = BussA >> Shamt;
				overflow = 1'b0;
				carryOut = 1'b0;
			end
			SLLV: begin
				Output = BussA << BussB;
				overflow = 1'b0;
				carryOut = 1'b0;
			end
			SLRV: begin
				Output = BussA >> BussB;
				overflow = 1'b0;
				carryOut = 1'b0;
			end
			default: begin
				Output = 32'bx;
				overflow = 1'bx;
				carryOut = 1'bx;
			end
		endcase
	end
	// zero and negative for all cases
	always @(Output) begin
		if (!Output) zero = 1'b1;
		else zero = 1'b0;

		if (Output[31]) negative = 1'b1;
		else negative = 1'b0;
	end
endmodule

