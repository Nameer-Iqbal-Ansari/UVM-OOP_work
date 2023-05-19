// The generator class is used to generate a random
// number of transactions with random addresses and data
// that can be driven to the design
class generator;
  mailbox gen_mbx;
  event gen_done;
  task run();
    forever begin
      trans_obj item = new;
      item.randomize();
      $display ("T=%0t [Generator] Generating frequencies", $time);
      gen_mbx.put(item);
	  @(gen_done);
    end
    $display ("T=%0t [Generator] Done generation of frequencies", $time);
  endtask
endclass
