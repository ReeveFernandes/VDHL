// shift registers TB

`timescale 10ns/1ns

module ShiftRegisters_tb ();
    
reg clk;
reg rst;
reg [4:1] leds ;

ShiftRegisters DUT (
    .clk(clk),
    .rst(rst),
    .leds(leds)
);

initial begin
	clk = 0;
end

always #10 clk = ~clk;

endmodule