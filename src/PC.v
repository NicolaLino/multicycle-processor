`timescale 1 ps / 100 fs

module PC (
    output reg [31:0] data_out,
    input wire [31:0] data_in,
    input wire reset,
    input wire clk
    );
    
    always @(posedge clk or posedge reset) begin
        if (reset)
        data_out <= 32'b0;
        else
        data_out <= data_in;
    end
    
endmodule

