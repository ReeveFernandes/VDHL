-- Shift Register (VHDL)
-- Created 10/18/2022. Modifies Lakshman (Udemy) code by Reeve Fernandes
-- Purpose: to impliment Shift Register concept and syncronization of async input.

library ieee;
use ieee.std_logic_1164.all;

entity ShiftRegisters is												--	Declares all the ports to be used.
port(
	
	rst	:	in	std_logic;
	clk	:	in std_logic;	
	sw1	:	in	std_logic;	
	led	:	out std_logic_vector(1 to 4)

);

end entity;

architecture rtl of ShiftRegisters is											--	Uses the above declared ports.

																							-- Signals which will manipulated in
																							-- process blocks are declared below.
																				
signal ButtonPressed		:	std_logic;											-- Goes high when button is presed trigger
																							--	the Shift in Register.
																				
signal ShiftReg			:	std_logic_vector(1 to 4);						-- Main signal that outputs the LEDs.

signal sync					:	std_logic_vector(1 downto 0);					-- Signal used to  synchronize the 
																							-- async input of the switch.
																				
signal delayed_switch	:	std_logic;											-- This delayed input is used to capture
																							-- the falling edge of the synchronized
																							-- switch signal.
																					
signal counter 			:	integer;												-- This is counter for the debouncing

constant DebouncePeriod :	integer := 2500000;								-- Threshold for the deboudcing

signal debounced_switch	:	std_logic;											--cleared up output

begin

	led <= ShiftReg;																	-- Assining the changes of ShiftReg into
																							-- LED vector for display.
																							
																							
																							-- The following Process block syncs the 
																							-- switch input with the clock cycle.
																							
																							-- This is done by using two flip-flop 
																							-- and their values will be assigned to 
																							-- each other at consequent clock cycles.
																							
																							-- Note: This process causes a 2 clock cycle
																							-- which is negligible.

	SyncProcess:process(rst,clk)										
	begin
		
		if rst = '0' then
			sync <= "11";
		elsif rising_edge(clk) then
			sync(0) <= sw1;															-- sw1 : input from the switch
			sync(1) <= sync(0);														-- sync(1): synced form of sw1
		end if;
	
	end process;
	
	
	
	
		DebounceProcess:process(rst,clk)										
	begin
		
		if rst = '0' then
			counter <= 0;
			debounced_switch <= '1';
		elsif rising_edge(clk) then
				if sync(1) = '0' then
					if counter < DebouncePeriod then
						counter <= counter + 1;
					end if;
				else
					if counter > 0 then
						counter <= counter - 1;
					end if;
				end if;
				
				if counter = DebouncePeriod then
					debounced_switch <= '0';
				elsif counter = 0 then
					debounced_switch <= '1';
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
			delayed_switch <= '1';
			ButtonPressed <= '0';
		elsif rising_edge(clk) then
		
			delayed_switch <= debounced_switch;									-- Athough this is assigned here, the variable
																							-- only takes the value assigned to it in the
																							--	the next clock cycle.
																				
			if debounced_switch = '0' and delayed_switch = '1' then		-- This is why this if statement can be executed 
																							-- because delay_switch flip flop hasnt outputted
																							-- the data in this clock cycle yet.
				ButtonPressed <= '1';
			else
				ButtonPressed <= '0';
			end if;
		end if ;
	
	end process;
	
																							-- This final Process block assigned the value 
																							-- of one reigster the value of the following one,.s
	
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