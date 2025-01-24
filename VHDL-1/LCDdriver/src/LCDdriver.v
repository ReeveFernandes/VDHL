//LCDdriver
module lcd_driver(
	
	input clk,
	input rst_n,
	
	output reg [1:0] en_o,
	output reg [8:0] data_o,
	input [1:0] done_i
);

localparam	RED = 16'hf800,
				GREEN = 16'h07e0,
				BLUE = 16'h001f,
				BLACK = 16'h0000,
				WHITE = 16'hffff;
				
reg [7:0] x_cnt, y_cnt;

localparam LCD_W = 8'd132,
			  LCD_H = 8'd162;
			  
reg state_done;

reg [7:0] reg_id;
reg [8:0] reg_init [72:0];

reg [8:0] reg_setxy [10:0];

reg [3:0] flow_ctrl;
reg [3:0] flow_sub_ctrl;


reg [27:0] delay_ctrl;
localparam TIME_120MS = 6_000_000,
			  TIME_3S	 = 150_000_000;
			  
localparam PIC_X =0,
			  PIC_W = 128,
			  PIC_Y= 0,
			  PIC_H = 35,
			  array_len = 4480;
			  
(* ramstyle = "M9K" *) reg [15:0] pic_data_array [array_len -1 : 0];
reg [15:0] pic_id;
reg [15:0] pic_data;



initial 
begin
	$readmemh("C:\\Users\\prins\\Desktop\\GENISAMA\\LCDdriver\\Bmp2Hex\\emojiCovet.bmp.txt", pic_data_array);
end


always @ (posedge clk)
begin 
	pic_data <= pic_data_array[pic_id];
end


reg [5:0] cur_state;
reg [5:0] next_state;


localparam
				 IDLE = 6'b00_0001,
				 LCD_RST = 6'b00_0010,
				 LCD_INIT = 6'b00_0100,
				 DISP_RGB = 6'b00_1000,
				 DISP_PIC = 6'b01_0000,
				 DONE = 6'b10_0000;
				 
				 
// 1st alwyas block

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
			next_state <= LCD_RST;
			
		LCD_RST:
			if (state_done ==1'd1)
				next_state <= LCD_INIT;
			else
				next_state <= LCD_RST;
				
		LCD_INIT:
			if (state_done == 1'd1)
				next_state <= DISP_RGB;
			else
				next_state <= LCD_INIT;
				
		DISP_RGB:
			if (state_done == 1'd1)
				next_state <= DISP_PIC;
			else
				next_state <= DISP_RGB;
				
		DISP_PIC:
			if (state_done == 1'd1)
				next_state <= DONE;
			else
				next_state <= DISP_PIC;
				
		DONE:
			next_state <= DONE;
			
		default :
			next_state <= IDLE;
			
		endcase

end
			

task idle_task;
    begin
        state_done <= 1'b0;

        en_o <= 2'd0;
        data_o <= 9'd0;

        reg_id <= 8'd0;
        delay_ctrl <= 28'd0;

        flow_ctrl <= 4'd0;
        flow_sub_ctrl <= 4'd0;

        x_cnt <= 8'd0;
        y_cnt <= 8'd0;

        pic_id <= 16'd0;
        init_reg_task;
    end
endtask

task lcd_rst_task;
	begin
		state_done<=1'b0;
		case (flow_ctrl)
			4'd0:
				begin 
					en_o[0] <= 1'b1;
					flow_ctrl <= 4'd1;
				end
				
			4'd2: 
				begin
					en_o[0] <= 1'b0;
					if (done_i[0])
						flow_ctrl <= 4'd2;
				end
			
			4'd2:
				begin
					state_done <= 1'b1;
					flow_ctrl <= 4'd0;
				end
		endcase
	end
endtask
	
	
task lcd_init_task;
	begin
		state_done <= 1'b0;
		case (flow_ctrl)
			4'b0:
				begin
					data_o <= reg_init[reg_id];
					reg_id <= reg_id + 1'b1;
					en_o[1] <= 1'b1;
					flow_ctrl <= 4'd1;
				end
				
			4'd1:
				begin
					en_o[1] <= 1'b0;
					if (done_i[1]) begin
						flow_ctrl <= 4'd2;
					end				
				end
				
			4'd2:
				begin
					delay_task(TIME_120MS);
				end
				
			4'd3:
				begin
					data_o <= reg_init[reg_id];
					reg_id <= reg_id + 1'b1;
					en_o[1] <= 1'b1;
					flow_ctrl <= 4'd4;
				end
				
			4'd4:
				begin
					en_o[1] <= 1'b0;
					if (done_i[1]) begin
						if (reg_id <= 8'd72)
							flow_ctrl <= 4'd3;
						else begin
							reg_id <= 8'd0;
							flow_ctrl <= 4'd0;
							state_done <= 1'b1;
						end
					end	
				
				end
				
				default:
					flow_ctrl <= 4'd0;
			endcase
		end
		
	endtask
	

task disp_rgb_task;
begin

	state_done <= 1'b0;
	case (flow_ctrl)
		4'd0:
			lcd_set_xy_task (8'd0, LCD_W-8'd1, 8'd0, LCD_H-8'd1);
			
		4'd1:
			lcd_set_colot_task(RED, LCD_W, LCD_H);
			
		4'd2:
			delay_task(TIME_3S);
			
		4'd3:
			lcd_set_color_task_task(GREEN, LCD_W, LCD_H);
			
		4'd4:
			delay_task (TIME_3S);
			
		4'd5:
			lcd_set_color_task(BLUE, LCD_W, LCD_H);
		
		4'd6:
			delay_task(TIME_3S);
			
		4'd7:
			lcd_set_color_task (RED, LCD_W, LCD_H/4);
			
		4'd8:
			lcd_set_color_task (GREEN, LCD_W, LCD_H/4);
			
		4'd9:
			lcd_set_color_task (BLUE, LCD_W, LCD_H/4);
			
		4'd10:
			lcd_set_color_task (BLACK, LCD_W, LCD_H/4);
		
		4'd11:
			delay_task(TIME_3S);
			
		4'd12:
			lcd_set_xy_task(8'd0, LCD_W-8'd1, 8'd0, LCD_H-8'd1);
			
		4'd13:
			lcd_set_color_task (WHITE, LCD_W, LCD_H);
			
		4'd14:
			begin
				state_done <= 1'b1;
				flow_ctrl <= 4'd0;
			end
		
		default:
			flow_ctrl <= 4'd0;
		
	endcase
	
end

endtask
			

task disp_pic_task;
	begin
		state_done <= 1'b0;
		case (flow_ctrl)
			4'd0:
				lcd_set_xy_task(PIC_X, PIC_W-8'd1, PIC_Y, PIC_H-8'd1);
				
			4'd1:
				lcd_set_pic_task;
				
			4'd2:
				delay_task(TIME_3S);
			
			4'd3:
				begin
					state_done <= 1'b1;
					flow_ctrl <= 4'd0;
				end
			default: 
				flow_ctrl <= 4'd0;
		endcase
	end 
	endtask

	
task lcd_set_xy_task;
		input [7:0] x_star, x_end, y_star, y_end;
		begin
			case(flow_sub_ctrl)
			4'd0:
				begin
					reg_setxy[0] <= {1'b0,8'h2a};		//01. set x command;
					reg_setxy[1] <= {1'b1,8'h00};
					reg_setxy[2] <= {1'b1,x_star};
					reg_setxy[3] <= {1'b1,8'h00};
					reg_setxy[4] <= {1'b1,x_end};
					
					reg_setxy[5] <= {1'b0,8'h2b};		// 02. set y command;
					reg_setxy[6] <= {1'b1,8'h00};
					reg_setxy[7] <= {1'b1,y_star};
					reg_setxy[8] <= {1'b1,8'h00};
					reg_setxy[9] <= {1'b1,y_end};
					
					reg_setxy[10] <= {1'b0, 8'h2c};	//03. prepare to write RAM
					
					flow_sub_ctrl <= 4'd1;
				end
				
			4'd1:
				begin
					data_o <= reg_setxy[reg_id];		//01. set x command;
					reg_id <= reg_id + 1'b1;
					en_o[1] <= 1'b1;
					flow_sub_ctrl <= 4'd2;
				end
				
			4'd2:
				begin
					en_o[1] <= 1'b0;
					if (done_i[1]) begin
						if (reg_id <= 8'd10)
							flow_sub_ctrl <= 4'd1;
						else begin
							reg_id <= 8'd0;
							flow_sub_ctrl <= 4'd0;
							flow_ctrl <= flow_ctrl + 4'b1;
						end
					end
				end
			
			default:
				flow_sub_ctrl <= 4'd0;
		endcase
	end
endtask



task lcd_set_color_task;
	input [15:0] color;
	input [7:0] disp_w, disp_h;
	
	begin
		case(flow_sub_ctrl)
			4'd0:
				begin
					data_o <= {1'b1, color[15:8]};	//01. send the high 8 bit
					en_o[1] <= 1'b1;
					flow_sub_ctrl <= 4'd1;
				end
				
			4'd1:
				begin
					en_o[1] <= 1'b0;
					if (done_i[1])
						flow_sub_ctrl <= 4'd2;
				end
				
			4'd2:
				begin
					data_o <= {1'b1, color[7:0]};		//02. send the low 8 bit;
					en_o[1] <= 1'b1;
					flow_sub_ctrl <= 4'd3;
				end
				
			4'd3:
				begin
					en_o[1] <= 1'b0;
					if (done_i[1]) begin
						x_cnt <= x_cnt + 8'd1;
						flow_sub_ctrl <= 4'd4;
					end
				end
				
			4'd4:
				begin
					flow_sub_ctrl <= 4'd0;
					if (x_cnt == disp_w) begin
						x_cnt <= 8'd0;
						if (y_cnt == disp_h) begin
							y_cnt <= 8'd0;
							flow_ctrl <= flow_ctrl + 4'b1;	// 03. finish the set color;
						end else
							y_cnt <= y_cnt + 8'd1;
					end
				end
				
			default:
				flow_sub_ctrl <= 4'd0;
		endcase
	end
endtask

			

task delay_task;
	input [28:0] delay_time;
	begin
		delay_ctrl <= delay_ctrl + 28'd1;
		if (delay_ctrl == delay_time) begin
			delay_ctrl <= 28'd0;
			flow_ctrl <= flow_ctrl + 4'd1;
		end
	end
endtask

endmodule