// This file will try to implememnt input driven State Machine

module StateMachine (

    input   logic         clk,
    input   logic         sw,
    output  logic   [2:0] led

);


int state = 0;

initial begin
    led[0] <= 0;
    led[1] <= 0;
    led[2] <= 0;
end




always @(posedge clk) begin
    
	 
	 if (sw == 0) begin
		state = (state + 1);
		
		if (state == 1) begin
	 
        led[0] <= 1;
        led[1] <= 0;
        led[2] <= 0;    
		  
    end
    
    if (state == 2) begin

        led[0] <= 1;
        led[1] <= 1;
        led[2] <= 0;  
		  
    end

    if (state == 3) begin
        
        led[0] <= 1;
        led[1] <= 1;
        led[2] <= 1;  
    end
	 
	 end

    

end

endmodule