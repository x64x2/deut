`include "deutd.v"

module	deut	(
	CLOCK_I,
	nRST_I,
	IMEM_ADDR_O,
	IMEM_DATA_I,
	DMEM_ADDR_O,
	DMEM_DATA_O,
	DMEM_DATA_I,
	DMEM_WR_EN
	);
input		CLOCK_I;
input		nRST_I;

output	[15:0]	IMEM_ADDR_O;
input	[15:0]	IMEM_DATA_I;
output	[15:0]	DMEM_ADDR_O;
output	[15:0]	DMEM_DATA_O;
input	[15:0]	DMEM_DATA_I;
output			DMEM_WR_EN;
wire	[15:0]	IMEM_ADDR_O;
wire	[15:0]	DMEM_ADDR_O;
wire	[15:0]	DMEM_DATA_O;
wire			DMEM_WR_EN;

wire		WSS_I;
assign	WSS_I = 1'b 0;
wire	[2:0]	ctrlPC_MUX_SIG_ID;
wire			ctrlSTPC_MUX_ID;
wire			ctrlREGWR_ID;
wire	[1:0]	ctrlEXTEND_ID;
wire			ctrlALU_MUX_ID;
wire	[3:0]	ctrlALUOP_ID;
wire			ctrlJR_MUX_ID;
wire			ctrlDMWR_ID;
wire			ctrlWB_MUX_ID;

wire	[2:0]	ctrlPC_MUX_SIG_EX;
wire			ctrlPC_MUX_EX;
wire			ctrlSTPC_MUX_EX;
wire			ctrlREGWR_EX;
wire	[3:0]	ctrlALUOP_EX;
wire			ctrlJR_MUX_EX;
wire			ctrlDMWR_EX;
wire			ctrlWB_MUX_EX;

wire			ctrlSTPC_MUX_MEM;
wire			ctrlREGWR_MEM;
wire			ctrlDMWR_MEM;
wire			ctrlWB_MUX_MEM;
wire			ctrlSTPC_MUX_WB;
wire			ctrlREGWR_WB;

reg		[15:0]	PC;
reg		[15:0]	CPSR;

wire	[15:0]	PC_MUX_O;
wire	[15:0]	nextPC_IF;
wire	[15:0]	branchPC;
wire	[15:0]	ADDR_JUMP;
wire	[15:0]	CPSR_WIRE;
wire		IF_STALL;
assign	CPSR_WIRE[12:0]	= 13'h 0000;
assign	IF_STALL = WSS_I | LD_hazard;
always @(posedge CLOCK_I or negedge nRST_I)
begin
	if(~nRST_I)
	begin
		PC[15:0]	<= 16'h 0000;
		CPSR[15:0]	<= 16'h 0000;
	end
	else if(IF_STALL)
	begin
		PC[15:0]	<= PC[15:0];
		CPSR[15:0]	<= CPSR[15:0];
	end
	else
	begin
		PC[15:0]	<=	PC_MUX_O[15:0];
		CPSR[15:0]	<=	CPSR_WIRE[15:0];
	end
end
assign	IMEM_ADDR_O[15:0] = PC[15:0];

MUX16	pc_mux_inst(	.OUT_O(PC_MUX_O[15:0]),
	 					.IN1_I(nextPC_IF[15:0]),
						.IN2_I(branchPC[15:0]),
						.CTRL_I(ctrlPC_MUX_EX)
				   );

inc_pc	inc_pc_inst(	.nRST_I(nRST_I),
						.PC_I(PC[15:0]),
				   		.PC_O(nextPC_IF[15:0])
				   );

wire	[2:0]	REG_READ1_IF;
wire	[2:0]	REG_READ2_IF;

MUX3	reg1_inst(		.OUT_O(REG_READ1_IF[2:0]),
	 					.IN1_I(IMEM_DATA_I[7:5]),
						.IN2_I(IMEM_DATA_I[10:8]),
						.CTRL_I(IMEM_DATA_I[14])
				   );
	
MUX3	reg2_inst(		.OUT_O(REG_READ2_IF[2:0]),
						.IN1_I(IMEM_DATA_I[4:2]),
				   		.IN2_I(IMEM_DATA_I[10:8]),
						.CTRL_I(IMEM_DATA_I[15])
				   );		
				   
wire	[15:0]	nextPC_ID;				   
wire	[15:0]	Inst_ID;
wire	[2:0]	REG_READ1_ID;
wire	[2:0]	REG_READ2_ID;

IF_ID	IF_ID_inst(		.CLK_I(CLOCK_I),
	 					.nRst_I(nRST_I),
						.Clr_I(ctrlPC_MUX_EX),
						.Stall_I(IF_STALL),
						.PC_I(nextPC_IF[15:0]),
						.Inst_I(IMEM_DATA_I[15:0]),
						.reg1_I(REG_READ1_IF[2:0]),
						.reg2_I(REG_READ2_IF[2:0]),
						.PC_O(nextPC_ID[15:0]),
						.Inst_O(Inst_ID[15:0]),
						.reg1_O(REG_READ1_ID[2:0]),
						.reg2_O(REG_READ2_ID[2:0])
				   );

wire	[15:0]	IMMEDIATE;


CONTROL	control_inst	(
				.OP_I(Inst_ID[15:11]),
				.FUNCTION_I(Inst_ID[1:0]),
				.ctrl_ALUOP_O(ctrlALUOP_ID[3:0]),
				.ctrl_DMWR_EN_O(ctrlDMWR_ID),
				.ctrl_WB_MUX_O(ctrlWB_MUX_ID),
				.ctrl_JR_MUX_O(ctrlJR_MUX_ID),
				.ctrl_ALU_MUX_O(ctrlALU_MUX_ID),
				.ctrl_regWR_EN_O(ctrlREGWR_ID),
				.ctrl_PCMUX_SIG_O(ctrlPC_MUX_SIG_ID[2:0]),
				.ctrl_STPC_MUX_O(ctrlSTPC_MUX_ID),
				.ctrl_EXTEND_O(ctrlEXTEND_ID[1:0])
		   );

hazard_detection detection_inst		(
						.op2_I(OP_EX[4:0]),
						.op1_I(Inst_ID[15:11]),
						.rd2_I(Rd_EX[2:0]),
						.rs1_I(REG_READ1_ID[2:0]),
						.rt1_I(REG_READ2_ID[2:0]),
						.hazard_O(LD_hazard)
					);
						

wire	[15:0]	REG_WRITE_D;
MUX16			stpc_mux_inst(	.OUT_O(REG_WRITE_D[15:0]),
	 							.IN1_I(WB_DATA_WB[15:0]),
								.IN2_I(nextPC_MEM[15:0]),
								.CTRL_I(ctrlSTPC_MUX_WB)
						   );

wire	[15:0]	REG_D1;
wire	[15:0]	REG_D2;
REGISTER_FILE	regfile_inst(	.CLK_I(CLOCK_I),
	 							.READ1_I(REG_READ1_ID[2:0]),
								.READ2_I(REG_READ2_ID[2:0]),
								.WRITE_I(WR_reg_WB[2:0]),
								.REGWR_EN_I(ctrlREGWR_WB),
								.READD1_O(REG_D1[15:0]),
								.READD2_O(REG_D2[15:0]),
								.WRITED_I(REG_WRITE_D[15:0])
						   );

extender	extender_inst(	.extend_I(Inst_ID[11:0]),
							.control_I(ctrlEXTEND_ID[1:0]),
					   		.extend_O(IMMEDIATE[15:0])
					   );

wire	[15:0]	ALU2_ID;
MUX16	alu_mux_inst(	.OUT_O(ALU2_ID[15:0]),
	 					.IN1_I(REG_D2[15:0]),
						.IN2_I(IMMEDIATE[15:0]),
						.CTRL_I(ctrlALU_MUX_ID)
				   );
				   
wire	[15:0]	ALU1_EX;
wire	[15:0]	ALU2_EX;
				   
wire	[15:0]	nextPC_EX;	
wire	[15:0]	Br_offset_EX;
wire	[15:0]	ALU1_1_EX;
wire	[15:0]	ALU2_1_EX;
wire	[15:0]	ST_DATA1_EX;
wire	[4:0]	OP_EX;
wire	[2:0]	Rd_EX;
wire	[2:0]	Rs_EX;
wire	[2:0]	Rt_EX;

ID_EX	id_ex_inst(		.CLK_I(CLOCK_I),
	 					.nRst_I(nRST_I),
						.Clr_I(ctrlPC_MUX_EX | LD_hazard),
						.Stall_I(WSS_I),
						.PC_I(nextPC_ID[15:0]),
						.Br_offset_I(IMMEDIATE[15:0]),
						.ALU1_I(REG_D1[15:0]),
						.ALU2_I(ALU2_ID[15:0]),
						.ST_DATA_I(REG_D2[15:0]),
						.Inst_OP_I(Inst_ID[15:11]),
						.Inst_Rd_I(Inst_ID[10:8]),
						.Inst_Rs_I(REG_READ1_ID[2:0]),
						.Inst_Rt_I(REG_READ2_ID[2:0]),
						.ALU_OP_I(ctrlALUOP_ID[3:0]),
						.regWR_EN_I(ctrlREGWR_ID),
						.STPC_MUX_I(ctrlSTPC_MUX_ID),
						.PCMUX_SIG_I(ctrlPC_MUX_SIG_ID[2:0]),
						.WB_MUX_I(ctrlWB_MUX_ID),
						.DMWR_EN_I(ctrlDMWR_ID),
						.PC_O(nextPC_EX[15:0]),
						.Br_offset_O(Br_offset_EX[15:0]),
						.ALU1_O(ALU1_1_EX[15:0]),
						.ALU2_O(ALU2_1_EX[15:0]),
						.ST_DATA_O(ST_DATA1_EX[15:0]),
						.Inst_OP_O(OP_EX[4:0]),
						.Inst_Rd_O(Rd_EX[2:0]),
						.Inst_Rs_O(Rs_EX[2:0]),
						.Inst_Rt_O(Rt_EX[2:0]),
						.ALU_OP_O(ctrlALUOP_EX[3:0]),
						.regWR_EN_O(ctrlREGWR_EX),
						.STPC_MUX_O(ctrlSTPC_MUX_EX),
						.PCMUX_SIG_O(ctrlPC_MUX_SIG_EX[2:0]),
						.WB_MUX_O(ctrlWB_MUX_EX),
						.DMWR_EN_O(ctrlDMWR_EX)
				   );

control_EX	control_ex_inst	(	.STPC_MUX_O(),
	 							.regWR_EN_I(),
								.PCMUX_SIG_I(ctrlPC_MUX_SIG_EX[2:0]),
								.ALU_OP_I(),
								.JR_MUX_I(),
								.DMWR_EN_I(),
								.WR_MUX_I(),
								.CPSR_I(CPSR[14:13]),
								.STPC_MUX_O(),
								.regWR_EN_O(),
								.PC_MUX_O(ctrlPC_MUX_EX),
								.ALU_OP_O(),
								.JR_MUX_O(),
								.DMWR_EN_O(),
								.WR_MUX_O()
						   );
	 
ADD_ADDR	add_addr_inst(	.nextPC_I(nextPC_EX[15:0]),
	 						.ADDR_I(Br_offset_EX[15:0]),
							.ADDR_O(ADDR_JUMP[15:0])
					   );				   

MUX16		jr_mux_inst(	.OUT_O(branchPC[15:0]),
	 						.IN1_I(ADDR_JUMP[15:0]),
							.IN2_I(ALU1_EX[15:0]),
							.CTRL_I(ctrlJR_MUX_EX)
					   );

wire	[2:0]	ALU_MUX1;
wire	[2:0]	ALU_MUX2;
wire	[2:0]	ST_MUX;
forwarding	forward_inst	(	.op3_I(OP_EX[4:0]),
								.rd3_I(Rd_EX[2:0]),
						   		.rs3_I(Rs_EX[2:0]),
								.rt3_I(Rt_EX[2:0]),
								.op4_I(OP_MEM[4:0]),
								.rd4_I(Rd_MEM[2:0]),
								.op5_I(OP_WB[4:0]),
								.rd5_I(Rd_WB[2:0]),
								.ALU_MUX1_O(ALU_MUX1[2:0]),
								.ALU_MUX2_O(ALU_MUX2[2:0]),
								.ST_MUX_O(ST_MUX[2:0])
						   );

MUX			alu1_mux_inst(	.OUT_O(ALU1_EX[15:0]),
							.IN1_I(ALU1_1_EX[15:0]),
					   		.IN2_I(ALU_result_MEM[15:0]),
							.IN3_I(Rd_DATA_WB[15:0]),
							.IN4_I(nextPC_MEM[15:0]),
							.IN5_I(nextPC_WB[15:0]),
							.CTRL_I(ALU_MUX1[2:0])
					   );

MUX			alu2_mux_inst(	.OUT_O(ALU2_EX[15:0]),
							.IN1_I(ALU2_1_EX[15:0]),
					   		.IN2_I(ALU_result_MEM[15:0]),
							.IN3_I(Rd_DATA_WB[15:0]),
							.IN4_I(nextPC_MEM[15:0]),
							.IN5_I(nextPC_WB[15:0]),
							.CTRL_I(ALU_MUX2[2:0])
					   );

wire	[15:0]	ST_DATA_EX;
MUX			st_mux_inst(	.OUT_O(ST_DATA_EX[15:0]),
							.IN1_I(ST_DATA1_EX[15:0]),
					   		.IN2_I(ALU_result_MEM[15:0]),
							.IN3_I(Rd_DATA_WB[15:0]),
							.IN4_I(nextPC_MEM[15:0]),
							.IN5_I(nextPC_WB[15:0]),
							.CTRL_I(ST_MUX[2:0])
					   );		
					   
wire	[15:0]	ALU_O;
ALU		alu_inst(	.ALUOP_I(ctrlALUOP_EX[3:0]),
	 				.ALU_I1(ALU1_EX[15:0]),
					.ALU_I2(ALU2_EX[15:0]),
					.ALU_O(ALU_O[15:0]),
					.OVERFLOW_O(CPSR_WIRE[15]),
					.NEGATIVE_O(CPSR_WIRE[14]),
					.ZERO_O(CPSR_WIRE[13])
			   );
			   
wire	[15:0]	nextPC_MEM;			
wire	[15:0]	Address_MEM;
wire	[15:0]	ST_DATA_MEM;
wire	[15:0]	ALU_result_MEM;
wire	[4:0]	OP_MEM;
wire	[2:0]	Rd_MEM;
EX_MEM	ex_mem_inst(	.CLK_I(CLOCK_I),
	 					.nRst_I(nRST_I),
						.Stall_I(WSS_I),
						.WB_MUX_I(ctrlWB_MUX_EX),
						.DMWR_EN_I(ctrlDMWR_EX),
						.regWR_EN_I(ctrlREGWR_EX),
						.STPC_MUX_I(ctrlSTPC_MUX_EX),
						.PC_I(nextPC_EX[15:0]),
						.Address_I(ALU_O[15:0]),
						.ST_DATA_I(ST_DATA_EX[15:0]),
						.ALU_result_I(ALU_O[15:0]),
						.Inst_OP_I(OP_EX[4:0]),
						.Inst_Rd_I(Rd_EX[2:0]),
						.WB_MUX_O(ctrlWB_MUX_MEM),
						.DMWR_EN_O(ctrlDMWR_MEM),
						.regWR_EN_O(ctrlREGWR_MEM),
						.STPC_MUX_O(ctrlSTPC_MUX_MEM),
						.PC_O(nextPC_MEM[15:0]),
						.Address_O(Address_MEM[15:0]),
						.ST_DATA_O(ST_DATA_MEM[15:0]),
						.ALU_result_O(ALU_result_MEM[15:0]),
						.Inst_OP_O(OP_MEM[4:0]),
						.Inst_Rd_O(Rd_MEM[2:0])
				   );
				   
wire	[15:0]	WB_DATA_MEM;			   
MUX16		wb_mux_inst(	.OUT_O(WB_DATA_MEM[15:0]),
						.IN1_I(ALU_result_MEM[15:0]),
				   		.IN2_I(DMEM_DATA_I[15:0]),
						.CTRL_I(ctrlWB_MUX_MEM)
				   );		
assign DMEM_WR_EN = ctrlDMWR_MEM;
assign DMEM_ADDR_O[15:0] = Address_MEM[15:0];
assign DMEM_DATA_O[15:0] = ST_DATA_MEM[15:0];

wire	[15:0]	nextPC_WB;
wire	[15:0]	WB_DATA_WB;
wire	[15:0]	Rd_DATA_WB;
wire	[4:0]	OP_WB;
wire	[2:0]	Rd_WB;
wire	[2:0]	WR_reg_WB;
MEM_WB		mem_wb_inst(	.CLK_I(CLOCK_I),
	 						.nRst_I(nRST_I),
							.Stall_I(WSS_I),
							.regWR_EN_I(ctrlREGWR_MEM),
							.STPC_MUX_I(ctrlSTPC_MUX_MEM),
							.PC_I(nextPC_MEM[15:0]),
							.WB_DATA_I(WB_DATA_MEM[15:0]),
							.Rd_DATA_I(WB_DATA_MEM[15:0]),
							.Inst_OP_I(OP_MEM[4:0]),
							.Inst_Rd_I(Rd_MEM[2:0]),
							.WR_reg_I(Rd_MEM[2:0]),
							.regWR_EN_O(ctrlREGWR_WB),
							.STPC_MUX_O(ctrlSTPC_MUX_WB),
							.PC_O(nextPC_WB[15:0]),
							.WB_DATA_O(WB_DATA_WB[15:0]),
							.Rd_DATA_O(Rd_DATA_WB[15:0]),
							.Inst_OP_O(OP_WB[4:0]),
							.Inst_Rd_O(Rd_WB[2:0]),
							.WR_reg_O(WR_reg_WB[2:0])
					   );

endmodule
