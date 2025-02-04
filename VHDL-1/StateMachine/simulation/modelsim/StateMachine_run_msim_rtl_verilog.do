transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/prins/Desktop/GENISAMA/VHDL\ Course/StateMachine/src/SV {C:/Users/prins/Desktop/GENISAMA/VHDL Course/StateMachine/src/SV/StateMachine.sv}

vlog -sv -work work +incdir+C:/Users/prins/Desktop/GENISAMA/VHDL\ Course/StateMachine/src/SV {C:/Users/prins/Desktop/GENISAMA/VHDL Course/StateMachine/src/SV/StateMachine_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclone10lp_ver -L rtl_work -L work -voptargs="+acc"  StateMachine_tb

add wave *
view structure
view signals
run 8 ms
