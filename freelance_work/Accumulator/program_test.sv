# Author: Nameer Iqbal Ansari <n.i.ansari200@gmail.com>
# Date: 16.4.2023
# Description: The testbench logic which includes the randomize generated test input and other test logics
program prog_test (interface inf);
    typedef  byte unsigned byte_data ; byte_data data_in_array[]; bit [15:0] sum_queue [$];
    initial begin
        $dumpvars(1);
        inf.rst=1;
        #6
        inf.rst=0;
        data_in_array = new[500];
        for (int i = 0; i < data_in_array.size(); i++) begin
          data_in_array[i] = $random;
          inf.data_in = data_in_array[i];
          if (data_in_array[i]+data_in_array[i-1] != inf.sum)
          $display("Invalid output\n");
          #8
          sum_queue.push_back(inf.sum);
        end
        #4
        for (int i = 0; i < data_in_array.size(); i++) begin
          $display("data_in_array[%0d] = %0d, sum_queue[%0d] = %0d", i, data_in_array[i], i, sum_queue.pop_front());
        end
        #5000
        $finish();

    end
endprogram:prog_test
