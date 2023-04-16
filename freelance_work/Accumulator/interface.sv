# Author: Nameer Iqbal Ansari <n.i.ansari200@gmail.com>
# Date: 16.4.2023
# Description: Interface logic containing clocking block and modport instances for signal directions
interface inter_face (input clock);
    logic      [15:0] sum; logic [7:0] data_in,rst;
	//clocking block for test bench signals
    clocking test_bench_clk@(posedge clock);
        input  sum; output  data_in , rst;
    endclocking:test_bench_clk
	//clocking block for design signals
    clocking design_clk@(posedge clock);
        output sum; input  data_in , rst;
    endclocking:design_clk
    modport test_bench (clocking test_bench_clk);//set testbench directions
    modport accumulator (clocking design_clk);   //set design direction

endinterface
