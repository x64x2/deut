module EXT (
				extend_I,
				control_I,
				extend_O
				);
				
input	[26:0]	extend_I;
input	[1:0]	control_I;
output	[31:0]	extend_O;

reg		[31:0]	extend_O;

always@(extend_I[26:0] or control_I[1:0])
begin
	casex(control_I[1:0])
		2'b00	:
			extend_O[31:0]	<= {{16{extend_I[15]}}, extend_I[15:0]};
		2'b01	:
			extend_O[31:0]	<= {{16{extend_I[15]}}, extend_I[15:0]};
		2'b10	:
			extend_O[31:0]	<= {{5{extend_I[26]}}, extend_I[26:0]};
		2'b11	:
			extend_O[31:0]	<= {extend_I[15:0], 8'h00};
		default :
			extend_O[31:0]	<= 32'h x;
	endcase
end

endmodule

