module	ID_EX	(
	 				CLK_I,
					nRst_I,
					Clr_I,
					Stall_I,	
					PC_I,		PC_O,
					offset_I,	offset_O,
					ALU1_I,			ALU1_O,
					ALU2_I,			ALU2_O,
					ST_DATA_I,		ST_DATA_O,
					Inst_OP_I,		Inst_OP_O,
					Inst_Rd_I,		Inst_Rd_O,
					ALU_OP_I,		ALU_OP_O,
					regWR_EN_I,		regWR_EN_O,
					STPC_MUX_I,		STPC_MUX_O,
					PCMUX_SIG_I,	PCMUX_SIG_O,
					WB_MUX_I,		WB_MUX_O,
					DMWR_EN_I,		DMWR_EN_O,
					Sht_I,			Sht_O,
					Shamt_I,		Shamt_O,
					DM_CE_I,		DM_CE_O,
					ALU1_MUX_I,		ALU1_MUX_O,
					ALU2_MUX_I,		ALU2_MUX_O,
					ST_MUX_I,		ST_MUX_O,
					JR_MUX_I,		JR_MUX_O,
									Sht_EN_O
				
				);

input			CLK_I;
input			nRst_I;
input			Clr_I;
input			Stall_I;
input	[31:0]	PC_I;
input	[31:0]	Offset_I;
input	[31:0]	ALU1_I;
input	[31:0]	ALU2_I;
input	[31:0]	ST_DATA_I;
input	[6:0]	Inst_OP_I;
input	[3:0]	Inst_Rd_I;
input	[3:0]	ALU_OP_I;
input			RegWR_EN_I;
input			STPC_MUX_I;
input	[2:0]	PCMUX_SIG_I;
input			WB_MUX_I;
input			DMWR_EN_I;
input	[1:0]		Sht_I;
input	[4:0]		Shamt_I;
input			DM_CE_I;
input	[2:0]	ALU1_MUX_I;
input	[2:0]	ALU2_MUX_I;
input	[2:0]	ST_MUX_I;
input			JR_MUX_I;

output	[31:0]	PC_O;
output	[31:0]	Offset_O;
output	[31:0]	ALU1_O;
output	[31:0]	ALU2_O;
output	[31:0]	ST_DATA_O;
output	[6:0]	Inst_OP_O;
output	[3:0]	Inst_Rd_O;
output	[3:0]	ALU_OP_O;
output			RegWR_EN_O;
output			STPC_MUX_O;
output	[2:0]	PCMUX_SIG_O;
output			WB_MUX_O;
output			DMWR_EN_O;
output	[1:0]		Sht_O;
output	[4:0]		Shamt_O;
output			DM_CE_O;
output	[2:0]	ALU1_MUX_O;
output	[2:0]	ALU2_MUX_O;
output	[2:0]	ST_MUX_O;
output			JR_MUX_O;
output			Sht_EN_O;

reg	[31:0]	PC_O;
reg	[31:0]	Offset_O;
reg	[31:0]	ALU1_O;
reg	[31:0]	ALU2_O;
reg	[31:0]	ST_DATA_O;
reg	[6:0]	Inst_OP_O;
reg	[3:0]	Inst_Rd_O;
reg	[3:0]	ALU_OP_O;
reg			RegWR_EN_O;
reg			STPC_MUX_O;
reg	[2:0]	PCMUX_SIG_O;
reg			WB_MUX_O;
reg			DMWR_EN_O;
reg	[1:0]		Sht_O;
reg	[4:0]		Shamt_O;
reg			DM_CE_O;
reg	[2:0]	ALU1_MUX_O;
reg	[2:0]	ALU2_MUX_O;
reg	[2:0]	ST_MUX_O;
reg			JR_MUX_O;
reg			Sht_EN_O;

always@(negedge nRst_I or posedge CLK_I)
begin
	 if(~nRst_I)
	 begin
		  PC_O[31:0]	<= 32'b 0;
		  Offset_O[31:0]	<= 32'b 0;
		  ALU1_O[31:0]		<= 32'b 0;
		  ALU2_O[31:0]		<= 32'b 0;
		  ST_DATA_O[31:0]	<= 32'b 0;
		  Inst_OP_O[6:0]	<= 7'b 0;
		  Inst_Rd_O[3:0]	<= 4'b 0;
		  ALU_OP_O[3:0]		<= 4'b 0;
		  RegWR_EN_O		<= 1'b 0;
		  STPC_MUX_O		<= 1'b 0;
		  PCMUX_SIG_O[2:0]	<= 3'b 0;
		  WB_MUX_O			<= 1'b 0;
		  DMWR_EN_O			<= 1'b 0;
		  ALU1_MUX_O[2:0]	<= 3'b 0;
		  ALU2_MUX_O[2:0]	<= 3'b 0;
		  ST_MUX_O[2:0]		<= 3'b 0;
		  JR_MUX_O			<= 1'b 0;
		  Sht_EN_O			<= 1'b 0;
		  Sht_O[1:0]		<= 2'b 0;
		  Shamt_O[4:0]		<= 5'b 0;
		  DM_CE_O			<= 1'b 0;
	 end
	 else if(Stall_I)
	 begin
		  PC_O[31:0]	<= PC_O[31:0];
		  Offset_O[31:0]	<= Br_offset_O[31:0];
		  ALU1_O[31:0]		<= ALU1_I[31:0];
		  ALU2_O[31:0]		<= ALU2_I[31:0];
		  ST_DATA_O[31:0]	<= ST_DATA_I[31:0];
		  Inst_OP_O[6:0]	<= Inst_OP_O[6:0];
		  Inst_Rd_O[3:0]	<= Inst_Rd_O[3:0];
		  ALU_OP_O[3:0]		<= ALU_OP_O[3:0];
		  RegWR_EN_O		<= regWR_EN_O;
		  STPC_MUX_O		<= STPC_MUX_O;
		  PCMUX_SIG_O[2:0]	<= PCMUX_SIG_O[2:0];
		  WB_MUX_O			<= WB_MUX_O;
		  DMWR_EN_O			<= DMWR_EN_O;
		  ALU1_MUX_O[2:0]	<= ALU1_MUX_O[2:0];
		  ALU2_MUX_O[2:0]	<= ALU2_MUX_O[2:0];
		  ST_MUX_O[2:0]		<= ST_MUX_O[2:0];
		  JR_MUX_O			<= JR_MUX_O;
		  Sht_EN_O			<= Sht_EN_O;
		  Sht_O[1:0]		<= Sht_O[1:0];
		  Shamt_O[4:0]		<= Shamt_O[4:0];
		  DM_CE_O			<= DM_CE_O;
	 end
	 else if(Clr_I)
	 begin
		  PC_O[31:0]	<= 32'b 0;
		  Offset_O[31:0]	<= 32'b 0;
		  ALU1_O[31:0]		<= 32'b 0;
		  ALU2_O[31:0]		<= 32'b 0;
		  ST_DATA_O[31:0]	<= 32'b 0;
		  Inst_OP_O[6:0]	<= 7'b 0;
		  Inst_Rd_O[3:0]	<= 4'b 0;
		  ALU_OP_O[3:0]		<= 4'b 0;
		  RegWR_EN_O		<= 1'b 0;
		  STPC_MUX_O		<= 1'b 0;
		  PCMUX_SIG_O[2:0]	<= 3'b 0;
		  WB_MUX_O			<= 1'b 0;
		  DMWR_EN_O			<= 1'b 0;
		  ALU1_MUX_O[2:0]	<= 3'b 0;
		  ALU2_MUX_O[2:0]	<= 3'b 0;
		  ST_MUX_O[2:0]		<= 3'b 0;
		  JR_MUX_O			<= 1'b 0;
		  Sht_EN_O			<= 1'b 0;
		  Sht_O[1:0]		<= 2'b 0;
		  Shamt_O[4:0]		<= 5'b 0;
		  DM_CE_O			<= 1'b 0;
	 end
	 else
	 begin
		  PC_O[31:0]	<= PC_I[31:0];
		  Offset_O[31:0]	<= Br_offset_I[31:0];
		  ALU1_O[31:0]		<= ALU1_I[31:0];
		  ALU2_O[31:0]		<= ALU2_I[31:0];
		  ST_DATA_O[31:0]	<= ST_DATA_I[31:0];
		  Inst_OP_O[6:0]	<= Inst_OP_I[6:0];
		  Inst_Rd_O[3:0]	<= Inst_Rd_I[3:0];
		  ALU_OP_O[3:0]		<= ALU_OP_I[3:0];
		  RegWR_EN_O		<= regWR_EN_I;
		  STPC_MUX_O		<= STPC_MUX_I;
		  PCMUX_SIG_O[2:0]	<= PCMUX_SIG_I[2:0];
		  WB_MUX_O			<= WB_MUX_I;
		  DMWR_EN_O			<= DMWR_EN_I;
		  ALU1_MUX_O[2:0]	<= ALU1_MUX_I[2:0];
		  ALU2_MUX_O[2:0]	<= ALU2_MUX_I[2:0];
		  ST_MUX_O[2:0]		<= ST_MUX_I[2:0];
		  JR_MUX_O			<= JR_MUX_I;
		  Sht_EN_O			<= (~Inst_OP_O[6]) & (~Inst_OP_O[5]);
		  Sht_O[1:0]		<= Sht_I[1:0];
		  Shamt_O[4:0]		<= Shamt_I[4:0];
		  DM_CE_O			<= DM_CE_I;
	 end
end

endmodule
			
