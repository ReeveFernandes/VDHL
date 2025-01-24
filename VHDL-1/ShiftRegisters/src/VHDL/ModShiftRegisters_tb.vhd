-- TESTBENCH (VHDL) FOR ModShiftRegisters

library ieee;
use ieee.std_logic_1164.all;

entity ModShiftRegisters_tb is											--	Declares all the ports to be used.
end entity;

architecture rtl of ModShiftRegisters_tb is

	signal rst	:	std_logic := '1';
	signal clk	:	std_logic := '0';	
	signal led	:	std_logic_vector(1 to 4);
	
	component ModShiftRegisters is											--	Declares all the ports to be used.
	port(
		
		rst	:	in	std_logic;
		clk	:	in std_logic;	
		led	:	out std_logic_vector(1 to 4)

	);

	end component;


	begin
	
	
	
	clk <= not clk after 10ns;

	
	DUT : component ModShiftRegisters											--	Declares all the ports to be used.
	port map(
		
		rst	=> rst,
		clk	=> clk,	
		led	=> led

	);
	
	
	

	end rtl;