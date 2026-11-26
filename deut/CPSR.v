module CPSR(	CLK_I,
				nRst_I,
				CPSR_I,
				CPSR_O
				);

input			CLK_I;	
input			nRst_I;			
input	[31:0]	CPSR_I;

output	[31:0]	CPSR_O;

reg		[31:0]	CPSR_O;

always@(posedge CLK_I or negedge nRst_I)
begin
	if(!nRst_I)
		CPSR_O[31:0] <= 32'b 0;
	else
		CPSR_O[31:0] <= CPSR_I[31:0];
end

endmodule
				