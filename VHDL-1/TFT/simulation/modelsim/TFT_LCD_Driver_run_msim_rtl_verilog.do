transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/prins/Desktop/GENISAMA/TFT/src {C:/Users/prins/Desktop/GENISAMA/TFT/src/TFT_LCD_Driver.v}
vlog -vlog01compat -work work +incdir+C:/Users/prins/Desktop/GENISAMA/TFT/src/sim {C:/Users/prins/Desktop/GENISAMA/TFT/src/sim/TFT_LCD_Driver_tb.v}

vlog -vlog01compat -work work +incdir+C:/Users/prins/Desktop/GENISAMA/TFT/src/sim {C:/Users/prins/Desktop/GENISAMA/TFT/src/sim/TFT_LCD_Driver_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TFT_LCD_Driver_tb

add wave *
view structure
view signals
run 2 ns
