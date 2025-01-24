//SPI driver

module spi_driver(

	input clk,
	input rst_n,
	
	input en_i,
	input [8:0] data_i,
	output reg done_o,
	
	output reg lcd_cs_o,  // chip select
	output reg lcd_dc_o,  // command or data flag same as RS pin from schematic
	
	output reg lcd_scl_o, // clock
	output reg lcd_sda_o  // data

);

reg state_done;


reg [3:0] bit_id;
reg [3:0] flow_ctrl;


reg [3:0] cnt;


always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		cnt <= 4'd0;
	else if (cnt == 4'd7)
		cnt <= 4'd0;
	else
		cnt <= cnt + 4'd1;
end


`define SCL_LOW_MID	(cnt == 4'd2)
`define SCL_POS_EDG	(cnt == 4'd4)
`define SCL_HIG_MID	(cnt == 4'd6)
`define SCL_NEG_EDG	(cnt == 4'd0)

// Alternate way:
//		dont need to change clock, there is one clock.
//		increase speed if needed

// clock divider
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		lcd_scl_o <= 1'b0;
	else if (`SCL_POS_EDG)
		lcd_scl_o <= 1'b1;
	else if (`SCL_NEG_EDG)
		lcd_scl_o <= 1'b0;
end


reg [2:0] cur_state;
reg [2:0] next_state;


localparam
				IDLE = 3'b001,
				LCD_WR = 3'b010,
				DONE = 3'b100;
				

// 1st always block
// responsible for switching states by assigning cur state
// the value of next_state, which keeps changing
always @(posedge clk or negedge rst_n) begin
	if (!rst_n)
		cur_state <= IDLE;
	else
		cur_state <= next_state;
end


//2ns always block

always @(*) begin
	case (cur_state)
		IDLE:
			if (en_i)
				next_state <= LCD_WR;
			else
				next_state <= IDLE;
				
		LCD_WR:
			if (state_done == 1'd1)
				next_state <= DONE;
			else
				next_state <= LCD_WR;
				
		DONE:
			next_state <= IDLE;
			
		default: next_state <= IDLE;
		
	endcase
end

//3rd always block
// Assigning task to the the state
always @(posedge clk or negedge rst_n) begin
	if (!rst_n)
		idle_task;
	else
		case (next_state)
			IDLE:
				idle_task;
				
			LCD_WR:
				wr_byte_task;
				
			DONE:
				done_task;
				
			default: idle_task;
		endcase
end

task idle_task;
	begin
		lcd_cs_o <= 1'b1;
		lcd_dc_o <= 1'b0;
		lcd_sda_o <= 1'b0;
		
		bit_id <= 4'd8;
		flow_ctrl <= 4'd0;
		
		done_o <= 1'b0;
		state_done<= 1'b0;
		
	end
endtask


task wr_byte_task;
	begin
		state_done <= 1'b0;
		case (flow_ctrl)
			
			4'd0:
				if (`SCL_NEG_EDG) begin
					lcd_cs_o <= 1'b0;
					lcd_dc_o <=data_i[bit_id];
					bit_id <= bit_id - 4'd1;
					flow_ctrl <= 4'd1;
				end
			
			4'd1:
				if (`SCL_LOW_MID) begin
					lcd_dc_o <= data_i[bit_id];
					bit_id <= bit_id - 4'd1;
					flow_ctrl <= 4'd2;
				end
				
			4'd2:
				if (bit_id == 4'd15) begin
					bit_id <= 4'd8;
					flow_ctrl <= 4'd3;
				end else
					flow_ctrl <= 4'd3;
					
			4'd3:
				if (`SCL_NEG_EDG) begin
					lcd_cs_o <= 1'b1;
					lcd_dc_o <= 1'b0;
					flow_ctrl <= 4'd0;
					state_done <= 1'b1;
				end
				
			default:
				flow_ctrl <= 4'b0;
			
		endcase
	end
endtask


task done_task;
	begin
		done_o <= 1'b1;
	end
endtask
			

endmodule

