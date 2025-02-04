library ieee;										-- Call the main library
use ieee.std_logic_1164.all;					-- Call all the libraries within the std_logic

-- The Entity block takes a name and 
-- defines the ports for the module to 
-- work with. These ports are then used in
-- following architecture part to provide
-- the circuit logic

entity SwitchDrivesLED is						-- Declare Entity name
port													-- Defines ports
(
	sw1	:	in std_logic;						-- port name : in/out type;
	led1	:	out std_logic						-- port name : in/out type;
);
end entity;

-- The Architecture block sets the
-- circuit logic with the ports 
-- defines above.
-- Generally, architeture block has 
-- two parts: signal declaration
-- and circuit logic.
-- The third optional section are 
-- varriable number of process blocks.

architecture rtl of SwitchDrivesLED is		-- Declare Architecture Block with name
begin													-- Begin logic block here
	
	led1 <= sw1;
	
end rtl;