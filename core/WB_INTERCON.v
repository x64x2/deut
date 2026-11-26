`include "WB_CONFIG.v"
module	WB_INTERCON(
						CLK_I,
						RST_I,
						M0_ADR_O, M0_DAT_I, M0_DAT_O, M0_WE_O,
						M0_SEL_O, M0_STB_O, M0_ACK_I, M0_CYC_O,
						M1_ADR_O, M1_DAT_I, M1_DAT_O, M1_WE_O,
						M1_SEL_O, M1_STB_O, M1_ACK_I, M1_CYC_O,
						
						S0_ADR_I, S0_DAT_I, S0_DAT_O, S0_WE_I,
						S0_SEL_I, S0_STB_I, S0_ACK_O, S0_CYC_I,
						S1_ADR_I, S1_DAT_I, S1_DAT_O, S1_WE_I,
						S1_SEL_I, S1_STB_I, S1_ACK_O, S1_CYC_I,
						S2_ADR_I, S2_DAT_I, S2_DAT_O, S2_WE_I,
						S2_SEL_I, S2_STB_I, S2_ACK_O, S2_CYC_I,
						
						S3_ADR_I, S3_DAT_I, S3_DAT_O, S3_WE_I,
						S3_SEL_I, S3_STB_I, S3_ACK_O, S3_CYC_I
						
					);
input			CLK_I;
input			RST_I;

input	[31:0]	M1_ADR_O,
				M1_DAT_O;
output	[31:0]	M1_DAT_I;
input			M1_WE_O,
				M1_SEL_O,
				M1_CYC_O,
				M1_STB_O;
output			M1_ACK_I;

input	[31:0]	M0_ADR_O,
				M0_DAT_O;
output	[31:0]	M0_DAT_I;
input			M0_WE_O,
				M0_SEL_O,
				M0_CYC_O,
				M0_STB_O;
output			M0_ACK_I;

output	[31:0]	S1_ADR_I,
				S1_DAT_I;
input	[31:0]	S1_DAT_O;
output			S1_WE_I,
				S1_SEL_I,
				S1_CYC_I,
				S1_STB_I;
input			S1_ACK_O;

output	[31:0]	S2_ADR_I,
				S2_DAT_I;
input	[31:0]	S2_DAT_O;
output			S2_WE_I,
				S2_SEL_I,
				S2_CYC_I,
				S2_STB_I;
input			S2_ACK_O;

output	[31:0]	S3_ADR_I,
				S3_DAT_I;
input	[31:0]	S3_DAT_O;
output			S3_WE_I,
				S3_SEL_I,
				S3_CYC_I,
				S3_STB_I;
input			S3_ACK_O;

output	[31:0]	S0_ADR_I,
				S0_DAT_I;
input	[31:0]	S0_DAT_O;
output			S0_WE_I,
				S0_SEL_I,
				S0_CYC_I,
				S0_STB_I;
input			S0_ACK_O;

wire	[31:0]	oADR;
wire	[31:0]	oDAT;
wire	[31:0]	iDAT;
wire			oSEL;
wire			oWE;
wire			oSTB;
reg				oCYC;
wire			iACK;

reg		[1:0]	GNT;
reg				GNT0;
reg				GNT1;
reg		[1:0]	arb_state;
reg		[1:0]	arb_state_n;
reg				arb_next;
parameter	[1:0]	ARB_READY	= 2'b 00;
parameter	[1:0]	ARB_M0		= 2'b 01;
parameter	[1:0]	ARB_M1		= 2'b 10;

always@(posedge CLK_I)
begin
	if(RST_I)
	begin
		arb_state[1:0]	<=	ARB_READY;
	end
	else
	begin
		arb_state[1:0]	<= arb_state_n[1:0];
	end
end

always@(posedge CLK_I)
begin
	case(arb_state[1:0])
	ARB_READY:
	begin
		case({M0_CYC_O,M1_CYC_O})
		2'b 00:	
			arb_state_n[1:0]	<= ARB_READY;
		2'b 01:	
			arb_state_n[1:0]	<= ARB_M1;
		2'b 10:
			arb_state_n[1:0]	<= ARB_M0;
		2'b 11: 
			arb_state_n[1:0]	<= (arb_next) ? ARB_M1 : ARB_M0;
		endcase
	end
	ARB_M0:
	begin
		case({M0_CYC_O,M1_CYC_O})
		2'b 00:	
			arb_state_n[1:0]	<= ARB_READY;
		2'b 01:	
			arb_state_n[1:0]	<= ARB_M1;
		2'b 10: 
			arb_state_n[1:0]	<= ARB_M0;
		2'b 11: 
			arb_state_n[1:0]	<= ARB_M0;
		endcase
	end
	ARB_M1:
	begin
		case({M0_CYC_O,M1_CYC_O})
		2'b 00:	
			arb_state_n[1:0]	<= ARB_READY;
		2'b 01:	
			arb_state_n[1:0]	<= ARB_M1;
		2'b 10: 
			arb_state_n[1:0]	<= ARB_M0;
		2'b 11: 
			arb_state_n[1:0]	<= ARB_M1;
		endcase
	end
	default:
	begin
		arb_state_n[1:0]	<= ARB_READY;
	end
	endcase
end

always@(arb_state[1:0])
begin
	case(arb_state[1:0])
	ARB_READY:
	begin
		arb_next	<= arb_next;
		oCYC		<= 1'b 0;
		GNT0		<= 1'b 0;
		GNT1		<= 1'b 0;
		GNT			<= 2'b 00;
	end
	ARB_M0:
	begin
		arb_next	<= 1'b 1;
		oCYC		<= 1'b 1;
		GNT0		<= 1'b 1;
		GNT1		<= 1'b 0;
		GNT			<= 2'b 01;
	end
	ARB_M1:
	begin
		arb_next	<= 1'b 0;
		oCYC		<= 1'b 1;
		GNT0		<= 1'b 0;
		GNT1		<= 1'b 1;
		GNT			<= 2'b 10;
	end
	default:
	begin
		arb_next	<= 1'b 0;
		oCYC		<= 1'b 0;
		GNT0		<= 1'b 0;
		GNT1		<= 1'b 0;
		GNT			<= 2'b 00;
	end
	endcase
end

reg				ACMP0;
reg				ACMP1;
reg				ACMP2;
reg				ACMP3;
always@(oADR[31:16])
begin
	casex(oADR[31:16])
	2'h 0XXX:		// SRAM
	begin
		ACMP0	<= 1'b 1;
		ACMP1	<= 1'b 0;
		ACMP2	<= 1'b 0;
		ACMP3	<= 1'b 0;
	end
	2'h 0018:		// HEX
	begin
		ACMP0	<= 1'b 0;
		ACMP1	<= 1'b 1;
		ACMP2	<= 1'b 0;
		ACMP3	<= 1'b 0;
	end
	default:
	begin
		ACMP0	<= 1'b 0;
		ACMP1	<= 1'b 0;
		ACMP2	<= 1'b 0;
		ACMP3	<= 1'b 0;
	end
	endcase
end

assign	S0_CYC_I	= oCYC;
assign	S1_CYC_I	= oCYC;
assign	S2_CYC_I	= oCYC;
assign	S3_CYC_I	= oCYC;

wire	[31:0]	madr_o;
wire	[31:0]	mdat_o;
wire			msel_o;
wire			mwe_o;
wire			mstb_o;
assign	madr_o	= (GNT == 2) ? M1_ADR_O :
	(GNT == 1) ? M0_ADR_O : 32'h 0000_0000;
assign	S0_ADR_I	= madr_o;
assign	S1_ADR_I	= madr_o;
assign	S2_ADR_I	= madr_o;
assign	S3_ADR_I	= madr_o;

assign	mdat_o	= (GNT == 2) ? M1_DAT_O :
	(GNT == 1) ? M0_DAT_O : 32'h 0000_0000;
assign	S0_DAT_I	= mdat_o;
assign	S1_DAT_I	= mdat_o;
assign	S2_DAT_I	= mdat_o;
assign	S3_DAT_I	= mdat_o;

assign	msel_o	= (GNT == 2) ? M1_SEL_O :
	(GNT == 1) ? M0_SEL_O : 1'b 0;
assign	S0_SEL_I	= msel_o;
assign	S1_SEL_I	= msel_o;
assign	S2_SEL_I	= msel_o;
assign	S3_SEL_I	= msel_o;

assign	mwe_o	= (GNT == 2) ? M1_WE_O :
	(GNT == 1) ? M0_WE_O : 1'b 0;
assign	S0_WE_I	= mwe_o;
assign	S1_WE_I	= mwe_o;
assign	S2_WE_I	= mwe_o;
assign	S3_WE_I	= mwe_o;

assign	mstb_o	= (GNT == 2) ? M1_STB_O :
	(GNT == 1) ? M0_STB_O : 1'b 0;
assign	S0_STB_I	= mstb_o & ACMP0;
assign	S1_STB_I	= mstb_o & ACMP1;
assign	S2_STB_I	= mstb_o & ACMP2;
assign	S3_STB_I	= mstb_o & ACMP3;

wire	[31:0]	sdat_o;
assign	sdat_o	= (ACMP0 == 1) ? S0_DAT_O :
	(ACMP1 == 1) ? S1_DAT_O :
	(ACMP2 == 1) ? S2_DAT_O :
	(ACMP3 == 1) ? S3_DAT_O : 32'h 0000_0000;
assign	M0_DAT_I	= sdat_o;
assign	M1_DAT_I	= sdat_o;

wire	sack_o;
assign	sack_o	= S0_ACK_O | S1_ACK_O | S2_ACK_O | S3_ACK_O;
assign	M0_ACK_I	= GNT0 & sack_o;
assign	M1_ACK_I	= GNT1 & sack_o;

input	[15:0]	M0_ADR_O,
				M0_DAT_O;
output	[15:0]	M0_DAT_I;
input			M0_WE_O,
				M0_SEL_O,
				M0_CYC_O,
				M0_STB_O;
output			M0_ACK_I;

output	[15:0]	S0_ADR_I,
				S0_DAT_I;
input	[15:0]	S0_DAT_O;
output			S0_WE_I,
				S0_SEL_I,
				S0_CYC_I,
				S0_STB_I;
input			S0_ACK_O;*/

endmodule
