module StateMachine (

    input   logic         clk,
    input   logic         rst,
    output  logic   [2:0] led

);

initial begin
    logic count = 0;
    led[0] <= 0;
    led[1] <= 0;
    led[2] <= 0;
end


always @(posedge clk) begin
    
    count = (count + 1);

    if (count == 500000000) begin
        count = 0;
        led[0] <= 1;
        led[1] <= 0;
        led[2] <= 0;     
    end
    
    if (count == 500000000) begin
        count = 0;
        led[0] <= 1;
        led[1] <= 1;
        led[2] <= 0;  
    end

    if (count == 500000000) begin
        count = 0;
        led[0] <= 1;
        led[1] <= 1;
        led[2] <= 1;  
    end

end

endmodule