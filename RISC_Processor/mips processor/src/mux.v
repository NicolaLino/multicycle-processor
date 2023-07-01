`timescale 1 ps / 100 fs

//////////////////////////////////////////////////	 mux 32to1
module mux32to1(Out, In, Select);
  output Out;
  input [31:0] In;
  input [4:0] Select;
  wire [31:0] OE, f; // OE = Output Enable
  wire g12, g7, g8, g9, g10,g11, g3, g4, g5, g6;
  
  dec5to32 dec1(OE, Select);
  
  and #(50) g_0(f[0], OE[0], In[0]);
  and #(50) g_1(f[1], OE[1], In[1]);
  and #(50) g_2(f[2], OE[2], In[2]);
  and #(50) g_3(f[3], OE[3], In[3]);
  and #(50) g_4(f[4], OE[4], In[4]);
  and #(50) g_5(f[5], OE[5], In[5]);
  and #(50) g_6(f[6], OE[6], In[6]);
  and #(50) g_7(f[7], OE[7], In[7]);
  and #(50) g_8(f[8], OE[8], In[8]);
  and #(50) g_9(f[9], OE[9], In[9]);
  and #(50) g_10(f[10], OE[10], In[10]);
  and #(50) g_11(f[11], OE[11], In[11]);
  and #(50) g_12(f[12], OE[12], In[12]);
  and #(50) g_13(f[13], OE[13], In[13]);
  and #(50) g_14(f[14], OE[14], In[14]);
  and #(50) g_15(f[15], OE[15], In[15]);
  and #(50) g_16(f[16], OE[16], In[16]);
  and #(50) g_17(f[17], OE[17], In[17]);
  and #(50) g_18(f[18], OE[18], In[18]);
  and #(50) g_19(f[19], OE[19], In[19]);
  and #(50) g_20(f[20], OE[20], In[20]);
  and #(50) g_21(f[21], OE[21], In[21]);
  and #(50) g_22(f[22], OE[22], In[22]);
  and #(50) g_23(f[23], OE[23], In[23]);
  and #(50) g_24(f[24], OE[24], In[24]);
  and #(50) g_25(f[25], OE[25], In[25]);
  and #(50) g_26(f[26], OE[26], In[26]);
  and #(50) g_27(f[27], OE[27], In[27]);
  and #(50) g_28(f[28], OE[28], In[28]);
  and #(50) g_29(f[29], OE[29], In[29]);
  and #(50) g_30(f[30], OE[30], In[30]);
  and #(50) g_31(f[31], OE[31], In[31]);
  
  or #(50) gate3(g3, f[0], f[1], f[2], f[3]);
  or #(50) gate4(g4, f[4], f[5], f[6], f[7]);
  or #(50) gate5(g5, f[8], f[9], f[10], f[11]);
  or #(50) gate6(g6, f[12], f[13], f[14], f[15]);
  or #(50) gate7(g7, f[16], f[17], f[18], f[19]);
  or #(50) gate8(g8, f[20], f[21], f[22], f[23]);
  or #(50) gate9(g9, f[24], f[25], f[26], f[27]);
  or #(50) gate10(g10, f[28], f[29], f[30], f[31]);
  or #(50) gate11(g11, g3, g4, g5, g6);
  or #(50) gate12(g12, g7, g8, g9, g10);
  or #(50) gate(Out, g11, g12);
endmodule



//////////////////////////////////////////////////	 mux 32x32 to32
module mux32x32to32(ReadData, In0, In1, In2, In3, In4, In5, In6, In7, In8, In9, In10, In11, In12, In13, In14, In15, In16, In17, In18, In19, In20, In21, In22, In23, In24, In25, In26, In27, In28, In29, In30, In31, ReadRegister);
  input [31:0] In0, In1, In2, In3, In4, In5, In6, In7, In8, In9, In10, In11, In12, In13, In14, In15, In16, In17, In18, In19, In20, In21, In22, In23, In24, In25, In26, In27, In28, In29, In30, In31;
  input [4:0] ReadRegister;
  output [31:0] ReadData;
  reg [31:0] ArrayReg [0:31];
  integer j;
  
  always @(*)
  begin
    for (j = 0; j <= 31; j = j + 1)
      ArrayReg[j] = {In31[j], In30[j], In29[j], In28[j], In27[j], In26[j], In25[j], In24[j], In23[j], In22[j], In21[j],
                     In20[j], In19[j], In18[j], In17[j], In16[j], In15[j], In14[j], In13[j], In12[j], In11[j],
                     In10[j], In9[j], In8[j], In7[j], In6[j], In5[j], In4[j], In3[j], In2[j], In1[j], In0[j]};
  end
  
  mux32to1 mux0(ReadData[0], ArrayReg[0], ReadRegister);
  mux32to1 mux1(ReadData[1], ArrayReg[1], ReadRegister);
  mux32to1 mux2(ReadData[2], ArrayReg[2], ReadRegister);
  mux32to1 mux3(ReadData[3], ArrayReg[3], ReadRegister);
  mux32to1 mux4(ReadData[4], ArrayReg[4], ReadRegister);
  mux32to1 mux5(ReadData[5], ArrayReg[5], ReadRegister);
  mux32to1 mux6(ReadData[6], ArrayReg[6], ReadRegister);
  mux32to1 mux7(ReadData[7], ArrayReg[7], ReadRegister);
  mux32to1 mux8(ReadData[8], ArrayReg[8], ReadRegister);
  mux32to1 mux9(ReadData[9], ArrayReg[9], ReadRegister);
  mux32to1 mux10(ReadData[10], ArrayReg[10], ReadRegister);
  mux32to1 mux11(ReadData[11], ArrayReg[11], ReadRegister);
  mux32to1 mux12(ReadData[12], ArrayReg[12], ReadRegister);
  mux32to1 mux13(ReadData[13], ArrayReg[13], ReadRegister);
  mux32to1 mux14(ReadData[14], ArrayReg[14], ReadRegister);
  mux32to1 mux15(ReadData[15], ArrayReg[15], ReadRegister);
  mux32to1 mux16(ReadData[16], ArrayReg[16], ReadRegister);
  mux32to1 mux17(ReadData[17], ArrayReg[17], ReadRegister);
  mux32to1 mux18(ReadData[18], ArrayReg[18], ReadRegister);
  mux32to1 mux19(ReadData[19], ArrayReg[19], ReadRegister);
  mux32to1 mux20(ReadData[20], ArrayReg[20], ReadRegister);
  mux32to1 mux21(ReadData[21], ArrayReg[21], ReadRegister);
  mux32to1 mux22(ReadData[22], ArrayReg[22], ReadRegister);
  mux32to1 mux23(ReadData[23], ArrayReg[23], ReadRegister);
  mux32to1 mux24(ReadData[24], ArrayReg[24], ReadRegister);
  mux32to1 mux25(ReadData[25], ArrayReg[25], ReadRegister);
  mux32to1 mux26(ReadData[26], ArrayReg[26], ReadRegister);
  mux32to1 mux27(ReadData[27], ArrayReg[27], ReadRegister);
  mux32to1 mux28(ReadData[28], ArrayReg[28], ReadRegister);
  mux32to1 mux29(ReadData[29], ArrayReg[29], ReadRegister);
  mux32to1 mux30(ReadData[30], ArrayReg[30], ReadRegister);
  mux32to1 mux31(ReadData[31], ArrayReg[31], ReadRegister);
  
endmodule

//////////////////////////////////////////////////	 mux 2x1
module mux21(O, A, B, sel);
  // sel = 0 : O = A
  // sel = 1 : O = B
  output O;
  input A, B, sel;
  wire nsel, O1, O2;
  
  not #(50) not1(nsel, sel);
  and #(50) and1(O1, A, nsel);
  and #(50) and2(O2, B, sel);
  or #(50) or2(O, O1, O2);
endmodule

//////////////////////////////////////////////////	Select Write Register
module mux2x5to5(AddrOut, Addr0, Addr1, Select);
  output [4:0] AddrOut; // Address Out
  input [4:0] Addr0, Addr1; // Address In 1 and 2
  input Select;
  
  mux2_1 mux0(AddrOut[0], Addr0[0], Addr1[0], Select);
  mux2_1 mux1(AddrOut[1], Addr0[1], Addr1[1], Select);
  mux2_1 mux2(AddrOut[2], Addr0[2], Addr1[2], Select);
  mux2_1 mux3(AddrOut[3], Addr0[3], Addr1[3], Select);
  mux2_1 mux4(AddrOut[4], Addr0[4], Addr1[4], Select);
endmodule


////////////////////////////////////////////////// Multiplexer for choosing Bus B ALU	& Select Data to WriteData for regfile
module mux2x32to32(DataOut, Data0, Data1, Select);
  output [31:0] DataOut; // Data Out
  input [31:0] Data0, Data1; // Data In 1 and 2
  input Select;
  
  mux21 mux0(DataOut[0], Data0[0], Data1[0], Select);
  mux21 mux1(DataOut[1], Data0[1], Data1[1], Select);
  mux21 mux2(DataOut[2], Data0[2], Data1[2], Select);
  mux21 mux3(DataOut[3], Data0[3], Data1[3], Select);
  mux21 mux4(DataOut[4], Data0[4], Data1[4], Select);
  mux21 mux5(DataOut[5], Data0[5], Data1[5], Select);
  mux21 mux6(DataOut[6], Data0[6], Data1[6], Select);
  mux21 mux7(DataOut[7], Data0[7], Data1[7], Select);
  mux21 mux8(DataOut[8], Data0[8], Data1[8], Select);
  mux21 mux9(DataOut[9], Data0[9], Data1[9], Select);
  mux21 mux10(DataOut[10], Data0[10], Data1[10], Select);
  mux21 mux11(DataOut[11], Data0[11], Data1[11], Select);
  mux21 mux12(DataOut[12], Data0[12], Data1[12], Select);
  mux21 mux13(DataOut[13], Data0[13], Data1[13], Select);
  mux21 mux14(DataOut[14], Data0[14], Data1[14], Select);
  mux21 mux15(DataOut[15], Data0[15], Data1[15], Select);
  mux21 mux16(DataOut[16], Data0[16], Data1[16], Select);
  mux21 mux17(DataOut[17], Data0[17], Data1[17], Select);
  mux21 mux18(DataOut[18], Data0[18], Data1[18], Select);
  mux21 mux19(DataOut[19], Data0[19], Data1[19], Select);
  mux21 mux20(DataOut[20], Data0[20], Data1[20], Select);
  mux21 mux21(DataOut[21], Data0[21], Data1[21], Select);
  mux21 mux22(DataOut[22], Data0[22], Data1[22], Select);
  mux21 mux23(DataOut[23], Data0[23], Data1[23], Select);
  mux21 mux24(DataOut[24], Data0[24], Data1[24], Select);
  mux21 mux25(DataOut[25], Data0[25], Data1[25], Select);
  mux21 mux26(DataOut[26], Data0[26], Data1[26], Select);
  mux21 mux27(DataOut[27], Data0[27], Data1[27], Select);
  mux21 mux28(DataOut[28], Data0[28], Data1[28], Select);
  mux21 mux29(DataOut[29], Data0[29], Data1[29], Select);
  mux21 mux30(DataOut[30], Data0[30], Data1[30], Select);
  mux21 mux31(DataOut[31], Data0[31], Data1[31], Select);
endmodule

