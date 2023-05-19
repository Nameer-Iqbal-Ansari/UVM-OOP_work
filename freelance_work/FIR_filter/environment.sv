// The environment is a container object simply to hold
// all verification  components together. This environment can
// then be reused later and all components in it would be
// automatically connected and available for use
class env;
  driver 		d0; 		// Driver handle
  monitor 		m0; 		// Monitor handle
  generator		g0; 		// Generator Handle
  scoreboard	s0; 		// Scoreboard handle

  mailbox 	gen_mbx; 		// Connect GEN -> DRV
  mailbox 	scb_mbx; 		// Connect MON -> SCB
  event 	gen_done; 		// Indicates when driver is done
  virtual gen_if vif; 	// Virtual interface handle

  function new();
    d0 = new;
    m0 = new;
    g0 = new;
    s0 = new;
    gen_mbx = new();
    scb_mbx = new();

    d0.gen_mbx = gen_mbx;
    g0.gen_mbx = gen_mbx;
    m0.scb_mbx = scb_mbx;
    s0.scb_mbx = scb_mbx;

    d0.gen_done = gen_done;
    g0.gen_done = gen_done;
  endfunction

  virtual task run();
    d0.vif = vif;
    m0.vif = vif;

    fork
      d0.run();
      m0.run();
      g0.run();
      s0.run();
    join_any
  endtask
endclass
