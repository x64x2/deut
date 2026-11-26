module	ALU	(
				OP_I,
				ALU_I1,
				ALU_I2,
				ALU_O,
				OVERFLOW_O,
				NEGATIVE_O,
				ZERO_O
			);
 
input 	[3:0]	OP_I;
input	[31:0]	ALU_I1;
input	[31:0]	ALU_I2;
output	[31:0]	ALU_O;
output			OVERFLOW_O, NEGATIVE_O, ZERO_O;

reg		[31:0] 	ALU_O;
reg				OVERFLOW_O;
reg		[31:0]	Mul_result;
reg		[15:0]	Xor_Search;

wire 	[31:0]	Mul_temp;
integer			N;

mult mult(.dataa(ALU_I1), .datab(ALU_I2), .result(Mul_temp));

always@(OP_I[3:0] or ALU_I1[31:0] or ALU_I2[31:0])
begin
	case(ALUOP_I[3:0])
		4'b 0000
		begin
			ALU_O[31:0] = add_sub_result[31:0];
			ALU_O[31:0] = ALU_I1[31:0] + ALU_I2[31:0];
			OVERFLOW_O = ~(ALU_I1[31] ^ ALU_I2[31]) & (ALU_I1[31] ^ ALU_O[31]);
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 0001:	
		begin
			ALU_O[31:0] = add_sub_result[31:0];
			ALU_O[31:0] = ALU_I1[31:0] - ALU_I2[31:0];
			OVERFLOW_O = (ALU_I1[31] ^ ALU_I2[31]) & (ALU_I1[31] ^ ALU_O[31]); 
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 0010:		
		begin
			ALU_O[31:0] = 32'b 0;
			OVERFLOW_O = 1'b 0;
			Mul_result = Mul_temp;
			for(N=31; N>=16; N=N-1)
			Xor_Search[N-16] = Mul_result[N] ^ Mul_result[N-1];
			OVERFLOW_O = | Xor_Search;
			ALU_O = Mul_result[15:0];
		end
		4'b 0011:	
		begin
			ALU_O[31:0] = 32'b 0;
			OVERFLOW_O = 1'b 0;
		end
		4'b 0100:	
		begin
			ALU_O[31:0] = ALU_I1[31:0] & ALU_I2[31:0];
			OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 0101:	
		begin
			ALU_O[31:0] = ALU_I1[31:0] | ALU_I2[31:0];
			OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 0110:	
		begin
			ALU_O[31:0] = ALU_I1[31:0] ^ ALU_I2[31:0];
			OVERFLOW_O = 1'b 0;
		end
		4'b 0111:	
		begin
			ALU_O[31:0] = ~ALU_I1[31:0];
			OVERFLOW_O = 1'b 0;
		end
		4'b 1100:	
		begin
			ALU_O[31:0] = ALU_I1[31:0] << ALU_I2[31:0];
			OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 1101:		
		begin
			ALU_O[31:0] = ALU_I1[31:0] >> ALU_I2[31:0];
			OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 1110:	
		begin
			ALU_O[31:0] = ({32{ALU_I1[31]}} << (32-ALU_I2[31:0])) | (ALU_I1[31:0] >> ALU_I2[31:0]);
			OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 1111:	
		begin
			ALU_O[31:0] = {(ALU_I1[31:0]<<ALU_I2[31:0]) |  ((ALU_I1[31:0]) >> (32-ALU_I2[31:0]))};
			OVERFLOW_O = 1'b 0;
		end
		4'b 1001:		// LDC
		begin
			ALU_O[31:0]	= ALU_I2[31:0];
			OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		4'b 1000:	
		begin
			ALU_O[31:0]	= {ALU_I2[31:16],ALU_I1[15:0]};
			OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
		default:
		begin
			ALU_O[31:0]	= 32'h 0000;
	   		OVERFLOW_O = 1'b 0;
			Mul_result = 32'b 0;
			Xor_Search = 16'b 0;
		end
	endcase
end

assign NEGATIVE_O = ALU_O[31];
assign ZERO_O = ~| ALU_O[31:0];

endmodule
