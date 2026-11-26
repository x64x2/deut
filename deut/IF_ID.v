module	IF_ID	(
	 				CLK_I,
					nRst_I,
					Clr_I,
					Stall_I,
					PC_I,
					Inst_I,
					reg1_I,
					reg2_I,
					PC_O,
					Inst_O,
					reg1_O,
					reg2_O
				);

input			CLK_I;
input			nRst_I;
input			Clr_I;
input			Stall_I;
input	[31:0]	PC_I;
input	[31:0]	Inst_I;
input	[3:0]	reg1_I;
input	[3:0]	reg2_I;

output	[31:0]	PC_O;
output	[31:0]	Inst_O;
output	[3:0]	reg1_O;
output	[3:0]	reg2_O;

reg		[31:0]	PC_O;
reg		[31:0]	Inst_O;
reg		[3:0]	reg1_O;
reg		[3:0]	reg2_O;

always@(negedge nRst_I or posedge CLK_I)
begin
	 if(~nRst_I)
	 begin
		  PC_O[31:0]	<= 32'b 0;
		  Inst_O[31:0]	 	<= 32'b 0;
		  reg1_O[3:0]		<= 4'b 0;
		  reg2_O[3:0]		<= 4'b 0;
	 end
	 else if(Stall_I)
	 begin
		  PC_O[31:0]	<= PC_O[31:0];
		  Inst_O[31:0]		<= Inst_O[31:0];
  		  reg1_O[3:0]		<= reg1_O[3:0];
		  reg2_O[3:0]		<= reg2_O[3:0];
	 end
	 else if(Clr_I)
	 begin
		  PC_O[31:0]	<= 32'b 0;
		  Inst_O[31:0]	 	<= 32'b 0;
  		  reg1_O[3:0]		<= 4'b 0;
		  reg2_O[3:0]		<= 4'b 0;
	 end
	 else
	 begin
		  PC_O[31:0]	<= PC_I[31:0];
		  Inst_O[31:0]		<= Inst_I[31:0];
  		  reg1_O[3:0]		<= reg1_I[3:0];
		  reg2_O[3:0]		<= reg2_I[3:0];
	 end
end

endmodule

