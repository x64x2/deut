module	inc_pc (
					PC_I,
					PC_O
				);

input	[31:0]	PC_I;
output	[31:0]	PC_O;

wire	[31:0]	PC_O;
assign	PC_O[31:0] = PC_I[31:0] + 3'b 100;

endmodule
