module	control_EX	(
					PCMUX_SIG_I,
					CPSR_I,
					PC_MUX_O

			   );

input	[2:0]	PCMUX_SIG_I;
input	[1:0]	CPSR_I;

output			PC_MUX_O;
reg				PC_MUX_O;

wire			NEGATIVE;
wire			ZERO;

assign	NEGATIVE = CPSR_I[1];
assign	ZERO = CPSR_I[0];

always@(PCMUX_SIG_I[2:0] or NEGATIVE or ZERO)
begin
	 case(PCMUX_SIG_I[2:0])
		  3'b 000	:			//	
			   PC_MUX_O <= 0;
		  3'b 001	:			//	JR, JAL
			   PC_MUX_O <= 1;
		  3'b 010	:			//	JEQ
		  begin
			   if(ZERO)
					PC_MUX_O <= 1;
			   else
					PC_MUX_O <= 0;
		  end
		  3'b 011	:			//	JNE
		  begin
			   if(ZERO)
					PC_MUX_O <= 0;
			   else
					PC_MUX_O <= 1;
		  end
		  3'b 100	:			//	JLT
		  begin
			   if(NEGATIVE)
					PC_MUX_O <= 1;
			   else
					PC_MUX_O <= 0;
		  end
		  default	:
			   PC_MUX_O <= 0;
	 endcase
end

endmodule



						
