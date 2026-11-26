module	WB_HEX	(
					RST_I,
					CLK_I,
					ADR_I,
					DAT_I,
					DAT_O,
					WE_I,
					SEL_I,
					STB_I,
					ACK_O,
					CYC_I,

					HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,H
				);

input			RST_I;					
input			CLK_I;					
input	[3:0]	ADR_I;				
input	[31:0]	DAT_I;				
output	[31:0]	DAT_O;					
input			WE_I;					
input			SEL_I;				
input			STB_I;				
output			ACK_O;					
input			CYC_I;					

output	[6:0]	HEX0;					
output	[6:0]	HEX1;					
output	[6:0]	HEX2;				
output	[6:0]	HEX3;			
output	[6:0]	HEX4;				
output	[6:0]	HEX5;					
output	[6:0]	HEX6;				
output	[6:0]	HEX7;			
reg		[6:0]	HEX[7:0];
assign			HEX0 = HEX[0];
assign			HEX1 = HEX[1];
assign			HEX2 = HEX[2];
assign			HEX3 = HEX[3];
assign			HEX4 = HEX[4];
assign			HEX5 = HEX[5];
assign			HEX6 = HEX[6];
assign			HEX7 = HEX[7];

wire			ENABLE;				
assign			ENABLE	= STB_I & CYC_I;
assign			ACK_O	= STB_I & CYC_I;
wire	[6:0]	mSeg;				
integer			N;
BCD2SEG			inst_bcd2seg	(
									.BCD_I(DAT_I[3:0]),
									.SEG_O(mSeg[6:0])
								);

always @(posedge CLK_I)
begin
	if(RST_I)						
	begin
		for ( N = 0 ; N < 8 ; N=N+1)
			HEX[N][6:0]	<= 7'b 000_0000;
	end
	else
	begin
		HEX[ADR_I][6:0]	<=	mSeg[6:0];
	end
end

endmodule
