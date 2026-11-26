module DMEM(	CLK_I,
				Q_O,		// Output Data
				A_I,		// Input Address
				D_I,		// Input Data
				WE_I		// Write Enable
			);
input			CLK_I;
output	[31:0]	Q_O;
input	[6:0]	A_I;		// 0 to 127
input	[31:0]	D_I;
input			WE_I;
reg		[31:0]	Q_O;
reg		[31:0]	mem[127:0];

always@(posedge CLK_I)
begin
	if(WE_I)
		mem[A_I[6:0]][31:0]	<= D_I[31:0];
	Q_O[31:0]	<= mem[A_I[6:0]][31:0];
end

endmodule
