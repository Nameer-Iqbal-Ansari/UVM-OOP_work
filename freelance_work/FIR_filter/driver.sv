// The driver is responsible for driving transactions to the DUT
// All it does is to get a transaction from the mailbox if it is
// available and drive it out into the DUT interface.
class driver;
  virtual gen_if vif;
  event gen_done;    
  int num=5;
  mailbox gen_mbx;
  task run();

    $display ("T=%0t [Driver] starting ...", $time);
    @ (posedge vif.clk)
    // Try to get a new transaction every time and then assign
    // packet contents to the interface. But do this only if the
    // design is ready to accept new transactions
    for (int i=0; i< num; i++) begin
      trans_obj item;
      $display ("T=%0t [Driver] waiting for item ...", $time);
      vif.s_axis_fir_tvalid 	<= 1;
      vif.m_axis_fir_tready 	<= 1;
      gen_mbx.get(item);
      item.print("[Driver]");
      vif.s_axis_fir_tdata <= item.s_axis_fir_tdata;
      if ((i+1)==num) begin 
        $display ("T=%0t [Driver] Done driving of the frequencies", $time);      	   			vif.s_axis_fir_tlast <= 1;
      end
      else begin
        vif.s_axis_fir_tlast <= 0;
        // When single transfer from driver to interface is over, raise the done event for generator to generate next frequency
        @ (posedge vif.clk); -> gen_done;
        
      end
    end
  endtask
endclass
