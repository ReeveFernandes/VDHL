// TFT_LCD_Driver Second Version
module TFT_LCD_Driver(
//
//	input clock,
//	input chipSelect,
//	input DataIn,
//	
//	
//	output reg CS,
//	output reg CLK,
//	output reg SDI,
//	
//	input SDO 
	
	input clk,
	input rst_n,
	
//	input en_i,
	input [8:0] data_i,
	output reg done_o,
	
	output reg lcd_cs_o,  // chip select
	input  lcd_sda_i,  // command or data flag same as RS pin from schematic
	
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


// clock divider
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		lcd_scl_o <= 1'b0;
	else if (`SCL_POS_EDG)
		lcd_scl_o <= 1'b1;
	else if (`SCL_NEG_EDG)
		lcd_scl_o <= 1'b0;
end







endmodule


//reg [2:0] cur_state;
//reg [2:0] next_state;
//reg [3:0] flow_ctrl;
//reg start_done = 0;
//
//localparam
//				START = 3'b001,
//				DONE = 3'b010;
//
//
//	
//always@(*) begin
//	
//	CLK <= clock;
//	CS <= chipSelect;
//	
//end
//
//always @(posedge clock) begin
//		cur_state <= next_state;
//end
//
//always @(*) begin
//	case (cur_state)
//		START:
//			if (start_done)
//				next_state <= DONE;
//			else
//				next_state <= START;
//				
//		DONE:
//			next_state <= DONE;
//			
//		default: next_state <= START;
//		
//	endcase
//end
//
//always @(posedge clock) begin
//	
//	if (!CS) begin
//	
//		case (next_state)
//			START:
//				start_task;
//				
//			DONE:
//				done_task;
//				
//			default: start_task;
//		endcase
//	
//	end
//end
//
//task start_task;
//
//	if (!CS) begin
//	
//		start_done <= 0;
//		
//		// start bit 011100
//		case(flow_ctrl)
//			
//			0:
//				begin
//					SDI <= 0;
//					flow_ctrl <= 1;
//				end
//				
//			1:
//				begin
//					SDI <= 1;
//					flow_ctrl <= 2;
//				end
//				
//			2:
//				begin
//					SDI <= 1;
//					flow_ctrl <= 3;
//				end
//				
//			3:
//				begin
//					SDI <= 1;
//					flow_ctrl <= 4;
//				end
//				
//			4:
//				begin
//					SDI <= 0;
//					flow_ctrl <= 5;
//				end
//				
//			5:
//				begin
//					SDI <= 0;
//					flow_ctrl <= 6;
//				end
//				
//			6:
//				start_done <= 1;
//			
//		endcase
//
//	end
//	
//endtask
//
//task done_task; 
//	
//	if (start_done) begin
//		
//		SDI <= 1;
//		
//	end
//endtask


