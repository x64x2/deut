module DMEM_CTRL(	CLK_I,
					nRST_I,
					Q_O,		
					A_I,		
					D_I,		
					WE_I,		
					HEX0,HEX1,HEX2,HEX3
				);
input			CLK_I;
input			nRST_I;
output	[31:0]	Q_O;
input	[31:0]	A_I;
input	[31:0]	D_I;
input			WE_I;
wire	[31:0]	Q_O;

output	[6:0]	HEX0,HEX1,HEX2,HEX3;
wire	[6:0]	HEX0,HEX1,HEX2,HEX3;

reg				DMEM_WE;
wire	[31:0]	DMEM_Q;
wire	[31:0]	DMEM_ADDR;
wire	[31:0]	DMEM_DATA;
assign	Q_O[31:0]		= DMEM_Q[31:0];
assign	DMEM_ADDR[31:0]	= A_I[31:0];
assign	DMEM_DATA[31:0]	= D_I[31:0];

reg		[31:0]	SEGMENT;
reg		[3:0]	SEG;
reg		[16:0]	counter;
wire			mod_CLOCK;
always@(posedge CLK_I or negedge nRST_I)
begin
	if(~nRST_I)
		counter	<= 17'h 0;
	else
		counter <= counter + 1;
end
assign mod_CLOCK = counter[16];
always@(posedge CLK_I or negedge nRST_I)
begin
	if(~nRST_I)
		SEG	<= 4'h 0;
	else
		SEG <= SEG + 1'b1;
end
BCD2SEG	bcd2seg_inst0(	.BCD_I(SEGMENT[3:0]),
						.SEG_O(HEX0[6:0])
					);
BCD2SEG	bcd2seg_inst1(	.BCD_I(SEGMENT[7:4]),
						.SEG_O(HEX1[6:0])
					);
BCD2SEG	bcd2seg_inst2(	.BCD_I(SEGMENT[11:8]),
						.SEG_O(HEX2[6:0])
					);
BCD2SEG	bcd2seg_inst3(	.BCD_I(SEG[3:0]),
						.SEG_O(HEX3[6:0])
					);

always @(posedge CLK_I)
begin
	if(A_I[31:4] == 28'b 0)
	begin
	case(A_I[3:0])
	4'h 0: 
		if(WE_I)
			SEGMENT[3:0]	<= D_I[3:0];
	4'h 4:
		if(WE_I)
			SEGMENT[7:4]	<= D_I[3:0];
	4'h 8:
		if(WE_I)
			SEGMENT[11:8]	<= D_I[3:0];
	4'h C:
		if(WE_I)
			SEGMENT[15:12]	<= D_I[3:0];
	default:
		SEGMENT[31:0]	<= SEGMENT[31:0];
	endcase
	end
	else
		SEGMENT[31:0] <= SEGMENT[31:0];
end

always@(A_I[31:9] or WE_I)
begin
	if(WE_I)
	begin
		if(A_I[31:9] == 23'h 00)
			DMEM_WE	<= 1'b1;
		else
			DMEM_WE	<= 1'b0;
	end
	else
	begin
		DMEM_WE	<= 1'b0;
	end
end

DMEM	dmem_inst(	.CLK_I(CLK_I),
					.Q_O(DMEM_Q[31:0]),		// Output Data
					.A_I(DMEM_ADDR[8:2]),		// Input Address only accept 7:1
					.D_I(DMEM_DATA[31:0]),		// Input Data
					.WE_I(DMEM_WE)		// Write Enable
				);
					
endmodule
