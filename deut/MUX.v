module	MUX3(
				OUT_O,
				IN1_I,
				IN2_I,
				CTRL_I
			);
output	[2:0]	OUT_O;
input	[2:0]	IN1_I;
input	[2:0]	IN2_I;
input			CTRL_I;

assign	OUT_O[2:0] = (CTRL_I) ? IN2_I[2:0] : IN1_I[2:0];
endmodule

module	MUX4(
				OUT_O,
				IN1_I,
				IN2_I,
				CTRL_I
			);
output	[3:0]	OUT_O;
input	[3:0]	IN1_I;
input	[3:0]	IN2_I;
input			CTRL_I;

assign	OUT_O[3:0]	= (CTRL_I) ? IN2_I[3:0] : IN1_I[3:0];
endmodule

module	MUX16(
				OUT_O,
				IN1_I,
				IN2_I,
				CTRL_I
			);
output	[15:0]	OUT_O;
input	[15:0]	IN1_I;
input	[15:0]	IN2_I;
input			CTRL_I;

assign	OUT_O[15:0] = (CTRL_I) ? IN2_I[15:0] : IN1_I[15:0];

endmodule

module	MUX32(
				OUT_O,
				IN1_I,
				IN2_I,
				CTRL_I
			);
output	[31:0]	OUT_O;
input	[31:0]	IN1_I;
input	[31:0]	IN2_I;
input			CTRL_I;

assign	OUT_O[31:0] = (CTRL_I) ? IN2_I[31:0] : IN1_I[31:0];

endmodule

module	MUX(				//	16 X 5  MUX
	 			OUT_O,
				IN1_I,
				IN2_I,
				IN3_I,
				IN4_I,
				IN5_I,
				CTRL_I
		   );
output	[31:0]	OUT_O;
input	[31:0]	IN1_I;
input	[31:0]	IN2_I;
input	[31:0]	IN3_I;
input	[31:0]	IN4_I;
input	[31:0]	IN5_I;
input	[2:0]	CTRL_I;

reg		[31:0]	OUT_O;

always@(IN1_I or IN2_I or IN3_I or IN4_I or IN5_I or CTRL_I)
begin
	 case(CTRL_I)
		  3'b 000	:
			   OUT_O[31:0]	<= IN1_I;
		  3'b 001	:
   			   OUT_O[31:0]	<= IN2_I;
		  3'b 010	:
			   OUT_O[31:0]	<= IN3_I;
		  3'b 011	:
			   OUT_O[31:0]	<= IN4_I;
		  3'b 100	:
			   OUT_O[31:0]	<= IN5_I;
		  default	:
			   OUT_O[31:0]	<= 32'h 0000_0000;
	 endcase
end

endmodule
