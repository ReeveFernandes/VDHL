`timescale 10ns/10ns

module StateMachine_tb ();
    
reg clk;
reg rst;
reg [2:0] led ;

StateMachine DUT (
    .clk(clk),
    .rst(rst),
    .led(led)
);


always #10 clk = ~clk;



endmodule