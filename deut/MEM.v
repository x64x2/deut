module	EX_MEM	(
	 				CLK_I,
					nRst_I,
					Stall_I,
					WB_MUX_I,		WB_MUX_O,
					DMWR_EN_I,		DMWR_EN_O,
					regWR_EN_I,		regWR_EN_O,
					STPC_MUX_I,		STPC_MUX_O,
					PC_I,		PC_O,
					Address_I,		Address_O,
					ST_DATA_I,		ST_DATA_O,
					ALU_result_I,	ALU_result_O,
					Inst_OP_I,		Inst_OP_O,
					Inst_Rd_I,		Inst_Rd_O,
					DM_CE_I,		DM_CE_O
			   );

input			CLK_I;
input			nRst_I;
input			Stall_I;
input			WB_MUX_I;
input			DMWR_EN_I;
input			regWR_EN_I;
input			STPC_MUX_I;
input	[31:0]	PC_I;
input	[31:0]	Address_I;
input	[31:0]	ST_DATA_I;
input	[31:0]	ALU_result_I;
input	[6:0]	Inst_OP_I;
input	[3:0]	Inst_Rd_I;
input		DM_CE_I;

output			WB_MUX_O;
output			DMWR_EN_O;
output			regWR_EN_O;
output			STPC_MUX_O;
output	[31:0]	PC_O;
output	[31:0]	Address_O;
output	[31:0]	ST_DATA_O;
output	[31:0]	ALU_result_O;
output	[6:0]	Inst_OP_O;
output	[3:0]	Inst_Rd_O;
output		DM_CE_O;

reg			WB_MUX_O;
reg			regWR_EN_O;
reg			STPC_MUX_O;
reg	[31:0]	PC_O;
reg	[31:0]	ALU_result_O;
reg	[6:0]	Inst_OP_O;
reg	[3:0]	Inst_Rd_O;

wire		DMWR_EN_O;
wire		DM_CE_O;
wire	[31:0]	Address_O;
wire	[31:0]	ST_DATA_O;

assign DMWR_EN_O = DMWR_EN_I;
assign DM_CE_O = DM_CE_I;
assign Address_O[31:0] = Address_I[31:0];
assign ST_DATA_O[31:0] = ST_DATA_I[31:0];
always@(negedge nRst_I or posedge CLK_I)
begin
	 if(~nRst_I)
	 begin
		  WB_MUX_O			<= 1'b 0;
		  regWR_EN_O			<= 1'b 0;
		  STPC_MUX_O			<= 1'b 0;
		  PC_O[31:0]		<= 32'b 0;
		  ALU_result_O[31:0]		<= 32'b 0;
		  Inst_OP_O[6:0]		<= 7'b 0;
		  Inst_Rd_O[3:0]		<= 4'b 0;		  
	 end
	 else if(Stall_I)
	 begin
		  WB_MUX_O			<= WB_MUX_O;
		  regWR_EN_O			<= regWR_EN_O;
		  STPC_MUX_O			<= STPC_MUX_O;
		  PC_O[31:0]		<= PC_O[31:0];
		  ALU_result_O[31:0]		<= ALU_result_O[31:0];
		  Inst_OP_O[6:0]		<= Inst_OP_O[6:0];
		  Inst_Rd_O[3:0]		<= Inst_Rd_O[3:0];
	 end
	 else 
	 begin
		  WB_MUX_O			<= WB_MUX_I;
		  regWR_EN_O			<= regWR_EN_I;
		  STPC_MUX_O			<= STPC_MUX_I;
		  PC_O[31:0]		<= PC_I[31:0];
		  ALU_result_O[31:0]		<= ALU_result_I[31:0];
		  Inst_OP_O[6:0]		<= Inst_OP_I[6:0];
		  Inst_Rd_O[3:0]		<= Inst_Rd_I[3:0];
	 end
end

endmodule

