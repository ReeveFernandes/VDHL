// system verilog equivalent

module ShiftRegisters ( 

	
	input		logic 		rst,
	input		logic 		clk,
	output	logic	[4:1] leds

);

int count = 0;

initial begin
	
	count = 0;
	leds[1] 	<= 1;
	leds[2] 	<= 0;
	leds[3] 	<= 0;
	leds[4] 	<= 0;


end

always @(posedge clk)
begin

			count += 1;
			if (count == 50000000)
			begin
				count = 0;
				leds[4] <= leds[3];
				leds[3] <= leds[2];
				leds[2] <= leds[1];
				leds[1] <= leds[4];
			end
			
end



endmodule 
