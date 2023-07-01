`timescale 1 ps / 100 fs


module alu_tb;
																																																				 
  // Inputs
  reg [31:0] BussA;
  reg [31:0] BussB;
  reg [1:0] InstructionType;
  reg [4:0] Function;
  
  // Outputs
  wire CarryOut;
  wire zero;
  wire overflow;
  wire negative;
  wire [31:0] Output;
  
  // Instantiate the ALU module
  alu dut(
    .Output(Output),
    .CarryOut(CarryOut),
    .zero(zero),
    .overflow(overflow),
    .negative(negative),
    .BussA(BussA),																																		  																									 
    .BussB(BussB),
    .InstructionType(InstructionType),
    .Function(Function)
  );
  
  // Testbench logic
  initial begin
    // Initialize inputs
    BussA = 32'h00000003;
    BussB = 32'h00000001;
    InstructionType = 2'b10; 
    Function = 5'b00010; 
    
	#10000;
    // Display inputs
    $display("========================");
    $display("=== Inputs ===");
    $display("BussA: %h", BussA);
    $display("BussB: %h", BussB);
    $display("InstructionType: %b", InstructionType);
    $display("Function: %b", Function);
    $display("========================");
    
    // Evaluate outputs
    #10000;
    
    // Display outputs
    $display("========================");
    $display("=== Outputs ===");
    $display("Output: %h", Output);
    $display("CarryOut: %b", CarryOut);
    $display("Zero: %b", zero);
    $display("Overflow: %b", overflow);
    $display("Negative: %b", negative);
    $display("========================");
  end
  
endmodule

