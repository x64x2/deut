module	CTRL	(
					OP_I,
					ctrl_ALUOP_O,
					ctrl_DMCE_O,
					ctrl_DMWR_EN_O,
					ctrl_WB_MUX_O,
					ctrl_JR_MUX_O,
					ctrl_ALU_MUX_O,
					ctrl_regWR_EN_O,
					ctrl_PCMUX_SIG_O,
					ctrl_STPC_MUX_O,
					ctrl_EXTEND_O
				);

input	[7:0]	OP_I;

output	[3:0]	ctrl_ALUOP_O;
output	[1:0]	ctrl_EXTEND_O;
output	[2:0]	ctrl_PCMUX_SIG_O;
output				ctrl_DMCE_O,
				ctrl_DMWR_EN_O,
				ctrl_WB_MUX_O,
				ctrl_JR_MUX_O,
				ctrl_ALU_MUX_O,
				ctrl_regWR_EN_O,
				ctrl_STPC_MUX_O;

reg		[15:0]	ctrl;

assign	ctrl_ALUOP_O[3:0] = ctrl[13:10];
assign	ctrl_EXTEND_O[1:0] = ctrl[1:0];
assign 	ctrl_DMCE_O = ctrl[9];
assign	ctrl_DMWR_EN_O = ctrl[8];
assign	ctrl_WB_MUX_O = ctrl[7];
assign	ctrl_JR_MUX_O = ctrl[6];
assign	ctrl_ALU_MUX_O = ctrl[5];
assign 	ctrl_regWR_EN_O = ctrl[4];
assign	ctrl_PCMUX_SIG_O[2:0] = {ctrl[15:14],ctrl[3]};
assign 	ctrl_STPC_MUX_O = ctrl[2];
				
always@(OP_I[7:0])
begin
	casex(OP_I[7:0])

	8'b 0000_0000	:	// ADD
		ctrl[15:0] <= 16'b 00_0000_0x00_0100_xx;
	8'b 0000_0010	:	// SUB
		ctrl[15:0] <= 16'b 00_0001_0x00_0100_xx;
	8'b 0000_0100	:	// MUL
		ctrl[15:0] <= 16'b 00_0011_0x00_0100_xx;
	8'b 0000_1000	:	// DIV
		ctrl[15:0] <= 16'b 00_0011_0x00_0100_xx;
	8'b 0001_0000	:	// AND
		ctrl[15:0] <= 16'b 00_0100_0x00_0100_xx;
	8'b 0001_0010	:	// OR
		ctrl[15:0] <= 16'b 00_0101_0x00_0100_xx;
	8'b 0001_0100	:	// XOR
		ctrl[15:0] <= 16'b 00_0110_0x00_0100_xx;
	8'b 0001_1000	:	// NOT
		ctrl[15:0] <= 16'b 00_0111_0x00_0100_xx;
	8'b 0001_101x	:	// Shift
		ctrl[15:0] <= 16'b 00_1100_0x00_0100_xx;
	
	
	8'b 0100_0000	:	// ADDI
		ctrl[15:0] <= 16'b 00_0000_0x00_1100_00;
	8'b 0100_0010	:	// SUBI
		ctrl[15:0] <= 16'b 00_0001_0x00_1100_00;
	8'b 0100_0100	:	// MULI
		ctrl[15:0] <= 16'b 00_0010_0x00_1100_00;
	8'b 0100_0110	:	// DIVI
		ctrl[15:0] <= 16'b 00_0011_0x00_1100_00;
	8'b 0101_1010	:	// LDC
		ctrl[15:0] <= 16'b 00_1001_0x00_1100_00;
	8'b 0101_1100	:	// LUI
		ctrl[15:0] <= 16'b 00_1000_0x00_1100_11;
	8'b 0101_0000	:	// ANDI
		ctrl[15:0] <= 16'b 00_0100_0x00_1100_00;
	8'b 0101_0010	:	// ORI
		ctrl[15:0] <= 16'b 00_0101_0x00_1100_00;
	8'b 0101_0100	:	// XORI
		ctrl[15:0] <= 16'b 00_0110_0x00_1100_00;
	8'b 0101_1000	:	// NOTI
		ctrl[15:0] <= 16'b 00_0111_0x00_1100_00;
	
	8'b 0110_00xx	:	// LD
		ctrl[15:0] <= 16'b 00_0000_1010_1100_01;
	8'b 0110_01xx	:	// ST
		ctrl[15:0] <= 16'b 00_0000_11x0_1000_01;
	8'b 0110_1000	:	// STPC
		ctrl[15:0] <= 16'b 00_xxxx_0xxx_X101_xx;
	8'b 0111_1000	: 	// JR
		ctrl[15:0] <= 16'b 00_xxxx_0xx1_x010_xx;
	8'b 0111_1100	:	// JRL
		ctrl[15:0] <= 16'b 00_xxxx_0xx1_x111_xx;
	
	8'b 1000_1xxx	:	// JEQ
		ctrl[15:0] <= 16'b 01_xxxx_0xx0_x000_10;
	8'b 1001_0xxx	:	// JNE
		ctrl[15:0] <= 16'b 01_xxxx_0xx0_x010_10;
	8'b 1000_0xxx	:	// JAL
		ctrl[15:0] <= 16'b 00_xxxx_0xx0_x010_10;
	8'b 1010_0xxx	:	// JLT
		ctrl[15:0] <= 16'b 10_xxxx_0xx0_x000_10;
	default			:
		ctrl[15:0] <= 16'b 00_xxxx_0xxx_x0xx_10;
	endcase
end

endmodule




