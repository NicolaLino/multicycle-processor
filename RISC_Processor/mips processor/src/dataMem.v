`timescale 1 ps / 100 fs

module dataMem(data, address, dataIn, memWrite, memRead, clk);
  input [31:0] address, dataIn;
  input memWrite, memRead, clk;
  output [31:0] data;
  
  reg [7:0] datamem[1023:0];  // 	   Memory Size = 8192 bits or 1 kilobyte (KB)
  reg [31:0] temp;
  
  buf #1000 buf0(data[0], temp[0]),
             buf1(data[1], temp[1]),
             buf2(data[2], temp[2]),
             buf3(data[3], temp[3]),
             buf4(data[4], temp[4]),
             buf5(data[5], temp[5]),
             buf6(data[6], temp[6]),
             buf7(data[7], temp[7]),
             buf8(data[8], temp[8]),
             buf9(data[9], temp[9]),
             buf10(data[10], temp[10]),
             buf11(data[11], temp[11]),
             buf12(data[12], temp[12]),
             buf13(data[13], temp[13]),
             buf14(data[14], temp[14]),
             buf15(data[15], temp[15]),
             buf16(data[16], temp[16]),
             buf17(data[17], temp[17]),
             buf18(data[18], temp[18]),
             buf19(data[19], temp[19]),
             buf20(data[20], temp[20]),
             buf21(data[21], temp[21]),
             buf22(data[22], temp[22]),
             buf23(data[23], temp[23]),
             buf24(data[24], temp[24]),
             buf25(data[25], temp[25]),
             buf26(data[26], temp[26]),
             buf27(data[27], temp[27]),
             buf28(data[28], temp[28]),
             buf29(data[29], temp[29]),
             buf30(data[30], temp[30]),
             buf31(data[31], temp[31]);
  		 
  // write (Store)
  always @(posedge clk)
  begin
    if (memWrite)
    begin
      datamem[address] = dataIn[31:24];
      datamem[address + 1] = dataIn[23:16];
      datamem[address + 2] = dataIn[15:8];
      datamem[address + 3] = dataIn[7:0];
    end
  end
  // read  (Load)
  always @(address or datamem[address] or datamem[address + 1] or datamem[address + 2] or datamem[address + 3])
  begin
    temp = {datamem[address], datamem[address + 1], datamem[address + 2], datamem[address + 3]};
  end
  
//  initial
//  begin
//  	$readmemb("instructions.txt" datamem);
//  end
endmodule

////////////////////////////////////////////////// test
module dataMem_tb;
  reg [31:0] address;
  reg [31:0] dataIn;
  reg memWrite;
  reg memRead;
  reg clk;
  
  wire [31:0] data;
  
  dataMem dut(
    .data(data),
    .address(address),
    .dataIn(dataIn),
    .memWrite(memWrite),
    .memRead(memRead),
    .clk(clk)
  );
  
  initial begin
    // Initialize inputs
    address = 8;
    dataIn = 32'hAABBCCDD;
    memWrite = 1;
    memRead = 0;
    clk = 0;
    
    // Apply write stimulus
    #1000 memWrite = 0;
    
    // Apply read stimulus
    #1000 memWrite = 0;
    memRead = 1;
    
    // Wait for a few clock cycles
    #2000;
    
    // Finish simulation
    $finish;
  end
  
  always begin
    // Toggle the clock every 5 time units
    #100 clk = ~clk;
  end
  
  always @(posedge clk) begin
    // Print write operation information
    if (memWrite) begin
      $display("Write: address=%b, dataIn=%h", address, dataIn);
    end
    
    // Print read operation information
    if (memRead) begin
      $display("Read: address=%b, data=%h", address, data);
    end
  end
endmodule

