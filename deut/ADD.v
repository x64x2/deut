/*
 *PC Address adder ( for Jump Instruction )
 */
module ADD_ADDR (	PC_I,
					ADDR_I,
					ADDR_O
				);
input	[31:0]	PC_I;
input	[31:0]	ADDR_I;
output	[31:0]	ADDR_O;
wire	[31:0]	ADDR_O;
assign ADDR_O[31:0]	= PC_I[31:0] + {ADDR_I[29:0],2'b00};

endmodule
