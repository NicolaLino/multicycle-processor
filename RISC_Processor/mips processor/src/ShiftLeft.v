`timescale 1 ps / 100 fs

////////////////////////////////////////////////// Shift left 2 module 
module shift_left_2(Out32, In32);
	output [31:0] Out32;
	input [31:0] In32;
	
	assign Out32 = {In32[29:0],2'b00};
endmodule


//module zero_extend(zOut32,zIn16);
//	output [31:0] zOut32;
//	input [15:0] zIn16;
//	assign zOut32 = {{16{1'b0}},zIn16};
//endmodule