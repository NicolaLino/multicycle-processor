`timescale 1 ps / 100 fs

module adder1bit(sum, cout, a, b, cin);
  input a, b, cin;
  output sum, cout;

  // sum = a xor b xor cin
  xor #(50) xor1(sum, a, b, cin);

  // carry out = a.b + cin.(a+b)
  and #(50) and1(c1, a, b);
  or #(50) or1(c2, a, b);
  and #(50) and2(c3, c2, cin);
  or #(50) or2(cout, c1, c3);
endmodule



module Add(S, A, B);
  output [31:0] S;
  input [31:0] A, B;
  wire [31:0] C;

  adder1bit adder1bit0(S[0], C[0], A[0], B[0], 1'b0);
  adder1bit adder1bit1(S[1], C[1], A[1], B[1], C[0]);
  adder1bit adder1bit2(S[2], C[2], A[2], B[2], C[1]);
  adder1bit adder1bit3(S[3], C[3], A[3], B[3], C[2]);
  adder1bit adder1bit4(S[4], C[4], A[4], B[4], C[3]);
  adder1bit adder1bit5(S[5], C[5], A[5], B[5], C[4]);
  adder1bit adder1bit6(S[6], C[6], A[6], B[6], C[5]);
  adder1bit adder1bit7(S[7], C[7], A[7], B[7], C[6]);
  adder1bit adder1bit8(S[8], C[8], A[8], B[8], C[7]);
  adder1bit adder1bit9(S[9], C[9], A[9], B[9], C[8]);
  adder1bit adder1bit10(S[10], C[10], A[10], B[10], C[9]);
  adder1bit adder1bit11(S[11], C[11], A[11], B[11], C[10]);
  adder1bit adder1bit12(S[12], C[12], A[12], B[12], C[11]);
  adder1bit adder1bit13(S[13], C[13], A[13], B[13], C[12]);
  adder1bit adder1bit14(S[14], C[14], A[14], B[14], C[13]);
  adder1bit adder1bit15(S[15], C[15], A[15], B[15], C[14]);
  adder1bit adder1bit16(S[16], C[16], A[16], B[16], C[15]);
  adder1bit adder1bit17(S[17], C[17], A[17], B[17], C[16]);
  adder1bit adder1bit18(S[18], C[18], A[18], B[18], C[17]);
  adder1bit adder1bit19(S[19], C[19], A[19], B[19], C[18]);
  adder1bit adder1bit20(S[20], C[20], A[20], B[20], C[19]);
  adder1bit adder1bit21(S[21], C[21], A[21], B[21], C[20]);
  adder1bit adder1bit22(S[22], C[22], A[22], B[22], C[21]);
  adder1bit adder1bit23(S[23], C[23], A[23], B[23], C[22]);
  adder1bit adder1bit24(S[24], C[24], A[24], B[24], C[23]);
  adder1bit adder1bit25(S[25], C[25], A[25], B[25], C[24]);
  adder1bit adder1bit26(S[26], C[26], A[26], B[26], C[25]);
  adder1bit adder1bit27(S[27], C[27], A[27], B[27], C[26]);
  adder1bit adder1bit28(S[28], C[28], A[28], B[28], C[27]);
  adder1bit adder1bit29(S[29], C[29], A[29], B[29], C[28]);
  adder1bit adder1bit30(S[30], C[30], A[30], B[30], C[29]);
  adder1bit adder1bit31(S[31], C[31], A[31], B[31], C[30]);
endmodule
