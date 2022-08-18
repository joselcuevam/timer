exec find ../../RTL ../../TESTBENCH/modules/sva -type f > caf
clear -all
analyze -sv -f caf
elaborate
clock clk
reset {rst_b == 1'b0} 
prove -all
