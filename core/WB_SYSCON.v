module WB_SYSCON(
					CLK_I,
					RST_I,
					CLK_O,
					RST_O
				);
input	CLK_I;
input	RST_I;
output	CLK_O;
output	RST_O;
assign	CLK_O	= CLK_I;
assign	RST_O	= RST_I;

endmodule
