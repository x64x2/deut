module WB_SRAM	(
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
					
					SRAM_DQ,
					SRAM_ADDR,
					SRAM_UB_N,
					SRAM_LB_N,
					SRAM_WE_N,
					SRAM_CE_N,
					SRAM_OE_N
				);

input			RST_I;					
input			CLK_I;					
input	[18:0]	ADR_I;				
input	[31:0]	DAT_I;					
output	[31:0]	DAT_O;				
input			WE_I;				
input			SEL_I;					
input			STB_I;					
output			ACK_O;					
input			CYC_I;		

inout	[15:0]	SRAM_DQ;		
output	[17:0]	SRAM_ADDR;			
output			SRAM_UB_N;			
output			SRAM_LB_N;			
output			SRAM_WE_N;			
output			SRAM_CE_N;			
output			SRAM_OE_N;				

reg				floor;					
reg				ack;				
reg		[31:0]	mDATA;					
wire	[15:0]	mDAT_I;
reg		[15:0]	mTMP_L;				
reg		[15:0]	mTMP_H;				

assign	DAT_O[15:0]		= SRAM_DQ[15:0];
assign	mDAT_I[15:0]	= floor ? DAT_I[31:16] : DAT_I[15:0];
assign	SRAM_DQ[15:0]	= SRAM_WE_N ? 16'h zzzz : mDAT_I[15:0];

assign	DAT_O[31:0]		= {mTMP_H[15:0],mTMP_L[15:0]};
assign	SRAM_ADDR[17:0]	= {ADR_I[18:2],floor};

assign	SRAM_UB_N		= 1'b 0;		
assign	SRAM_LB_N		= 1'b 0;		
assign	SRAM_CE_N		= 1'b 0;	
assign	SRAM_OE_N		= 1'b 0;		

wire	ENABLE;
assign	ENABLE	= STB_I & CYC_I;
assign	ACK_O	= ack;

assign	SRAM_WE_N	= ENABLE ? ~WE_I : 1'b 1;

reg		[1:0]	state;					
reg		[1:0]	state_n;
parameter	[1:0]	READY	= 2'b 00;
parameter	[1:0]	T1		= 2'b 01;
parameter	[1:0]	T2		= 2'b 10;	

always@(posedge CLK_I or posedge RST_I)
begin
	if(RST_I)
		state	<= READY;
	else
		state		<= state_n;
end

always@(state)
begin
	case(state)
		READY:
		begin
			floor	<= 1'b 0;
			ack		<= 1'b 0;
			mTMP_L	<= 16'h 0000;
			mTMP_H	<= 16'h 0000;
		end
		T1:
		begin
			floor	<= 1'b 1;
			ack		<= 1'b 0;
			mTMP_L	<= SRAM_DQ;
			mTMP_H	<= mTMP_L;
		end
		T2:
		begin
			floor	<= 1'b 1;
			ack		<= 1'b 1;
			mTMP_L	<= SRAM_DQ;
			mTMP_H	<= mTMP_L;
		end
		default:
		begin
			floor	<= 1'b 0;
			ack		<= 1'b 0;
			mTMP_L	<= 16'h 0000;
			mTMP_H	<= 16'h 0000;
		end
	endcase
end

always @(state or ENABLE)
begin
	case(state)
		READY:
		begin
			if(ENABLE)
				state_n	<= T1;
			else
				state_n	<= READY;
		end
		T1:
		begin
			state_n		<= T2;
		end
		T2:
		begin
			state_n		<= READY;
		end
		default:
		begin
			state_n		<= READY;
		end
	endcase
end

endmodule
