onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /processor_tb/clk
add wave -noupdate -radix hexadecimal /processor_tb/rst
add wave -noupdate -radix hexadecimal /processor_tb/if_IR_out
add wave -noupdate -radix hexadecimal /processor_tb/if_id_IR
add wave -noupdate -radix hexadecimal /processor_tb/id_ex_IR
add wave -noupdate -radix hexadecimal /processor_tb/ex_mem_IR
add wave -noupdate -radix hexadecimal /processor_tb/mem_wb_IR
add wave -noupdate /processor_tb/proc_module/stall
add wave -noupdate /processor_tb/proc_module/ex_mem_take_branch
add wave -noupdate -radix unsigned /processor_tb/proc_module/id_stage_0/ra_idx
add wave -noupdate -radix unsigned /processor_tb/proc_module/id_stage_0/rb_idx
add wave -noupdate -radix unsigned /processor_tb/proc_module/id_stage_0/rc_idx
add wave -noupdate -radix unsigned /processor_tb/proc_module/id_stage_0/id_ex_dest_reg_idx
add wave -noupdate -radix unsigned /processor_tb/proc_module/id_stage_0/ex_mem_dest_reg_idx
add wave -noupdate -radix unsigned /processor_tb/proc_module/id_stage_0/mem_wb_dest_reg_idx
add wave -noupdate /processor_tb/proc_module/id_stage_0/fu0/fw_from_ex_ra
add wave -noupdate /processor_tb/proc_module/id_stage_0/fu0/fw_from_mem_ra
add wave -noupdate /processor_tb/proc_module/id_stage_0/fu0/fw_from_wb_ra
add wave -noupdate /processor_tb/proc_module/id_stage_0/fu0/fw_from_ex_rb
add wave -noupdate /processor_tb/proc_module/id_stage_0/fu0/fw_from_mem_rb
add wave -noupdate /processor_tb/proc_module/id_stage_0/fu0/fw_from_wb_rb
add wave -noupdate /processor_tb/proc_module/id_stage_0/fu0/fw_allowed
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/id_ex_rega
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/id_ex_regb
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/ex_mem_regb
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/ex_alu_result_out
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/mem_result_out
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/mem_wb_mem_result
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/id_rega_out
add wave -noupdate -radix hexadecimal /processor_tb/proc_module/id_regb_out
add wave -noupdate -radix hexadecimal -childformat {{{/processor_tb/proc_module/id_stage_0/regf_0/registers[0]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[1]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[2]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[3]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[4]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[5]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[6]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[7]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[8]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[9]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[10]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[11]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[12]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[13]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[14]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[15]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[16]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[17]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[18]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[19]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[20]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[21]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[22]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[23]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[24]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[25]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[26]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[27]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[28]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[29]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[30]} -radix hexadecimal} {{/processor_tb/proc_module/id_stage_0/regf_0/registers[31]} -radix hexadecimal}} -subitemconfig {{/processor_tb/proc_module/id_stage_0/regf_0/registers[0]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[1]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[2]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[3]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[4]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[5]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[6]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[7]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[8]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[9]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[10]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[11]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[12]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[13]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[14]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[15]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[16]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[17]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[18]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[19]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[20]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[21]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[22]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[23]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[24]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[25]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[26]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[27]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[28]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[29]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[30]} {-height 15 -radix hexadecimal} {/processor_tb/proc_module/id_stage_0/regf_0/registers[31]} {-height 15 -radix hexadecimal}} /processor_tb/proc_module/id_stage_0/regf_0/registers
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3145 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 372
configure wave -valuecolwidth 54
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3100 ps} {3226 ps}
