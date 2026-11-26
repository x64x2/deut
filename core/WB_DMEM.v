module WB_DMEM	(
					RST_I,
					CLK_I,
					ADR_O,
					DAT_I,
					DAT_O,
					WE_O,
					SEL_O,
					STB_O,
					ACK_I,
					CYC_O,
					
					DM_ADR,
					DM_DAT_I,
					DM_DAT_O,
					DM_WE,
					DM_CE
				);

input			RST_I;				
input			CLK_I;					
output	[31:0]	ADR_O;
input	[31:0]	DAT_I;					
output	[31:0]	DAT_O;					
output			WE_O;					
output			SEL_O;					
output			STB_O;					
input			ACK_I;					
output			CYC_O;					
reg		[31:0]	ADR_O;
reg				STB_O;
reg				CYC_O;
reg				SEL_O;
reg				WE_O;


input	[31:0]	DM_ADR;					
input	[31:0]	DM_DAT_I;				
output	[31:0]	DM_DAT_O;				
input			DM_WE;				
input			DM_CE;				

reg		[31:0]	oDATA;					

assign	DAT_O[31:0]		= DM_DAT_I[31:0];
assign	DM_DAT_O[31:0]	= oDATA[31:0];

parameter	READY		= 3'b 001;
parameter	DELIEVER	= 3'b 010;
parameter	RECOVER		= 3'b 100;
reg		[2:0]	state;
reg		[2:0]	state_next;

always @(posedge CLK_I or posedge RST_I)
begin
	if(RST_I)
	begin
		state[2:0]	<= READY;
	end
	else
	begin
		state[2:0]	<= state_next[2:0];
	end
end

always @(state[2:0] or DM_CE or ACK_I)
begin
		case(state[2:0])
		READY:
		begin
			if(DM_CE)
				state_next[2:0]	<= DELIEVER;
			else
				state_next[2:0]	<= READY;
		end
		DELIEVER:
		begin
			if(ACK_I)
				state_next[2:0]	<= RECOVER;
			else
				state_next[2:0]	<= DELIEVER;
		end
		RECOVER:
		begin
			state_next[2:0]	<= READY;
		end
		default:
		begin
			state_next[2:0]	<= READY;
		end
		endcase
end

always @(state[2:0])
begin
	case(state[2:0])
	READY:
	begin
		ADR_O[31:0]	<= 32'h 0000_0000;
		STB_O		<= 1'b 0;
		CYC_O		<= 1'b 0;
		SEL_O		<= 1'b 1;
		WE_O		<= 1'b 0;
		oDATA[31:0]	<= 32'h 0000_0000;
	end
	DELIEVER:
	begin
		oDATA[31:0]	<= 32'h 0000_0000;
		ADR_O[31:0]	<= DM_ADR[31:0];
		STB_O		<= 1'b 1;
		CYC_O		<= 1'b 1;
		SEL_O		<= 1'b 1;
		WE_O		<= DM_WE;
	end
	RECOVER:
	begin
		oDATA[31:0]	<= DAT_I[31:0];
		ADR_O[31:0]	<= 32'h 0000_0000;
		STB_O		<= 1'b 0;
		CYC_O		<= 1'b 0;
		SEL_O		<= 1'b 0;
		WE_O		<= 1'b 0;
	end
	default:
	begin
		ADR_O[31:0]	<= 32'h 0000_0000;
		STB_O		<= 1'b 0;
		CYC_O		<= 1'b 0;
		SEL_O		<= 1'b 1;
		WE_O		<= 1'b 0;
		oDATA[31:0]	<= 32'h 0000_0000;
	end
	endcase
end
endmodule
