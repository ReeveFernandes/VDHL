-- Modified ShiftRegister

-- Shift Register (VHDL)
-- Created 10/18/2022. Modifies Lakshman (Udemy) code by Reeve Fernandes
-- Purpose: to impliment Shift Register concept and syncronization of async input.

library ieee;
use ieee.std_logic_1164.all;

entity ModShiftRegisters is											--	Declares all the ports to be used.
port(
	
	rst	:	in	std_logic;
	clk	:	in std_logic;	
	led	:	out std_logic_vector(1 to 4)

);

end entity;

architecture rtl of ModShiftRegisters is							--	Uses the above declared ports.

																				-- Signals which will manipulated in
																				-- process blocks are declared below.
																				
signal ButtonPressed		:	std_logic;								-- Goes high when button is presed trigger
																				--	the Shift in Register.
																				
signal ShiftReg			:	std_logic_vector(1 to 4);			-- Main signal that outputs the LEDs.

signal tick					:	std_logic := '0';						-- Signal used to  synchronize the 
																				-- async input of the switch.
																				
signal delayed_switch	:	std_logic;								-- This delayed input is used to capture
																				-- the falling edge of the synchronized
																				-- switch signal.
																				
variable count 			:	integer range 0 to 50000001 := 0;-- counter for replacing switch

begin

	led <= ShiftReg;														-- Assining the changes of ShiftReg into
																				-- LED vector for display.
	
	
	
	tickTimer : process(clk)
		begin
			if rising_edge(clk) then 
				count := (count + 1);
				if count = 50000000 then
					tick <= '1';
					count := 0;
				end if;
			end if;
		end process;
																				-- This next process block uses
																				-- the synced input signal to 
																				-- assert the ButtonPressed signal
																				-- which will used in the next block
																				-- to shift the register.
																				
																				-- This is done by checking the falling
																				-- edge of the switch signal. Which is acheived
																				-- by generating a delayed signal with the past value;
	

	ButtonPressDetect:process(rst,clk)
	begin
		
		if rst = '0' then
			delayed_switch <= '0';
			ButtonPressed <= '0';
		elsif rising_edge(clk) then
		
			delayed_switch <= tick;									-- Athough this is assigned here, the variable
																				-- only takes the value assigned to it in the
																				--	the next clock cycle.
																				
			if tick = '1' and delayed_switch = '0' then		-- This is why this if statement can be executed 
																				-- because delay_switch flip flop hasnt outputted
																				-- the data in this clock cycle yet.
				ButtonPressed <= '1';
			else
				ButtonPressed <= '0';
			end if;
		
		end if ;
	
	end process;
	
																				-- This final Process block assigned the value 
																				-- of one reigster the value of the following one.
	
	ShiftProcess:process(rst,clk)
	begin
		
		if rst = '0' then
			ShiftReg <= "0111";
		elsif rising_edge(clk) then
			if ButtonPressed = '1' then
				ShiftReg <= ShiftReg(4) & ShiftReg(1 to 3);
				
			end if;
		end if ;
	
	end process;



end rtl;