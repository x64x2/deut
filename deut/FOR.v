module	FOR(
					op3_I,
	 				rs3_I,
					rt3_I,
					op4_I,
					rd4_I,
					op5_I,
					rd5_I,
					ALU_MUX1_O,
					ALU_MUX2_O,
					ST_MUX_O
			   );

input	[6:0]	op3_I;			   
input	[3:0]	rs3_I;
input	[3:0]	rt3_I;
input	[6:0]	op4_I;
input	[3:0]	rd4_I;
input	[6:0]	op5_I;
input	[3:0]	rd5_I;

output	[2:0]	ALU_MUX1_O;
output	[2:0]	ALU_MUX2_O;
output	[2:0]	ST_MUX_O;

reg		[2:0]	ALU_MUX1_O;
reg		[2:0]	ALU_MUX2_O;
reg		[2:0]	ST_MUX_O;

always@(op3_I[6:0] or rs3_I[3:0] or rt3_I[3:0] or op4_I[6:0] or rd4_I[3:0] or op5_I[6:0] or rd5_I[3:0])
begin
	 if((!op3_I[6]) || (op3_I[4:2] != 3'b 101) || (op3_I[4:1] != 4'b 1100))
	 begin
			   if(!(op4_I[6] | op4_I[4]))		
					ALU_MUX1_O <= 3'b 001;
			   else if((op4_I[6:2] == 5'b 01101) || ({op4_I[6:3],op4_I[1]} == 5'b 01111))	
					ALU_MUX1_O <= 3'b 011;
			   else
					ALU_MUX1_O <= 3'b 0;
		  end
		  else if(rd5_I[3:0] == rs3_I[3:0])
		  begin
			   if((!(op5_I[6] | op5_I[4])) || (op5_I[6:1] == 6'b 011000))	
					ALU_MUX1_O <= 3'b 010;
			   else if((op5_I[6:2] == 5'b 01101) || ({op5_I[6:3],op5_I[1]} == 5'b 01111))	
					ALU_MUX1_O <= 3'b 100;
			   else
					ALU_MUX1_O <= 3'b 0;
		  end
		  else
			   ALU_MUX1_O <= 3'b 0;
	 end
	 else
	 begin
		  ALU_MUX1_O[2:0] <= 3'b 0;
	 end
	 
	 if(!(op3_I[6] | op3_I[5]))		
	 begin
		  ST_MUX_O[2:0] <= 3'b 0;
		  begin
			   if(rd5_I[3:0] == rt3_I[3:0])
					ALU_MUX2_O <= 3'b 010;
			   else
					ALU_MUX2_O <= 3'b 0;
		  end
		  begin
			   if(!(op4_I[6] | op4_I[4]))	
					ALU_MUX2_O <= 3'b 001;
			   else if((op4_I[6:2] == 5'b 01101) || ({op4_I[6:3],op4_I[1]} == 5'b 01111))	
					ALU_MUX2_O <= 3'b 011;
			   else
					ALU_MUX2_O <= 3'b 0;
		  end
		  else if(rd5_I[3:0] == rt3_I[3:0])
		  begin
			   if((!(op5_I[6] | op5_I[4])) || (op5_I[6:1] == 6'b 011000))			
					ALU_MUX2_O <= 3'b 010;
			   else if((op5_I[6:2] == 5'b 01101) || ({op5_I[6:3],op5_I[1]} == 5'b 01111))		
					ALU_MUX2_O <= 3'b 100;
			   else
					ALU_MUX2_O <= 3'b 0;
		  end
		  else
			   ALU_MUX2_O <= 3'b 0;
	 end
	 else if(op3_I[5:1] == 5'b 11001)
	 begin
		  ALU_MUX2_O <= 3'b 0;
		  begin
			   if(rd5_I[3:0] == rt3_I[3:0])
					ST_MUX_O <= 3'b 010;
			   else
					ST_MUX_O <= 3'b 0;
		  end
		  begin
			   if(!(op4_I[6] | op4_I[4]))			
					ST_MUX_O <= 3'b 001;
			   else if((op4_I[6:2] == 5'b 01101) || ({op4_I[6:3],op4_I[1]} == 5'b 01111))	
					ST_MUX_O <= 3'b 011;
			   else
					ST_MUX_O <= 3'b 0;
		  end
		  else if(rd5_I[3:0] == rt3_I[3:0])
		  begin
			   if((!(op5_I[6] | op5_I[4])) || (op5_I[6:1] == 6'b 011000))		
					ST_MUX_O <= 3'b 010;
			   else if((op5_I[6:2] == 5'b 01101) || ({op5_I[6:3],op5_I[1]} == 5'b 01111))		
					ST_MUX_O <= 3'b 100;
			   else
					ST_MUX_O <= 3'b 0;
		  end
		  else
			   ST_MUX_O <= 3'b 0;
	 end
	 else
	 begin
		  ALU_MUX2_O <= 3'b 0;
		  ST_MUX_O <= 3'b 0;
	 end
end
endmodule

	 
  

					


