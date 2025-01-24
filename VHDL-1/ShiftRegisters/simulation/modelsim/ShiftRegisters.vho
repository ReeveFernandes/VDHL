-- Copyright (C) 2022  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 21.1.1 Build 850 06/23/2022 SJ Lite Edition"

-- DATE "10/20/2022 12:55:00"

-- 
-- Device: Altera 10CL016YU256C8G Package UFBGA256
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY CYCLONE10LP;
LIBRARY IEEE;
USE CYCLONE10LP.CYCLONE10LP_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_D2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_F16,	 I/O Standard: 2.5 V,	 Current Strength: 8mA


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY CYCLONE10LP;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONE10LP.CYCLONE10LP_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	ShiftRegisters IS
    PORT (
	rst : IN std_logic;
	clk : IN std_logic;
	sw1 : IN std_logic;
	led : BUFFER std_logic_vector(1 TO 4)
	);
END ShiftRegisters;

-- Design Ports Information
-- led[4]	=>  Location: PIN_J15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- led[3]	=>  Location: PIN_K16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- led[2]	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- led[1]	=>  Location: PIN_J16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_E2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rst	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw1	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF ShiftRegisters IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_rst : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_sw1 : std_logic;
SIGNAL ww_led : std_logic_vector(1 TO 4);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \rst~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \led[4]~output_o\ : std_logic;
SIGNAL \led[3]~output_o\ : std_logic;
SIGNAL \led[2]~output_o\ : std_logic;
SIGNAL \led[1]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \ShiftReg[1]~1_combout\ : std_logic;
SIGNAL \rst~input_o\ : std_logic;
SIGNAL \rst~inputclkctrl_outclk\ : std_logic;
SIGNAL \sw1~input_o\ : std_logic;
SIGNAL \sync[0]~0_combout\ : std_logic;
SIGNAL \sync[1]~feeder_combout\ : std_logic;
SIGNAL \delayed_switch~feeder_combout\ : std_logic;
SIGNAL \delayed_switch~q\ : std_logic;
SIGNAL \ButtonPressDetect~0_combout\ : std_logic;
SIGNAL \ButtonPressed~q\ : std_logic;
SIGNAL \ShiftReg[2]~0_combout\ : std_logic;
SIGNAL \ShiftReg[3]~feeder_combout\ : std_logic;
SIGNAL \ShiftReg[4]~feeder_combout\ : std_logic;
SIGNAL ShiftReg : std_logic_vector(1 TO 4);
SIGNAL sync : std_logic_vector(1 DOWNTO 0);
SIGNAL ALT_INV_ShiftReg : std_logic_vector(4 DOWNTO 2);

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_rst <= rst;
ww_clk <= clk;
ww_sw1 <= sw1;
led <= ww_led;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

\rst~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \rst~input_o\);
ALT_INV_ShiftReg(2) <= NOT ShiftReg(2);
ALT_INV_ShiftReg(3) <= NOT ShiftReg(3);
ALT_INV_ShiftReg(4) <= NOT ShiftReg(4);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X41_Y13_N9
\led[4]~output\ : cyclone10lp_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_ShiftReg(4),
	devoe => ww_devoe,
	o => \led[4]~output_o\);

-- Location: IOOBUF_X41_Y12_N2
\led[3]~output\ : cyclone10lp_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_ShiftReg(3),
	devoe => ww_devoe,
	o => \led[3]~output_o\);

-- Location: IOOBUF_X41_Y13_N23
\led[2]~output\ : cyclone10lp_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_ShiftReg(2),
	devoe => ww_devoe,
	o => \led[2]~output_o\);

-- Location: IOOBUF_X41_Y13_N16
\led[1]~output\ : cyclone10lp_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => ShiftReg(1),
	devoe => ww_devoe,
	o => \led[1]~output_o\);

-- Location: IOIBUF_X0_Y14_N1
\clk~input\ : cyclone10lp_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G4
\clk~inputclkctrl\ : cyclone10lp_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: LCCOMB_X40_Y13_N18
\ShiftReg[1]~1\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \ShiftReg[1]~1_combout\ = !ShiftReg(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ShiftReg(4),
	combout => \ShiftReg[1]~1_combout\);

-- Location: IOIBUF_X0_Y14_N8
\rst~input\ : cyclone10lp_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst,
	o => \rst~input_o\);

-- Location: CLKCTRL_G2
\rst~inputclkctrl\ : cyclone10lp_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \rst~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \rst~inputclkctrl_outclk\);

-- Location: IOIBUF_X41_Y15_N8
\sw1~input\ : cyclone10lp_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw1,
	o => \sw1~input_o\);

-- Location: LCCOMB_X40_Y13_N2
\sync[0]~0\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \sync[0]~0_combout\ = !\sw1~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sw1~input_o\,
	combout => \sync[0]~0_combout\);

-- Location: FF_X40_Y13_N3
\sync[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \sync[0]~0_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => sync(0));

-- Location: LCCOMB_X40_Y13_N10
\sync[1]~feeder\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \sync[1]~feeder_combout\ = sync(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => sync(0),
	combout => \sync[1]~feeder_combout\);

-- Location: FF_X40_Y13_N11
\sync[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \sync[1]~feeder_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => sync(1));

-- Location: LCCOMB_X40_Y13_N8
\delayed_switch~feeder\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \delayed_switch~feeder_combout\ = sync(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => sync(1),
	combout => \delayed_switch~feeder_combout\);

-- Location: FF_X40_Y13_N9
delayed_switch : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \delayed_switch~feeder_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \delayed_switch~q\);

-- Location: LCCOMB_X40_Y13_N12
\ButtonPressDetect~0\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \ButtonPressDetect~0_combout\ = (!\delayed_switch~q\ & sync(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \delayed_switch~q\,
	datad => sync(1),
	combout => \ButtonPressDetect~0_combout\);

-- Location: FF_X40_Y13_N13
ButtonPressed : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ButtonPressDetect~0_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ButtonPressed~q\);

-- Location: FF_X40_Y13_N19
\ShiftReg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ShiftReg[1]~1_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	ena => \ButtonPressed~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ShiftReg(1));

-- Location: LCCOMB_X40_Y13_N4
\ShiftReg[2]~0\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \ShiftReg[2]~0_combout\ = !ShiftReg(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ShiftReg(1),
	combout => \ShiftReg[2]~0_combout\);

-- Location: FF_X40_Y13_N5
\ShiftReg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ShiftReg[2]~0_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	ena => \ButtonPressed~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ShiftReg(2));

-- Location: LCCOMB_X40_Y13_N6
\ShiftReg[3]~feeder\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \ShiftReg[3]~feeder_combout\ = ShiftReg(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => ShiftReg(2),
	combout => \ShiftReg[3]~feeder_combout\);

-- Location: FF_X40_Y13_N7
\ShiftReg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ShiftReg[3]~feeder_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	ena => \ButtonPressed~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ShiftReg(3));

-- Location: LCCOMB_X40_Y13_N20
\ShiftReg[4]~feeder\ : cyclone10lp_lcell_comb
-- Equation(s):
-- \ShiftReg[4]~feeder_combout\ = ShiftReg(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ShiftReg(3),
	combout => \ShiftReg[4]~feeder_combout\);

-- Location: FF_X40_Y13_N21
\ShiftReg[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ShiftReg[4]~feeder_combout\,
	clrn => \rst~inputclkctrl_outclk\,
	ena => \ButtonPressed~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ShiftReg(4));

ww_led(4) <= \led[4]~output_o\;

ww_led(3) <= \led[3]~output_o\;

ww_led(2) <= \led[2]~output_o\;

ww_led(1) <= \led[1]~output_o\;
END structure;


