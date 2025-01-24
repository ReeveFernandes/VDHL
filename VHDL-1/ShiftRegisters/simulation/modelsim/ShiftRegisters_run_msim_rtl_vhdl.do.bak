transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/prins/Desktop/GENISAMA/VHDL Course/ShiftRegisters/src/VHDL/ShiftRegisters.vhd}

vcom -93 -work work {C:/Users/prins/Desktop/GENISAMA/VHDL Course/ShiftRegisters/src/VHDL/ModShiftRegisters_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclone10lp -L rtl_work -L work -voptargs="+acc"  ModShiftRegisters_tb

add wave *
view structure
view signals
run 5 ms
