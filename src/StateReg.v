`timescale 1 ps / 100 fs	  


module StateReg(
    output reg [2:0] Present_State,
    input [2:0] Next_State,
    input wire reset,
    input wire clk
	);

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            Present_State <= 3'b000;
        else
            Present_State <= Next_State;
    end
endmodule
