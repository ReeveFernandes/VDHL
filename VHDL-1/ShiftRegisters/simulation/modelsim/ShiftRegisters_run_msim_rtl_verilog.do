transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/prins/Desktop/GENISAMA/VHDL\ Course/ShiftRegisters/src/SV {C:/Users/prins/Desktop/GENISAMA/VHDL Course/ShiftRegisters/src/SV/ShiftRegisters.sv}

vlog -sv -work work +incdir+C:/Users/prins/Desktop/GENISAMA/VHDL\ Course/ShiftRegisters/src/SV {C:/Users/prins/Desktop/GENISAMA/VHDL Course/ShiftRegisters/src/SV/ShiftRegisters_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclone10lp_ver -L rtl_work -L work -voptargs="+acc"  ShiftRegisters_tb

add wave *
view structure
view signals
run 700 ns
