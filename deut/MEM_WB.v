module	MEM_WB	(
	 				CLK_I,
					nRst_I,
					Stall_I,
					regWR_EN_I,		regWR_EN_O,
					STPC_MUX_I,		STPC_MUX_O,
			//		PCw_I,		PCw_O,
					PC_I,		PC_O,
					WB_DATA_I,		WB_DATA_O,
					Rd_DATA_I,		Rd_DATA_O,
					WR_reg_I,		WR_reg_O
			   );

input			CLK_I;
input			nRst_I;
input			Stall_I;
input			regWR_EN_I;
input			STPC_MUX_I;
input	[31:0]	PC_I;
input	[31:0]	WB_DATA_I;
input	[31:0]	Rd_DATA_I;

input	[3:0]	WR_reg_I;

output			regWR_EN_O;
output			STPC_MUX_O;
output	[31:0]	PC_O;
output	[31:0]	WB_DATA_O;
output	[31:0]	Rd_DATA_O;
output	[3:0]	WR_reg_O;

reg		[31:0]	PC_O;
reg		[31:0]	Rd_DATA_O;


wire			regWR_EN_O;
wire			STPC_MUX_O;
wire	[31:0]	WB_DATA_O;
wire	[3:0]	WR_reg_O;

assign	regWR_EN_O = regWR_EN_I;
assign	STPC_MUX_O = STPC_MUX_I;
assign	WB_DATA_O[31:0] = WB_DATA_I[31:0];
assign	WR_reg_O[3:0] = WR_reg_I[3:0];

always@(negedge nRst_I or posedge CLK_I)
begin
	 if(~nRst_I)
	 begin
		  PC_O[31:0]	<= 16'b 0;
		  Rd_DATA_O[31:0]	<= 16'b 0;
	 end
	 else if(Stall_I)
	 begin
		  PC_O[31:0]	<= PC_O[31:0];
		  Rd_DATA_O[31:0]	<= Rd_DATA_O[31:0];
	 end
	 else
	 begin
		  PC_O[31:0]	<= PC_I[31:0];
		  Rd_DATA_O[31:0]	<= Rd_DATA_I[31:0];
	 end
end

endmodule

