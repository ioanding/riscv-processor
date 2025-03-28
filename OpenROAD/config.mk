export DESIGN_NAME = bare_processor
export DESIGN_NICKNAME = riscv-processor
export PLATFORM    = sky130hd

export VERILOG_FILES = /home/ioannis/Desktop/riscv-processor/OpenROAD/proc.v
export SDC_FILE      = /home/ioannis/Desktop/riscv-processor/OpenROAD/constraint.sdc

export DIE_AREA = 0 0 5000 5000
export CORE_AREA = 20 20 4980 4980
# export PLACE_DENSITY = 0.4

export ABC_AREA = 1

export FP_PDN_RAIL_WIDTH  = 0.48
export FP_PDN_RAIL_OFFSET = 0
export TNS_END_PERCENT    = 100