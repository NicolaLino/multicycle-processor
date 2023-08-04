`timescale 1 ps / 100 fs

module regfile(
	ReadData1,
	ReadData2,
	WriteData,
	ReadRegister1,
	ReadRegister2,
	WriteRegister,
	RegWrite,
	reset,
	clk
);
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input [31:0] WriteData;
	input RegWrite, reset, clk;
	output [31:0] ReadData1, ReadData2;
	wire [31:0] WriteEn;
	wire [31:0] RegArray [0:31];
	integer i;

	//---- Decoder Block ----
	decoder Decoder1(WriteEn, RegWrite, WriteRegister);

	register reg0 (RegArray[0], 32'b0, 1'b1, 1'b0, clk);
	register reg1 (RegArray[1], WriteData, WriteEn[1], reset, clk);
	register reg2 (RegArray[2], WriteData, WriteEn[2], reset, clk);
	register reg3 (RegArray[3], WriteData, WriteEn[3], reset, clk);
	register reg4 (RegArray[4], WriteData, WriteEn[4], reset, clk);
	register reg5 (RegArray[5], WriteData, WriteEn[5], reset, clk);
	register reg6 (RegArray[6], WriteData, WriteEn[6], reset, clk);
	register reg7 (RegArray[7], WriteData, WriteEn[7], reset, clk);
	register reg8 (RegArray[8], WriteData, WriteEn[8], reset, clk);
	register reg9 (RegArray[9], WriteData, WriteEn[9], reset, clk);
	register reg10 (RegArray[10], WriteData, WriteEn[10], reset, clk);
	register reg11 (RegArray[11], WriteData, WriteEn[11], reset, clk);
	register reg12 (RegArray[12], WriteData, WriteEn[12], reset, clk);
	register reg13 (RegArray[13], WriteData, WriteEn[13], reset, clk);
	register reg14 (RegArray[14], WriteData, WriteEn[14], reset, clk);
	register reg15 (RegArray[15], WriteData, WriteEn[15], reset, clk);
	register reg16 (RegArray[16], WriteData, WriteEn[16], reset, clk);
	register reg17 (RegArray[17], WriteData, WriteEn[17], reset, clk);
	register reg18 (RegArray[18], WriteData, WriteEn[18], reset, clk);
	register reg19 (RegArray[19], WriteData, WriteEn[19], reset, clk);
	register reg20 (RegArray[20], WriteData, WriteEn[20], reset, clk);
	register reg21 (RegArray[21], WriteData, WriteEn[21], reset, clk);
	register reg22 (RegArray[22], WriteData, WriteEn[22], reset, clk);
	register reg23 (RegArray[23], WriteData, WriteEn[23], reset, clk);
	register reg24 (RegArray[24], WriteData, WriteEn[24], reset, clk);
	register reg25 (RegArray[25], WriteData, WriteEn[25], reset, clk);
	register reg26 (RegArray[26], WriteData, WriteEn[26], reset, clk);
	register reg27 (RegArray[27], WriteData, WriteEn[27], reset, clk);
	register reg28 (RegArray[28], WriteData, WriteEn[28], reset, clk);
	register reg29 (RegArray[29], WriteData, WriteEn[29], reset, clk);
	register reg30 (RegArray[30], WriteData, WriteEn[30], reset, clk);
	register reg31 (RegArray[31], WriteData, WriteEn[31], reset, clk); 
   
	//---- 32x32to32 Multiplexor1 Block ----
	mux32x32to32 Mux1(
		ReadData1,
		RegArray[0], RegArray[1], RegArray[2], RegArray[3], RegArray[4], RegArray[5], RegArray[6], RegArray[7],
		RegArray[8], RegArray[9], RegArray[10], RegArray[11], RegArray[12], RegArray[13], RegArray[14], RegArray[15],
		RegArray[16], RegArray[17], RegArray[18], RegArray[19], RegArray[20], RegArray[21], RegArray[22], RegArray[23],
		RegArray[24], RegArray[25], RegArray[26], RegArray[27], RegArray[28], RegArray[29], RegArray[30], RegArray[31],
		ReadRegister1
	);

	//---- 32x32to32 Multiplexor2 Block ----
	mux32x32to32 Mux2(
		ReadData2,
		RegArray[0], RegArray[1], RegArray[2], RegArray[3], RegArray[4], RegArray[5], RegArray[6], RegArray[7],
		RegArray[8], RegArray[9], RegArray[10], RegArray[11], RegArray[12], RegArray[13], RegArray[14], RegArray[15],
		 RegArray[16], RegArray[17], RegArray[18], RegArray[19], RegArray[20], RegArray[21], RegArray[22], RegArray[23],
		 RegArray[24], RegArray[25], RegArray[26], RegArray[27], RegArray[28], RegArray[29], RegArray[30], RegArray[31],
		ReadRegister2
	);
endmodule