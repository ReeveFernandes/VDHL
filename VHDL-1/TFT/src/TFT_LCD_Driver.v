// TFT_LCD_Driver Second Version
module TFT_LCD_Driver(	
	input 		clk,
	input 		rst_n,	// low assert
	input 		en_i,		// low assert
	input [7:0] data_i,
	input 		stop_flag,
	
	output reg lcd_cs_o,
	output reg lcd_scl_o,
	output reg lcd_sda_o
);

reg [3:0] cnt;
reg [1:0] cur_state;
reg [1:0] next_state;
reg		 str_done;
reg 		 wr_done;
reg		 end_done;
reg [2:0] start_flow_ctrl;
reg [2:0] wr_flow_ctrl;
reg [2:0] bit_id;


`define SCL_LOW_MID	(cnt == 4'd2)
`define SCL_POS_EDG	(cnt == 4'd4)
`define SCL_HIG_MID	(cnt == 4'd6)
`define SCL_NEG_EDG	(cnt == 4'd0)

localparam
				IDLE 		= 2'b00,
				START 	= 2'b01,
				LCD_WR 	= 2'b10,
				DONE 		= 2'b11;


initial begin
	cnt 			= 0;
	lcd_cs_o 	= 1;
	lcd_scl_o 	= 0;
	lcd_sda_o 	= 0;
	bit_id		= 3'd7;
end

always @(posedge clk or negedge rst_n) begin
		if (!rst_n)
			cnt <= 0;
		else if (cnt == 4'd7)
			cnt <= 0;
		else
			cnt <= cnt + 4'd1;
end



always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		lcd_scl_o <= 1'b0;
	else if (`SCL_POS_EDG)
		lcd_scl_o <= 1'b1;
	else if (`SCL_NEG_EDG) 
		lcd_scl_o <= 1'b0;
end



always @(posedge clk or negedge rst_n) begin
	if (!rst_n)
		cur_state <= IDLE;
	else
		cur_state <= next_state;
end




always @(*) begin
	case (cur_state)
		IDLE:
			if (en_i)
				next_state <= START;
			else
				next_state <= IDLE;
				
		START:
			if (str_done)
				next_state <= LCD_WR;
			else
				next_state <= START;
				
		LCD_WR:
			if (wr_done)
				next_state <= DONE;
			else
				next_state <= LCD_WR;
		
		DONE:
			if (end_done)
				next_state <= IDLE;
			else
				next_state <= DONE;
			
		default: next_state <= IDLE;
		
	endcase
end

always @(posedge clk or negedge rst_n) begin

	if (!rst_n)
		idle_task;
	else
		case (next_state)
			IDLE:
				idle_task;
				
			START:
				start_task;
				
			LCD_WR:
				lcd_wr_task;
				
			DONE:
				done_task;
				
			default: idle_task;
		endcase
end

task idle_task;
	begin
		str_done 			<= 0;
		wr_done 				<= 0;
		end_done				<= 0;
		lcd_cs_o	 			<=	1;
		lcd_sda_o 			<= 0;
		start_flow_ctrl	<= 0;
		wr_flow_ctrl		<= 0;
		bit_id				<= 3'd7;
	end
endtask



task start_task;
	begin
	str_done <= 0;
	bit_id <= 3'd7;
	case (start_flow_ctrl)
		3'd0:
			if (`SCL_NEG_EDG) begin
				lcd_cs_o 			<= 0;
				lcd_sda_o 			<= 0;
				start_flow_ctrl 	<= 3'd1;
			end
			
		3'd1:
			if (`SCL_NEG_EDG) begin
				lcd_sda_o 			<= 1;
				start_flow_ctrl 	<= 3'd2;
			end
			
		3'd2:
			if (`SCL_NEG_EDG) begin
				lcd_sda_o 			<= 1;
				start_flow_ctrl 	<= 3'd3;
			end
			
		3'd3:
			if (`SCL_NEG_EDG) begin
				lcd_sda_o 			<= 1;
				start_flow_ctrl 	<= 3'd4;
			end
			
		3'd4:
			if (`SCL_NEG_EDG) begin
				lcd_sda_o 			<= 0;
				start_flow_ctrl 	<= 3'd5;
			end
			
		3'd5:
			if (`SCL_NEG_EDG) begin
				lcd_sda_o 			<= 0;
				start_flow_ctrl 	<= 3'd6;
			end
			
		3'd6:
			if (`SCL_NEG_EDG) begin
				lcd_sda_o 			<= 1;
				start_flow_ctrl 	<= 3'd7;
			end
			
		3'd7:
			if (`SCL_NEG_EDG) begin
				lcd_sda_o 			<= 0;
				str_done				<= 1;
			end
		endcase	
	end
endtask

task lcd_wr_task;
	begin
		wr_done <= 0;
		case (wr_flow_ctrl)
		
			3'd0:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					wr_flow_ctrl		<= 3'd1;
				end
				
			3'd1:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					wr_flow_ctrl		<= 3'd2;
				end
				
			3'd2:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					wr_flow_ctrl		<= 3'd3;
				end
				
			3'd3:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					wr_flow_ctrl		<= 3'd4;
				end
				
			3'd4:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					wr_flow_ctrl		<= 3'd5;
				end
				
			3'd5:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					wr_flow_ctrl		<= 3'd6;
				end
				
			3'd6:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					wr_flow_ctrl		<= 3'd7;
				end
					
			3'd7:
				if (`SCL_NEG_EDG) begin
					lcd_sda_o 			<= data_i[bit_id];
					bit_id 				<= bit_id - 3'b1;
					if (stop_flag)
						wr_done			<= 1;
					else
						wr_flow_ctrl 	<=	3'b1;
				end
		endcase
	end
endtask

task done_task;
	begin
		lcd_cs_o <= 1;
		end_done <= 1;
	end
endtask


endmodule
