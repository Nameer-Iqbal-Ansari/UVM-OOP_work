# Author: Nameer Iqbal Ansari <n.i.ansari200@gmail.com>
# Date: 16.4.2023
# Description: The design under test logic

module accumulator (
    output reg [15:0] sum, // accumulated out
    input      [7:0]  data_in, // input data
    input             rst, clk );
    // reset(active high) and clock inputs
    wire carry;
    wire [15:0] sum_in;
    assign   {carry,sum_in} = {1'b0,sum}+data_in ;
    always @(posedge clk)
        if (rst) sum <= 0;
        else     sum <= (carry)? 16'hffff : sum_in;
endmodule
