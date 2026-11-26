module IMEM_CTRL(	Q_O,		
					A_I		
				);
output	[31:0]	Q_O;
input	[31:0]	A_I;
wire	[31:0]	Q_O;

wire	[31:0]	IMEM_Q;
wire	[31:0]	IMEM_ADDR;
assign	Q_O[31:0]		= IMEM_Q[31:0];
assign	IMEM_ADDR[31:0]	= A_I[31:0];

IMEM	imem_inst(	.Q_O(IMEM_Q[31:0]),
					.A_I(IMEM_ADDR[8:2])	
				);
					
endmodule
