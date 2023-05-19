// The monitor has a virtual interface handle with which
// it can monitor the events happening on the interface.
// It sees new transactions and then captures information
// into a packet and sends it to the scoreboard
// using another mailbox.
class monitor;
  virtual gen_if vif;
  mailbox scb_mbx;
  task run();
    $display ("T=%0t [Monitor] starting ...", $time);
      sample_port("Monitor");
  endtask

  task sample_port(string tag="");
    // This task monitors the interface for a complete
    // transaction and pushes into the mailbox when the
    // transaction is complete
     forever begin
      @(posedge vif.clk);
       if (vif.reset & vif.s_axis_fir_tlast) begin
        trans_obj item = new;
        item.s_axis_fir_tdata = vif.s_axis_fir_tdata;
        item.s_axis_fir_tlast = vif.s_axis_fir_tlast;
        item.s_axis_fir_tvalid = vif.s_axis_fir_tvalid;
        item.m_axis_fir_tready = vif.m_axis_fir_tready;
        item.m_axis_fir_tvalid = vif.m_axis_fir_tvalid;
        item.s_axis_fir_tready = vif.s_axis_fir_tready;
        item.m_axis_fir_tlast = vif.m_axis_fir_tlast;
        item.m_axis_fir_tdata  = vif.m_axis_fir_tdata;
         $display("T=%0t [%s] Got last signal",$time, tag);
        scb_mbx.put(item);
      end
      else $display("T=%0t [Monitor] Monitoring ",$time);
    end
  endtask
endclass
