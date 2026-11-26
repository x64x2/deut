`define	sign		1'b 0
`define unsign		1'b 1

`define	ADD		7'b 0000_000
`define	SUB		7'b 0000_001
`define	MUL		7'b 0000_010
`define	DIV		7'b 0000_100
`define	AND		7'b 0001_000
`define	OR		7'b 0001_001
`define XOR		7'b 0001_010
`define NOT		7'b 0001_100
`define	SH		7'b 0001_101
`define	SHL		2'b 00
`define	SHR		2'b 01
`define	SHAR	2'b 10
`define SHROR	2'b 11

`define	ADDI		7'b 0100_000
`define	SUBI		7'b 0100_001
`define	MULI		7'b 0100_010
`define DIVI		7'b 0100_100
`define	ANDI		7'b 0101_000
`define	ORI			7'b 0101_001
`define	XORI		7'b 0101_010
`define NOTI		7'b 0101_100
`define	LDC			7'b 0101_101
`define	LUI			7'b 0101_110

`define	LD		6'b 0110_00
`define	ST		6'b 0110_01
`define	BYTE		2'b 01
`define	WORD		2'b 10
`define DWORD		2'b 00
`define	STPC		8'b 0110_1000

`define	JR		8'b 0111_1000
`define	JRL		8'b 0111_1100

`define	JAL		5'b 1_0000
`define	JEQ		5'b 1_0001
`define	JNE		5'b 1_0010
`define	JLT		5'b 1_0100

`define	R0		4'b 0000
`define	R1		4'b 0001
`define	R2		4'b 0010
`define	R3		4'b 0011
`define	R4		4'b 0100
`define	R5		4'b 0101
`define	R6		4'b 0110
`define	R7		4'b 0111
`define	R8		4'b 1000
`define	R9		4'b 1001
`define	R10		4'b 1010
`define	R11		4'b 1011
`define	R12		4'b 1100
`define	R13		4'b 1101
`define	R14		4'b 1110
`define	R15		4'b 1111


