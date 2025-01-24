// spi driver test bench
`define clk_period 20

module spi_driver_tb();

reg clk, rst_n;

reg en_i;
reg [8:0] data_i;
wire cs, dc, scl, sda, done_o;

spi_driver SPI_DRIVER(

	.clk(clk),
	.rst_n(rst_n),
	
	.en_i(en_i),
	.data_i(data_i),
	.done_o(done_o),
	
	.lcd_cs_o(cs),
	.lcd_dc_o(dc),
	
	.lcd_scl_o(scl),
	.lcd_sda_o(sda)

);

initial clk = 1'b1;
always #(`clk_period/2) clk = ~clk;


initial begin

	en_i = 1'b0;
	rst_n = 1'b1;
	data_i = 9'b1_0101_1010;
	
	#(`clk_period);
	rst_n = 1'b1; // reset system
	
	#(`clk_period);
	rst_n = 1'b1;
	
	#(`clk_period);
	en_i = 1'b1;
	
	#(`clk_period);
	en_i  = 1'b0;

end

endmodule