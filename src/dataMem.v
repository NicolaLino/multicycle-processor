`timescale 1 ps / 100 fs

module dataMem(data, address, dataIn, memWrite, memRead);
    input [31:0] address, dataIn;
    input memWrite, memRead;
    output [31:0] data;

    reg [31:0] mem[0:1023];
    reg [31:0] data;


    // Read from memory
    always @(address or dataIn) begin
        if(memRead)
            data = mem[address];
        else
            data = data;
    end

    // Write to memory
    always @(posedge memWrite) begin
        mem[address] <= dataIn;
    end
    
    
endmodule

