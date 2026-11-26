module MOD_CLK(	CLK_I,
				nRST_I,
				CLK_O
			);
input	CLK_I;
input	nRST_I;
output	CLK_O;
wire	CLK_O;
reg		[1:0]	counter;
always @(posedge CLK_I or negedge nRST_I)
begin
	if(~nRST_I)
	begin
		counter[1:0]	<= 2'b 00;
	end
	else
	begin
		counter[1:0]	<= counter[1:0] + 1'b1;
	end
end

assign CLK_O = counter[1];

endmodule
