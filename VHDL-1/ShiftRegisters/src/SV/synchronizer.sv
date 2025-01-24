//synchronizer


module sync (

	input		logic		clk,
	input		logic		insig,
	output	logic		outsig


);

logic interm;

always @(posedge(clk)) begin

	interm = insig;
	outsig = interm;



end


endmodule 