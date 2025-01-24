// TFT_LCD_Driver_tb
// spi driver test bench
`define clk_period 10

module TFT_LCD_Driver_tb();

	reg 			clk;
	reg			rst_n;
	reg			en_i;
	reg	[7:0]	data_i;
	reg			stop_flag;
	
	wire 			lcd_cs_o;
	wire 			lcd_scl_o;
	wire 			lcd_sda_o;
	
	TFT_LCD_Driver tft(
		.clk(clk),
		.rst_n(rst_n),
		.en_i(en_i),
		.data_i(data_i),
		.stop_flag(stop_flag),
		.lcd_cs_o(lcd_cs_o),
		.lcd_scl_o(lcd_scl_o),
		.lcd_sda_o(lcd_sda_o)
	);
	
	
	initial begin
		clk = 1'b1;
		rst_n = 1'b1;
		en_i = 1'b0;
		data_i = 8'd170;
		stop_flag = 0;
		#20 en_i = 1;

	end
	
	always #(`clk_period/2) clk = ~clk;

	
endmodule
	
	

