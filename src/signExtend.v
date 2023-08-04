`timescale 1 ps / 100 fs

////////////////////////////////////////////////// Sign-Extension  for 14 bit
module sign_extend14(sOut32, sIn14);
    output [31:0] sOut32;
    input [13:0] sIn14;
    assign sOut32 = {{18{sIn14[13]}}, sIn14};
endmodule

////////////////////////////////////////////////// Sign-Extension  for 24 bit
module sign_extend24(sOut32, sIn24);
    output [31:0] sOut32;
    input [23:0] sIn24;
    assign sOut32 = {{8{sIn24[23]}}, sIn24};
endmodule