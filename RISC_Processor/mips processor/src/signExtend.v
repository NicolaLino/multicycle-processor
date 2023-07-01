`timescale 1 ps / 100 fs

////////////////////////////////////////////////// Sign-Extension
module sign_extend(sOut32,sIn16);
	output [31:0] sOut32;
	input [15:0] sIn16;
	assign sOut32 = {{16{sIn16[15]}},sIn16};
endmodule