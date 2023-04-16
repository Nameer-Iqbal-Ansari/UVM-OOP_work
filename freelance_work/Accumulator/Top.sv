# Author: Nameer Iqbal Ansari <n.i.ansari200@gmail.com>
# Date: 16.4.2023
# Description: The top logic for connecting all the interfaces togather
module testbench;
	logic clock=0; 
	always #4 clock=~clock;	//clock generator
	inter_face inf (clock);	//creating interface instance
    accumulator design_under_test( 	.sum(inf.sum), .data_in(inf.data_in), .rst(inf.rst), .clk(clock));//DUT
    prog_test tb(inf); //TEST 
endmodule
