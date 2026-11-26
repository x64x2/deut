module	PC	(
				CLK_I,
				nRST_I,
				Stall_I,
				PC_I,
				PC_O
			);
input			CLK_I;
input			nRST_I;
input			Stall_I;
input	[31:0]	PC_I;
output	[31:0]	PC_O;
reg		[31:0]	PC_O;

always @(posedge CLK_I or negedge nRST_I)
begin
	if(~nRST_I)
	begin
		PC_O[31:0]	<= 32'h 0000_0000;
	end
	else
	begin
		if(Stall_I)	begin
			PC_O[31:0]	<= PC_O[31:0];
		end
		else	begin
				PC_O[31:0]	<= PC_I[31:0];
		end
	end
end

endmodule
