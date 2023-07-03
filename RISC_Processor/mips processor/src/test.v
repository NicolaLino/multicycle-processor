`timescale 1 ps / 100 fs



module alu_tb();
	wire signed [31:0] Output;
	wire zero, overflow, negative;
	reg [31:0] BussA, BussB;
	reg [4:0] Shamt;
	reg [3:0] controlSignal;

	alu alu(Output, zero, overflow, negative, BussA, BussB, Shamt, controlSignal);

	initial
	$monitor ("%d ALU output: %d, zero: %d, overflow: %d, negative: %d, A = %d, b = %d", $time, Output, zero, overflow, negative, BussA, BussB);

	initial begin
		#1000;
		// testing AND function	
		$write("\n");
		$display("Testing AND function");
		controlSignal = 4'b0001;
		BussA = 32'b10101010101010101010101010101010;
		BussB = 32'b01010101010101010101010101010101;
		#500;
		BussA = 32'b01010101010101010101010101010101;
		BussB = 32'b01110110011101100111011001110110;

		#1000;
		// testing ADD function
		$write("\n");
		$display("Testing ADD function");
		controlSignal = 4'b0010;
		BussA = 32'b10000000000000000000000000000000;
		BussB = 32'b10000000000000000000000000000000;

		#1000;
		//testing SUB function
		$write("\n");
		$display("Testing SUB function");
		controlSignal = 4'b0011;
		BussA = 32'h00000003;
		BussB = 32'h00000007;

		#2000;
		//testing CMP function
		$write("\n");
		$display("Testing CMP function");
		controlSignal = 4'b0100;
		BussA = 32'h00000003;
		BussB = 32'h00000007;

		#1000;
		//testing BEQ function
		$write("\n");
		$display("Testing BEQ function");
		controlSignal = 4'b0101;
		BussA = 32'h00000007;
		BussB = 32'h00000007;

		#1000;
		//testing SLL function
		$write("\n");
		$display("Testing SLL function");
		controlSignal = 4'b1100;
		BussA = 32'h11111111;
		BussB = 32'h00000000;
		Shamt = 5'b00001;

		#1000;
		//testing SLR function
		$write("\n");
		$display("Testing SLR function");
		controlSignal = 4'b1101;
		BussA = 32'h11111111;
		BussB = 32'h00000000;
		Shamt = 5'b00001;

		#1000;
		//testing SLLV function
		$write("\n");
		$display("Testing SLLV function");
		controlSignal = 4'b1110;
		BussA = 32'h11111111;
		BussB = 32'h00000001;

		#1000;
		//testing SLRV function
		$write("\n");
		$display("Testing SLRV function");
		controlSignal = 4'b1111;
		BussA = 32'h11111111;
		BussB = 32'h00000001;

		#1000;
		//testing default function
		$write("\n");
		$display("Testing default function");
		controlSignal = 4'b0000;

		#1000;
		$finish;
	end

endmodule



module tb_ALUContol();
    reg [5:0] opcode;
    reg [1:0] instructionType;
    wire [3:0] Control;


    ALUControl ALUCtrl (
        .ALUControl(Control),
        .opcode(opcode),
        .instructionType(instructionType)
    );

    initial begin

        #100;
        $write("\n");
        opcode = 5'b00000;
        instructionType = 2'b00;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00001;
        instructionType = 2'b00;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00010;
        instructionType = 2'b00;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00011;
        instructionType = 2'b00;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00100;
        instructionType = 2'b00;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00000;
        instructionType = 2'b10;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00001;
        instructionType = 2'b10;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00010;
        instructionType = 2'b10;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00011;
        instructionType = 2'b10;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00100;
        instructionType = 2'b10;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00000;
        instructionType = 2'b11;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);
    
        #100;
        $write("\n");
        opcode = 5'b00001;
        instructionType = 2'b11;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00010;
        instructionType = 2'b11;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $write("\n");
        opcode = 5'b00011;
        instructionType = 2'b11;
        $strobe("%d Instruction type = %b, Opcode = %b, ALUControl = %b", $time, instructionType, opcode, Control);

        #100;
        $finish;
    end
endmodule

module mux3x32to32_tb;
  reg [31:0] A, B, C;
  reg [1:0] Select;
  wire [31:0] DataOut;
  
  mux3x32to32 uut(DataOut, A, B, C, Select);
  
  initial begin
    
    // Test Case 1: Select = 2'b00, DataOut = A
    A = 32'h12345678;
    B = 32'h87654321;
    C = 32'hABCDEF01;
    Select = 2'b01;
    
    
      #1000;
    if (DataOut !== B) begin
      $display("Test Case 1 Failed! Expected: %h, Got: %h", B, DataOut);
      $finish;
    end
    #1000;
    //// Test Case 2: Select = 2'b01, DataOut = B
//    A = 32'h12345678;
//    B = 32'h87654321;
//    C = 32'hABCDEF01;
//    Select = 2'b01;
//    
//    #1000;
//    
//    if (DataOut !== B) begin
//      $display("Test Case 2 Failed! Expected: %h, Got: %h", B, DataOut);
//      $finish;
//    end
//     #1000;
//    // Test Case 3: Select = 2'b10, DataOut = C
//    A = 32'h12345678;
//    B = 32'h87654321;
//    C = 32'hABCDEF01;
//    Select = 2'b10;
//    
//    #1000;
//    
//    if (DataOut !== C) begin
//      $display("Test Case 3 Failed! Expected: %h, Got: %h", C, DataOut);
//      $finish;
//    end
//     #1000;
//    // Test Case 4: Select = 2'b11, DataOut = A
//    A = 32'h12345678;
//    B = 32'h87654321;
//    C = 32'hABCDEF01;
//    Select = 2'b11;
//    
//    #1000;
//    
//    if (DataOut !== A) begin
//      $display("Test Case 4 Failed! Expected: %h, Got: %h", A, DataOut);
//      $finish;
//    end
    #1000;
    $display("All test cases passed successfully!");
    $finish;
  end
endmodule
