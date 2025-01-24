// LCD Reset Test bench 
// Module test the functionality of LCD Reset  

// for testing in Quartus Prime Software using Questa FPGA (provided by intel along with prime software);
// 1. Tools -> Options -> EDA Tool options 

`timescale 1ns/1ps
`define clk_period 20

module lcd_rst_tb();


	// declaring variables to trace in waveform
	reg clk, rst_n, en_i;
	wire done_o, rst_o;

	// instantiate module
	// en_i removed for testing puposes. PLEASE PUT IT BACK AFTER
	LCD_rst rst(.clk(clk), .rst_n(rst_n), .en_i(en_i), .done_o(done_o), .lcd_rst_n_o(rst_o));
	
	//simulate clock
	initial clk = 1;
	always #(`clk_period/2) clk = ~clk;
	
	// play with the inputs to test all possibilties 
	initial begin
		rst_n = 1;
		en_i = 1;
		
		#(`clk_period); 
		rst_n = 0;
		
		
		#(`clk_period);
		en_i = 0; 	// this should trigger it 
		
//		#(`clk_period);
//		//rst_n = 1;
//		/
		
		#(`clk_period);
		en_i = 1;
		
	end
	
	
endmodule