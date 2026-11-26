module B_SHIFT	(
					Shift_I,
					Shamt_I,
					Sht_I,
					Sht_EN_I,
					Shift_O
				);

input	[31:0]	Shift_I;
input	[4:0]	Shamt_I;
input	[1:0]	Sht_I;
input			Sht_EN_I;

output	[31:0]	Shift_O;
reg		[31:0]	Shift_Result;
wire	[31:0]	SHL_Stage1, SHL_Stage2, SHL_Stage3, SHL_Stage4, SHL_Stage5;
wire	[31:0]	SHR_Stage1, SHR_Stage2, SHR_Stage3, SHR_Stage4, SHR_Stage5;
wire	[31:0]	SHAR_Stage1, SHAR_Stage2, SHAR_Stage3, SHAR_Stage4, SHAR_Stage5;
wire	[31:0]	SHROR_Stage1, SHROR_Stage2, SHROR_Stage3, SHROR_Stage4, SHROR_Stage5;

assign SHL_Stage1[31:0]		= Shamt_I[0] ? {Shift_I[30:0], 1'b 0} : Shift_I[31:0];
assign SHL_Stage2[31:0]		= Shamt_I[1] ? {SHL_Stage1[29:0], 2'b 0} : SHL_Stage1[31:0];
assign SHL_Stage3[31:0]		= Shamt_I[2] ? {SHL_Stage2[27:0], 4'b 0} : SHL_Stage2[31:0];
assign SHL_Stage4[31:0]		= Shamt_I[3] ? {SHL_Stage3[23:0], 8'b 0} : SHL_Stage3[31:0];
assign SHL_Stage5[31:0]		= Shamt_I[4] ? {SHL_Stage4[15:0], 16'b 0} : SHL_Stage4[31:0];

assign SHR_Stage1[31:0]		= Shamt_I[0] ? {1'b 0, Shift_I[31:1]} : Shift_I[31:0];
assign SHR_Stage2[31:0] 	= Shamt_I[1] ? {2'b 0, SHR_Stage1[31:2]} : SHR_Stage1[31:0];
assign SHR_Stage3[31:0] 	= Shamt_I[2] ? {4'b 0, SHR_Stage2[31:4]} : SHR_Stage2[31:0];
assign SHR_Stage4[31:0]		= Shamt_I[3] ? {8'b 0, SHR_Stage3[31:8]} : SHR_Stage3[31:0];
assign SHR_Stage5[31:0]		= Shamt_I[4] ? {16'b 0, SHR_Stage4[31:16]} : SHR_Stage4[31:0];

assign SHAR_Stage1[31:0]	= Shamt_I[0] ? {Shift_I[31], Shift_I[31:1]} : Shift_I[31:0];
assign SHAR_Stage2[31:0]	= Shamt_I[1] ? {{2{SHAR_Stage1[31]}}, SHAR_Stage1[31:2]} : SHAR_Stage1[31:0];
assign SHAR_Stage3[31:0]	= Shamt_I[2] ? {{4{SHAR_Stage2[31]}}, SHAR_Stage2[31:4]} : SHAR_Stage2[31:0];
assign SHAR_Stage4[31:0]	= Shamt_I[3] ? {{8{SHAR_Stage3[31]}}, SHAR_Stage3[31:8]} : SHAR_Stage3[31:0];
assign SHAR_Stage5[31:0]	= Shamt_I[4] ? {{16{SHAR_Stage4[31]}}, SHAR_Stage4[31:16]} : SHAR_Stage4[31:0];

assign SHROR_Stage1[31:0]	= Shamt_I[0] ? {Shift_I[30:0], Shift_I[31]} : Shift_I[31:0];
assign SHROR_Stage2[31:0]	= Shamt_I[1] ? {SHROR_Stage1[29:0], SHROR_Stage1[31:30]} : SHROR_Stage1;
assign SHROR_Stage3[31:0]	= Shamt_I[2] ? {SHROR_Stage2[27:0], SHROR_Stage2[31:28]} : SHROR_Stage2;
assign SHROR_Stage4[31:0]	= Shamt_I[3] ? {SHROR_Stage3[23:0], SHROR_Stage3[31:24]} : SHROR_Stage3;
assign SHROR_Stage5[31:0]	= Shamt_I[4] ? {SHROR_Stage4[15:0], SHROR_Stage4[31:16]} : SHROR_Stage4;

always@(Shift_I[15:0] or Sht_I[1:0] or Shamt_I[4:0] or SHL_Stage5[31:0] or SHR_Stage5[31:0] or SHAR_Stage5[31:0] or SHROR_Stage5[31:0])
begin
	case(Sht_I[1:0])
		2'b 00	:
			Shift_Result[31:0] <= SHL_Stage5[31:0];
		2'b 01	:
			Shift_Result[31:0] <= SHR_Stage5[31:0];
		2'b 10	:
			Shift_Result[31:0] <= SHAR_Stage5[31:0];
		2'b 11	:
			Shift_Result[31:0] <= SHROR_Stage5[31:0];
	endcase
end

assign	Shift_O[31:0] = Sht_EN_I ? Shift_Result[31:0] : Shift_I[31:0];

endmodule
