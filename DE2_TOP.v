


module DE2_TOP
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		IRDA_TXD,						//	IRDA Transmitter
		IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_DAT3,						//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	    TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK,							//	TV Decoder Clock
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_27;				//	27 MHz
input			CLOCK_50;				//	50 MHz
input			EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input			UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
output			IRDA_TXD;				//	IRDA Transmitter
input			IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	[15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output	[11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	[7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output	[21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output	[17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	[15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output	[1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			OTG_INT0;				//	ISP1362 Interrupt 0
input			OTG_INT1;				//	ISP1362 Interrupt 1
input			OTG_DREQ0;				//	ISP1362 DMA Request 0
input			OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	[7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout			SD_DAT;					//	SD Card Data
inout			SD_DAT3;				//	SD Card Data 3
inout			SD_CMD;					//	SD Card Command Signal
output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	PS2_DAT;				//	PS2 Data
input			PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	[7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			TD_HS;					//	TV Decoder H_SYNC
input			TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input			TD_CLK;					//	TV Decoder Clock
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

//	Turn on all display
//assign	HEX0		=	7'h00;
//assign	HEX1		=	7'h00;
//assign	HEX2		=	7'h00;
//assign	HEX3		=	7'h00;
//assign	HEX4		=	7'h00;
//assign	HEX5		=	7'h00;
//assign	HEX6		=	7'h00;
//assign	HEX7		=	7'h00;
assign	LEDG		=	9'h1FF;
assign	LEDR		=	18'h3FFFF;
assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;

//	All inout port turn to tri-state
assign	DRAM_DQ		=	16'hzzzz;
assign	FL_DQ		=	8'hzz;
//assign	SRAM_DQ		=	16'hzzzz;
assign	OTG_DATA	=	16'hzzzz;
assign	LCD_DATA	=	8'hzz;
assign	SD_DAT		=	1'bz;
assign	I2C_SDAT	=	1'bz;
assign	ENET_DATA	=	16'hzzzz;
assign	AUD_ADCLRCK	=	1'bz;
assign	AUD_DACLRCK	=	1'bz;
assign	AUD_BCLK	=	1'bz;
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;

// ------------------------
// DEUT Instance
wire	[31:0]	DMEM_ADDR;
wire	[31:0]	DMEM_DATA;
wire	[31:0]	DMEM_Q;
wire			DMEM_WE;
wire			DMCE;
wire	[31:0]	IMEM_ADDR;
wire	[31:0]	IMEM_DATA;

wire			CLOCK_100;
wire			CLOCK_10;
wire			CLOCK_LOCK;
//PLL pll_inst(	.areset(KEY[0]),
//				.inclk0(CLOCK_50),
//				.c0(CLOCK_100),
//				.c1(CLOCK_10),
//				.locked(CLOCK_LOCK)
//			);
wire			CLOCK_2_5;
MOD_CLK	mod_clk_inst(	.CLK_I(CLOCK_50),
						.nRST_I(KEY[0]),
						.CLK_O(CLOCK_2_5)
					);
theDEUT		system0(	.CLOCK_I(CLOCK_50),
					.WSS(1'b 0),
					.nRST_I(KEY[0]),
					.IMEM_ADDR_O(IMEM_ADDR[31:0]),
					.IMEM_DATA_I(IMEM_DATA[31:0]),
					.DMEM_ADDR_O(DMEM_ADDR[31:0]),
					.DMEM_DATA_O(DMEM_DATA[31:0]),
					.DMEM_DATA_I(DMEM_Q[31:0]),
					.DMEM_WR_EN(DMEM_WE),
					.DMCE_O(DMCE)
				);
// Data Memory Instance
IMEM_CTRL	imem_ctrl_inst(	.Q_O(IMEM_DATA[31:0]),		// Output Data
							.A_I(IMEM_ADDR[31:0])		// Input Address only accept 7:1
						);

/*DMEM_CTRL	dmem_ctrl_inst(	.CLK_I(CLOCK_50),
							.nRST_I(KEY[0]),
							.Q_O(DMEM_Q[31:0]),		// Output Data
							.A_I(DMEM_ADDR[31:0]),		// Input Address only accept 7:1
							.D_I(DMEM_DATA[31:0]),		// Input Data
							.WE_I(DMEM_WE&DMCE),		// Write Enable
							.HEX0(HEX0),
							.HEX1(HEX1),
							.HEX2(HEX2),
							.HEX3(HEX3)
						);
*/

////////////////////////////////////////////////////////////////////////////////
//	WISHBONE BUS
//	////////////////////////////////////////////////////////////////////////////

//	WISHBONE WIRE
wire			wb_clk;
wire			wb_rst;

wire	[31:0]	wb_dmem_adr_o;
wire	[31:0]	wb_dmem_dat_i;
wire	[31:0]	wb_dmem_dat_o;
wire			wb_dmem_we_o;
wire			wb_dmem_sel_o;
wire			wb_dmem_stb_o;
wire			wb_dmem_ack_i;
wire			wb_dmem_cyc_o;
wire	[31:0]	wb_sram_adr_i;
wire	[31:0]	wb_sram_dat_i;
wire	[31:0]	wb_sram_dat_o;
wire			wb_sram_we_i;
wire			wb_sram_sel_i;
wire			wb_sram_stb_i;
wire			wb_sram_ack_o;
wire			wb_sram_cyc_i;
wire	[31:0]	wb_hex_adr_i;
wire	[31:0]	wb_hex_dat_i;
wire	[31:0]	wb_hex_dat_o;
wire			wb_hex_we_i;
wire			wb_hex_sel_i;
wire			wb_hex_stb_i;
wire			wb_hex_ack_o;
wire			wb_hex_cyc_i;

//	WISHBONE MAIN MODULE
WB_SYSCON	wb_syscon_inst	(
					.CLK_I(CLOCK_50),
					.RST_I(~KEY[0]),
					.CLK_O(wb_clk),
					.RST_O(wb_rst)
				);
WB_INTERCON	wb_intercon_inst	(
						.CLK_I(wb_clk),
						.RST_I(wb_rst),
						//----------------------------------------
						// Master 0
						.M0_ADR_O(wb_dmem_adr_o),
						.M0_DAT_I(wb_dmem_dat_i),
						.M0_DAT_O(wb_dmem_dat_o),
						.M0_WE_O(wb_dmem_we_o),
						.M0_SEL_O(wb_dmem_sel_o),
						.M0_STB_O(wb_dmem_stb_o),
						.M0_ACK_I(wb_dmem_ack_i),
						.M0_CYC_O(wb_dmem_cyc_o),
						//----------------------------------------
						// Master 1
						//M1_ADR_O, M1_DAT_I, M1_DAT_O, M1_WE_O,
						//M1_SEL_O, M1_STB_O, M1_ACK_I, M1_CYC_O,
						
						//----------------------------------------
						// Slave 0
						.S0_ADR_I(wb_sram_adr_i),
						.S0_DAT_I(wb_sram_dat_i),
						.S0_DAT_O(wb_sram_dat_o),
						.S0_WE_I(wb_sram_we_i),
						.S0_SEL_I(wb_sram_sel_i),
						.S0_STB_I(wb_sram_stb_i),
						.S0_ACK_O(wb_sram_ack_o),
						.S0_CYC_I(wb_sram_cyc_i),
						//----------------------------------------
						// Slave 1
						.S1_ADR_I(wb_hex_adr_i),
						.S1_DAT_I(wb_hex_dat_i),
						.S1_DAT_O(wb_hex_dat_o),
						.S1_WE_I(wb_hex_we_i),
						.S1_SEL_I(wb_hex_sel_i),
						.S1_STB_I(wb_hex_stb_i),
						.S1_ACK_O(wb_hex_ack_o),
						.S1_CYC_I(wb_hex_cyc_i),
						
						//----------------------------------------
						// Slave 2
						//S2_ADR_I, S2_DAT_I, S2_DAT_O, S2_WE_I,
						//S2_SEL_I, S2_STB_I, S2_ACK_O, S2_CYC_I,
						
						//----------------------------------------
						// Slave 3
						//S3_ADR_I, S3_DAT_I, S3_DAT_O, S3_WE_I,
						//S3_SEL_I, S3_STB_I, S3_ACK_O, S3_CYC_I
						
					);
////////////////////////////////////////////////////////////////////////////////
//	WISHBONE MASTER
//	////////////////////////////////////////////////////////////////////////////
WB_DMEM		wb_dmem_inst	(
					//---------------------------------------
					// WISHBONE
					.RST_I(wb_rst),
					.CLK_I(wb_clk),
					.ADR_O(wb_dmem_adr_o),
					.DAT_I(wb_dmem_dat_i),
					.DAT_O(wb_dmem_dat_o),
					.WE_O(wb_dmem_we_o),
					.SEL_O(wb_dmem_sel_o),
					.STB_O(wb_dmem_stb_o),
					.ACK_I(wb_dmem_ack_i),
					.CYC_O(wb_dmem_cyc_o),
					
					//---------------------------------------
					// Data Memory DEUT
					.DM_ADR(DMEM_ADDR[31:0]),
					.DM_DAT_I(DMEM_DATA[31:0]),
					.DM_DAT_O(DMEM_Q[31:0]),
					.DM_WE(DMEM_WE),
					.DM_CE(DMCE)
				);
////////////////////////////////////////////////////////////////////////////////
//	WISHBONE SLAVE
//	////////////////////////////////////////////////////////////////////////////
WB_SRAM		wb_sram_inst	(
					//---------------------------------------
					// WISHBONE
					.RST_I(wb_rst),
					.CLK_I(wb_clk),
					.ADR_I(wb_sram_adr_i),
					.DAT_I(wb_sram_dat_i),
					.DAT_O(wb_sram_dat_o),
					.WE_I(wb_sram_we_i),
					.SEL_I(wb_sram_sel_i),
					.STB_I(wb_sram_stb_i),
					.ACK_O(wb_sram_ack_o),
					.CYC_I(wb_sram_cyc_i),
					
					//----------------------------------------
					// SRAM OUT
					.SRAM_DQ(SRAM_DQ),
					.SRAM_ADDR(SRAM_ADDR),
					.SRAM_UB_N(SRAM_UB_N),
					.SRAM_LB_N(SRAM_LB_N),
					.SRAM_WE_N(SRAM_WE_N),
					.SRAM_CE_N(SRAM_CE_N),
					.SRAM_OE_N(SRAM_OE_N)
				);
////////////////////////////////////////////////////////////////////////////////
//	WISHBONE SLAVE
//	////////////////////////////////////////////////////////////////////////////
WB_HEX		wb_hex_inst	(
					//-------------------------------------
					// WISHBONE
					.RST_I(wb_rst),
					.CLK_I(wb_clk),
					.ADR_I(wb_hex_adr_i),
					.DAT_I(wb_hex_dat_i),
					.DAT_O(wb_hex_dat_o),
					.WE_I(wb_hex_we_i),
					.SEL_I(wb_hex_sel_i),
					.STB_I(wb_hex_stb_i),
					.ACK_O(wb_hex_ack_o),
					.CYC_I(wb_hex_cyc_i),

					//-------------------------------------
					// HEX
					.HEX0(HEX0),
					.HEX1(HEX1),
					.HEX2(HEX2),
					.HEX3(HEX3),
					.HEX4(HEX4),
					.HEX5(HEX5),
					.HEX6(HEX6),
					.HEX7(HEX7)
				);
endmodule
