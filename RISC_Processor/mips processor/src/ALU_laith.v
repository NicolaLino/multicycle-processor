module alu(Output, CarryOut, zero, overflow, negative, BussA, BussB, ALUControl); 
	
	localparam 	Con_AND=3'b0000,Con_OR=3'b001,Con_XOR=3'b010,Con_ADD=3'b100,Con_SUB=3'b101,Con_SLT=3'b110;
	
	// alu in put incloud  ALUControl, BussA and BussB
	input signed[31:0] BussA, BussB;
	input[2:0] ALUControl;	// 3 Bit control there is  6 main operation in alu
	
	//alu output incloud flags and real output 
	output CarryOut, zero, overflow, negative;	
	output signed[31:0]Output;
	
	
	//register declarations 
	reg signed[31:0]Output;
	reg	 CarryOut, zero, overflow, negative;
	reg	 [31:0] temp_out;
	
	wire [31:0] unBussA;
	wire [31:0] unBussB;
	
	
	assign unBussA =BussA;
	assign unBussB =BussB; 
	
	
	always@ (BussA,BussB,ALUControl)begin
		case(ALUControl)
			//AND
			Con_AND:
			begin 
				Output =	BussA & BussB;
				overflow = 1'b0;
			end
			
			//OR
			Con_OR:
			begin 
				Output =	BussA | BussB;
				overflow = 1'b0;
			end	 
			
			//XOR
			Con_XOR:
			begin 
				Output =    BussA ^ BussB;
				overflow = 1'b0;
			end	
			
			//ADD
			Con_ADD:
			begin 
				Output =	BussA + BussB;
				
				if ((BussA[31] && BussB[31]) && !Output[31]) 
					overflow = 1'b1;
				else if((!BussA[31] && !BussB[31]) && Output[31]) 
					overflow = 1'b1; 
				else 
					overflow = 1'b0;
				
			end	
			
			//SUB
			Con_SUB:
			begin
				temp_out=~BussB+1; // 2's complement of  input BussB
				Output =	BussA + temp_out;
				
				if ((BussA[31] && temp_out[31]) && !Output[31]) 
					overflow = 1'b1;
				else if((!BussA[31] && !temp_out[31]) && Output[31]) 
					overflow = 1'b1; 
				else 
					overflow = 1'b0;
				
			end	
			
			
			Con_STL:
			begin
				if (BussA < BussB) //less than :set output ones
					Output =32'b1;
				else
					Output =32'b0; 
					
				overflow = 1'b0;
			end
			
			
		endcase 
			
			
		
		
		
		
	end
			
				
			
	

endmodule