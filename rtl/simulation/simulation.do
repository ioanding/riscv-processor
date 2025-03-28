quit -sim
file delete -force work

vlib work
vlog -f files_rtl.f

vsim processor_tb
log -r /*
do wave.do

run -all
do mem.do