module	HZD	(	op2_I,
					op1_I,
					rd2_I,
					rs1_I,
					rt1_I,
					hazard_O
				);

input	[6:0]	op2_I;
input	[6:0]	op1_I;
input	[3:0]	rd2_I;
input	[3:0]	rs1_I;
input	[3:0]	rt1_I;

output		hazard_O;

reg		hazard1;
reg		hazard2;

assign	hazard_O = hazard1 | hazard2;
always@(op2_I[6:0] or op1_I[6:0] or rd2_I[3:0] or rs1_I[3:0] or rt1_I[3:0])
begin
	if((op2_I[5:1] == 5'b 11000) && ((!op1_I[6]) || (op1_I[5:2] != 4'b 1101)))	
	begin
		if(rd2_I[3:0] == rs1_I[3:0])	
			hazard1 <= 1'b 1;
		else
			hazard1 <= 1'b 0;
		if((!op1_I[6] | op1_I[4]) && (rd2_I[3:0] == rt1_I[3:0]))	
			hazard2 <= 1'b 1;
		else
			hazard2 <= 1'b 0;
	end
	else
	begin
		hazard1 <= 1'b 0;
		hazard2 <= 1'b 0;
	end
end

endmodule


					
