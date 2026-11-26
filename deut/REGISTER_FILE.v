module REGISTER_FILE (	CLK_I,		
						READ1_I,	
						READ2_I,
						WRITE_I,	
						REGWR_EN_I,	
						READD1_O,	
						READD2_O,	
						WRITED_I	
					);
input			CLK_I;
input	[3:0]	READ1_I;
input	[3:0]	READ2_I;
input	[3:0]	WRITE_I;
input			REGWR_EN_I;
input	[31:0]	WRITED_I;
output	[31:0]	READD1_O;
output	[31:0]	READD2_O;

reg		[31:0]	READD1_O;
reg		[31:0]	READD2_O;
reg		[31:0]	regfile[31:0];	// Register File Storage

always @(READ1_I[3:0])
begin
	case (READ1_I[3:0])
	4'b 0000:
		READD1_O[31:0]	<= 32'h 0000_0000;
	4'b 0001:
		READD1_O[31:0]	<= regfile[1][31:0];
	4'b 0010:
		READD1_O[31:0]	<= regfile[2][31:0];
	4'b 0011:
		READD1_O[31:0]	<= regfile[3][31:0];
	4'b 0100:
		READD1_O[31:0]	<= regfile[4][31:0];
	4'b 0101:
		READD1_O[31:0]	<= regfile[5][31:0];
	4'b 0110:
		READD1_O[31:0]	<= regfile[6][31:0];
	4'b 0111:
		READD1_O[31:0]	<= regfile[7][31:0];
	4'b 1000:
		READD1_O[31:0]	<= regfile[8][31:0];
	4'b 1001:
		READD1_O[31:0]	<= regfile[9][31:0];
	4'b 1010:
		READD1_O[31:0]	<= regfile[10][31:0];
	4'b 1011:
		READD1_O[31:0]	<= regfile[11][31:0];
	4'b 1100:
		READD1_O[31:0]	<= regfile[12][31:0];
	4'b 1101:
		READD1_O[31:0]	<= regfile[13][31:0];
	4'b 1110:
		READD1_O[31:0]	<= regfile[14][31:0];
	4'b 1111:
		READD1_O[31:0]	<= regfile[15][31:0];
		
	default:
		READD1_O[31:0]	<= 32'h 0000_0000;
	endcase
end

always @(READ2_I[3:0])
begin
	case (READ2_I[3:0])
	4'b 0000:
		READD2_O[31:0]	<= 32'h 0000_0000;
	4'b 0001:
		READD2_O[31:0]	<= regfile[1][31:0];
	4'b 0010:
		READD2_O[31:0]	<= regfile[2][31:0];
	4'b 0011:
		READD2_O[31:0]	<= regfile[3][31:0];
	4'b 0100:
		READD2_O[31:0]	<= regfile[4][31:0];
	4'b 0101:
		READD2_O[31:0]	<= regfile[5][31:0];
	4'b 0110:
		READD2_O[31:0]	<= regfile[6][31:0];
	4'b 0111:
		READD2_O[31:0]	<= regfile[7][31:0];
	4'b 1000:
		READD2_O[31:0]	<= regfile[8][31:0];
	4'b 1001:
		READD2_O[31:0]	<= regfile[9][31:0];
	4'b 1010:
		READD2_O[31:0]	<= regfile[10][31:0];
	4'b 1011:
		READD2_O[31:0]	<= regfile[11][31:0];
	4'b 1100:
		READD2_O[31:0]	<= regfile[12][31:0];
	4'b 1101:
		READD2_O[31:0]	<= regfile[13][31:0];
	4'b 1110:
		READD2_O[31:0]	<= regfile[14][31:0];
	4'b 1111:
		READD2_O[31:0]	<= regfile[15][31:0];
	default:
		READD2_O[31:0]	<= 32'h 0000_0000;
	endcase
end

always @(posedge CLK_I)
begin
	if (REGWR_EN_I)
	begin
		case (WRITE_I[3:0])
		4'b 0000:
			regfile[0][31:0]	<= 32'h 0000_0000;
		4'b 0001:
			regfile[1][31:0]	<= WRITED_I[31:0];
		4'b 0010:
			regfile[2][31:0]	<= WRITED_I[31:0];	
		4'b 0011:
			regfile[3][31:0]	<= WRITED_I[31:0];
		4'b 0100:
			regfile[4][31:0]	<= WRITED_I[31:0];
		4'b 0101:
			regfile[5][31:0]	<= WRITED_I[31:0];
		4'b 0110:
			regfile[6][31:0]	<= WRITED_I[31:0];
		4'b 0111:
			regfile[7][31:0]	<= WRITED_I[31:0];
		4'b 1000:
			regfile[8][31:0]	<= WRITED_I[31:0];
		4'b 1001:
			regfile[9][31:0]	<= WRITED_I[31:0];
		4'b 1010:
			regfile[10][31:0]	<= WRITED_I[31:0];
		4'b 1011:
			regfile[11][31:0]	<= WRITED_I[31:0];
		4'b 1100:
			regfile[12][31:0]	<= WRITED_I[31:0];
		4'b 1101:
			regfile[13][31:0]	<= WRITED_I[31:0];
		4'b 1110:
			regfile[14][31:0]	<= WRITED_I[31:0];
		4'b 1111:
			regfile[15][31:0]	<= WRITED_I[31:0];
		default:
		begin
			regfile[0][31:0]	<= 32'h 0000_0000;
			regfile[1][31:0]	<= 32'h 0000_0000;
			regfile[2][31:0]	<= 32'h 0000_0000;
			regfile[3][31:0]	<= 32'h 0000_0000;
			regfile[4][31:0]	<= 32'h 0000_0000;
			regfile[5][31:0]	<= 32'h 0000_0000;
			regfile[6][31:0]	<= 32'h 0000_0000;
			regfile[7][31:0]	<= 32'h 0000_0000;
			regfile[8][31:0]	<= 32'h 0000_0000;
			regfile[9][31:0]	<= 32'h 0000_0000;
			regfile[10][31:0]	<= 32'h 0000_0000;
			regfile[11][31:0]	<= 32'h 0000_0000;
			regfile[12][31:0]	<= 32'h 0000_0000;
			regfile[13][31:0]	<= 32'h 0000_0000;
			regfile[14][31:0]	<= 32'h 0000_0000;
			regfile[15][31:0]	<= 32'h 0000_0000;
		end
		endcase
	end
	else
	begin
		regfile[0][31:0]	<= 32'h 0000_0000;
	end
end
endmodule
