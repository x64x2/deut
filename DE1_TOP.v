module DE1_TOP
	(
		CLOCK_24,					
		CLOCK_27,					
		CLOCK_50,				
		EXT_CLOCK,					
		KEY,						
		SW,							
		HEX0,					
		HEX1,						
		HEX2,					
		HEX3,						
	
		LEDG,					
		LEDR,							
		UART_TXD,						
		UART_RXD,					
		DRAM_DQ,					
		DRAM_ADDR,			
		DRAM_LDQM,					 
		DRAM_UDQM,						
		DRAM_WE_N,						
		DRAM_CAS_N,						
		DRAM_RAS_N,						
		DRAM_CS_N,						
		DRAM_BA_0,					
		DRAM_BA_1,						
		DRAM_CLK,					
		DRAM_CKE,					
		
		FL_DQ,						
		FL_ADDR,		
		FL_WE_N,						
		FL_RST_N,						
		FL_OE_N,					
		FL_CE_N,					

		SRAM_DQ,						
		SRAM_ADDR,					
		SRAM_UB_N,						
		SRAM_LB_N,					 
		SRAM_WE_N,					
		SRAM_CE_N,				
		SRAM_OE_N,				
		
		SD_DAT,						
		SD_DAT3,						
		SD_CMD,			
		SD_CLK,					

		TDI,  	
		TCK,  					
		TCS,  							
	    TDO,  							

		I2C_SDAT,					
		I2C_SCLK,			

		PS2_DAT,				
		PS2_CLK,		

		VGA_HS,						
		VGA_VS,							
		VGA_R,   					
		VGA_G,	 						
		VGA_B,  						

		AUD_ADCLRCK,			
		AUD_ADCDAT,						
		AUD_DACLRCK,			
		AUD_DACDAT,		
		AUD_BCLK,			
		AUD_XCK,					

		GPIO_0,				
		GPIO_1					
	);

input	[1:0]	CLOCK_24;			
input	[1:0]	CLOCK_27;				
input			CLOCK_50;				
input			EXT_CLOCK;				

input	[3:0]	KEY;				
input	[9:0]	SW;					

output	[6:0]	HEX0;			
output	[6:0]	HEX1;				
output	[6:0]	HEX2;					
output	[6:0]	HEX3;				

output	[7:0]	LEDG;					
output	[9:0]	LEDR;		

output			UART_TXD;			
input			UART_RXD;				

inout	[15:0]	DRAM_DQ;				
output	[11:0]	DRAM_ADDR;			
output			DRAM_LDQM;				 
output			DRAM_UDQM;				
output			DRAM_WE_N;			
output			DRAM_CAS_N;				
output			DRAM_RAS_N;				
output			DRAM_CS_N;				
output			DRAM_BA_0;			
output			DRAM_BA_1;				
output			DRAM_CLK;			
output			DRAM_CKE;			

inout	[7:0]	FL_DQ;					
output	[21:0]	FL_ADDR;				
output			FL_WE_N;			
output			FL_RST_N;				
output			FL_OE_N;				
output			FL_CE_N;				

inout	[15:0]	SRAM_DQ;			
output	[17:0]	SRAM_ADDR;			
output			SRAM_UB_N;		 
output			SRAM_LB_N;				
output			SRAM_WE_N;				
output			SRAM_CE_N;				
output			SRAM_OE_N;				

inout			SD_DAT;					
inout			SD_DAT3;				
inout			SD_CMD;					
output			SD_CLK;				

inout			I2C_SDAT;			
output			I2C_SCLK;			

input		 	PS2_DAT;		
input			PS2_CLK;

input  			TDI;			
input  			TCK;	
input  			TCS;					
output 			TDO;			

output			VGA_HS;					
output			VGA_VS;					
output	[3:0]	VGA_R;   			
output	[3:0]	VGA_G;	 			
output	[3:0]	VGA_B;   				

inout			AUD_ADCLRCK;			
input			AUD_ADCDAT;		
inout			AUD_DACLRCK;		
output			AUD_DACDAT;				
inout			AUD_BCLK;			
output			AUD_XCK;			

inout	[35:0]	GPIO_0;			
inout	[35:0]	GPIO_1;					

assign	LEDG		=	8'hFF;
assign	LEDR		=	10'h3FF;

assign	DRAM_DQ		=	16'hzzzz;
assign	FL_DQ		=	8'hzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	SD_DAT		=	1'bz;
assign	I2C_SDAT	=	1'bz;
assign	AUD_ADCLRCK	=	1'bz;
assign	AUD_DACLRCK	=	1'bz;
assign	AUD_BCLK	=	1'bz;
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;

wire	[15:0]	DMEM_ADDR;
wire	[15:0]	DMEM_DATA;
wire	[15:0]	DMEM_Q;
wire			DMEM_WE;
wire	[15:0]	IMEM_ADDR;
wire	[15:0]	IMEM_DATA;

wire			CLOCK_100;
wire			CLOCK_10;
wire			CLOCK_LOCK;

wire			CLOCK_2_5;
MOD_CLK	mod_clk_inst(	.CLK_I(CLOCK_50),
						.nRST_I(KEY[0]),
						.CLK_O(CLOCK_2_5)
					);
DEUT_3pipe	system0(	.CLOCK_I(CLOCK_2_5),
					.nRST_I(KEY[0]),
					.IMEM_ADDR_O(IMEM_ADDR[15:0]),
					.IMEM_DATA_I(IMEM_DATA[15:0]),
					.DMEM_ADDR_O(DMEM_ADDR[15:0]),
					.DMEM_DATA_O(DMEM_DATA[15:0]),
					.DMEM_DATA_I(DMEM_Q[15:0]),
					.DMEM_WR_EN(DMEM_WE)
				);
IMEM_CTRL	imem_ctrl_inst(	.Q_O(IMEM_DATA[15:0]),
							.A_I(IMEM_ADDR[15:0])		
						);

DMEM_CTRL	dmem_ctrl_inst(	.CLK_I(CLOCK_2_5),
							.nRST_I(KEY[0]),
							.Q_O(DMEM_Q[15:0]),		
							.A_I(DMEM_ADDR[15:0]),		
							.D_I(DMEM_DATA[15:0]),		
							.WE_I(DMEM_WE),		
							.HEX0(HEX0),
							.HEX1(HEX1),
							.HEX2(HEX2),
							.HEX3(HEX3)
						);
endmodule
