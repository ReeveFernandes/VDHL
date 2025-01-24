-- State Machine tutorial using MKR VIDOR 4000 (intel Cyclone 10 LP FPGA chip).
-- Source from Udemy course "Learn FPGA Design With VHDL (Intel/Altera)"
-- implimented by instructor Lakshman Athukorala on Cyclone V chip (cyclone V development board)
-- Update to fit Cyclone 10 LP by Reeve Fernandes
-- Description: This file demonstrates an VHDL design of a state machine. The origional design switches state on 
--		on the click of different button and is indidicated with the change in LED. Since MKR VIDOR does not have switched
--		the change in state will occur after a set Clock cycles.
-- Things learned: basics of state machine, impliment process block in architecture. PLL implimentation from IP catalog.


--Review by Mr. Weng 8/29/22:
-- multiple inputs are usual required
-- different input leads to diffrent states, That usually need lookup tables/ transition table.
-- This one has 1 input, and 3 states. Table is hard coded.
-- generally, need 2 inputs, 3 states, transition table is read from other sourse (can be hard coded too)
-- draw diagram to understand function of statemachine because transition table is not intuitive.

-- recommendation by Mr. Weng:
-- purchase buttons and LED.

--
--Notes:
--finish PLL block (2 seprate clocks) :::::: Hault for now
--in proccess wrtie logic to change state at x cycles  ::::: testing varibale :::: passes analysis ::: end to check
--pin assignment
--simulation/ test bench
--compile and upload


-- Updates:
-- 20/6/2022 : all bugs solved. Issue with the range of interger. Increaded number up to 150 million to slow down. Things learned from: Case in VHDL
-- and their parallel property. and state transition. Additional error with Clock pin assignment. Solved by changing pin to E2 (FPGA usingMicrocontroller)
-- clock. More info: https://forum.arduino.cc/t/what-the-pin-number-for-the-mkr-vidor-4000-fpga-clock/1038460

--Other resources used for this project:
-- VHDL course: https://www.udemy.com/course/learn-fpga-design-with-vhdl/learn/lecture/24098072?start=360#overview
-- Arduino documentation: https://docs.arduino.cc/hardware/mkr-vidor-4000   (scroll all the way for board documentation)


library ieee;														--	Declare Library
use ieee.std_logic_1164.all;									-- declare std_logic_1164.all library for relevent data types

entity StateMachine is											-- Create main entity
port																	-- decalre ports to be used in architecture: require only clk and led
(
	
	rst	:	in std_logic;
	clk	:	in std_logic;
	led	:  out std_logic_vector(2 downto 0)			-- There arent in-built LED also. LED circuit is created using board pins.
																		-- check pin assignment for the same.
																		
																		
																		
	--sw		:	in std_logic_vector(3 downto 0);			-- Tutorial was made on Cyclone V Development board. However, Boarded
																		--	used was MKR VIDOR 4000 by arduino, which does not have inbuilt button.
	

);
end entity;

architecture rtl of StateMachine is							-- define architeture using ports from entity

type DataTypeofSMState is (STATE1, STATE2, STATE3);	--	declare new data-type for state machine
signal StateVariable	:	DataTypeofSMState;				--	decalre signal with state machine data type 





begin																	--	begin

	Process1	:	process(clk)									-- impliment process block to switch between states.
																		-- process block only work when any of the signals in the Sensitivity list change.
		  															   -- change. In this case, the CLK signal.
																	
	variable count : integer range 0 to 200000001 := 0;
																		
	begin
	
			
		
		
		if rising_edge(clk)	then								-- at every rising clock edge there is check for updated signal
		
		led <= "000";
		count := (count + 1);
		
			case StateVariable is								-- Providing different cases for different state of the machine
																		-- states: 1, 2, 3
			
				when STATE1 =>										-- When State machine is in state 1 the LED states are as following
					led(0) <= '1';									--	Enable
					led(1) <= '0';									--	Disbale
					led(2) <= '0';									-- Disable
				

				if count = 150000000 then
					StateVariable <= STATE2;
					count := 0;

				end if;
				
																		-- following section in all states are commented out due to inapplicibility to MKR VIDOR.
					
--					if sw(1) = '0' then							-- During when the state machine is in state 1; if a button one is pressed
--																		-- the state moves to a new state
--						StateVariable <= STATE2;
--					end if;
					
																		--	Same procedure is followed for the other states as well:
																		-- 1 -> 2; 2 -> 3; 3 -> 1
				
				
				when STATE2 =>
					led <= "010";
					
--					if sw(2) = '0' then
--						StateVariable <= STATE3;
--					end if;

					if count = 150000000 then
						
						StateVariable <= STATE3; 
						count := 0;
					end if;
					
					
					
				
				when STATE3 =>
					led <= "100";
					
--					if sw(3) = '0' then
--						StateVariable <= STATE1;
--					end if;

					if count = 150000000 then
						StateVariable <= STATE1;
						count := 0;
					end if;
					
				
				
				
				when others =>										-- In the occation that a wrong state or error is entered. it reset to state 1.
					StateVariable <= STATE1;
			
			
			
			
			end case;
		
		end if;
	
	end process;
end rtl;


--use case instead of if/esle
--how does case work (series or parallel)