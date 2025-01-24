// LCD Reset Module
// Module that takes care of the reset TFT LCD reset characteristic.
// Timing characteristic are hace been developed from this source:
// https://github.com/gHuwk/FPGA-OMDAZZ-CYCLONE4/blob/main/Examples/Altera-Cyclone-IV-board-V3.0-master/Module%20information/2.4%20inch%20TFT/ILI9325DS_V0.29_2007-08-21-15-12-29-179.pdf
// Page 108 of pdf. Section 14.3. Reset Timing Charateristics.
// For verification simulate the the Testbench file in the scr/sim folder. You may the stop the simulation at around 6ms.
// Created by Reeve Fernandes


// module for intiating reset using SPI protocol with OMDAZZ 2.4" TFT LCD

// visual verifcation 
module LCD_rst(

	input clk,
	input rst_n,
	input en_i,
	output reg done_o,
	output reg lcd_rst_n_o // n means low level reset

);



reg state_done; 

reg [3:0] flow_ctrl;

reg [23:0] delay_cnt;
reg [23:0] delay_cnt_2;

//reg en_i = 1'b1;

localparam TIME_1MS  	= 50_000, 		 // 1ms - 1_000_000ns clock numbers = 1_000_000 / 20 = 50_000;
			  TIME_120MS	= 6_000_000,	//120ms = 120_000_000ns clock numbers = 120_000_000 / 20 = 6_000_000
			  TIME_2S		= 1_000_000_000; //2S 

reg [2:0] cur_state;
reg [2:0] next_state;

 

localparam	IDLE = 3'b001,
				LCD_RST = 3'b010,
				DONE = 3'b100;
				

//1st always block. moving current state to next state.
always @(posedge clk ) begin  // change or posedge rst_n
	if (rst_n)
		cur_state <= IDLE;
	else
		cur_state <= next_state;
end

// 2nd always block. defining the next state which will be assigned to cur above
always @(*) begin
	case (cur_state)
		IDLE:
			if(!en_i) // change here to check
				next_state <= LCD_RST;
 			else
				next_state <= IDLE;
				
		LCD_RST:
			if(state_done == 1'd1)
				next_state <= DONE;
			else
				next_state <= LCD_RST;
				
		DONE:
			if(done_o == 1'd0) begin
				delay_cnt_2 <= delay_cnt_2 + 24'd1;
				if (delay_cnt_2 == TIME_1MS) begin	// delay 1ms
					delay_cnt_2 <= 24'd0;
					next_state <= IDLE;
				end
			end
			else
				next_state <= DONE ;
			 
		default:
				next_state <= IDLE;
	endcase
end


//3rd always block. Giving task to every state
always @(posedge clk ) begin // change or posedge rst_n
	if(rst_n)
		idle_task;
	else
		case (next_state)
			IDLE:
				idle_task;
				
			LCD_RST:
				lcd_rst_task;
				
			DONE:
				done_task;
				
			default: idle_task;
		endcase
end


// defining tasks below

//idle task

task idle_task;
	begin
		lcd_rst_n_o <= 1'b1;
		done_o <= 1'b1; // 1 is off for LED
		flow_ctrl <= 4'd0;
		delay_cnt <= 24'd0;
		state_done <= 1'b0;
	end
endtask

//lac_rst_task


task lcd_rst_task;
	begin
		state_done <= 1'b0;
		case (flow_ctrl)
			
			4'd0:
				begin
					lcd_rst_n_o <= 1'b1;		// reset =1
					flow_ctrl <= 4'd1;
				end
				
				
			// the TFT that we use for the board, this 1ms delay is not required. However,
			// it does not hurt to have at this stage and makes the simulation easy.
				
			4'd1: 
				begin
					delay_cnt <= delay_cnt + 24'd1;
					if (delay_cnt == TIME_1MS) begin		//1ms delay
						delay_cnt <= 24'd0;
						flow_ctrl <= 4'd2;
					end  
				end
				
				
				
			4'd2:
				begin
					lcd_rst_n_o <= 1'b0;
					flow_ctrl <= 4'd3;
				end
				
				
			//the next delay here is techincally  required in the OMDAZZ TFT LCD screen, however,
				
			4'd3:
				begin
					delay_cnt <= delay_cnt + 24'd1;
					if (delay_cnt == TIME_1MS) begin	// delay 1ms
						delay_cnt <= 24'd0;
						flow_ctrl <= 4'd4;
					end
				end
				
				
				
			4'd4:
				begin
					lcd_rst_n_o <= 1'b1;
					flow_ctrl <= 4'd5;
				end
				
				
				
			4'd5:
				begin
					delay_cnt <= delay_cnt + 24'd1;
					if (delay_cnt == TIME_1MS) begin
						delay_cnt <= 24'd0;
						flow_ctrl <= 4'd6;
					end
				end
					
					
			4'd6:
				begin  
					state_done <= 1'b1;
					flow_ctrl <= 4'd0;
				end
				
		endcase
	end
endtask


// done_task
task done_task;
	begin
		done_o <= 1'b0; //come here to change. 0 for LCD is on
		// removed something from here. removed the en singal
	end
endtask

endmodule
					


