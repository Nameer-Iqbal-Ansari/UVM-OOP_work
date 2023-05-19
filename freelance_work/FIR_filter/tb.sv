/ Top level testbench module to instantiate design, interface
// start clocks and run the test
module tb_FIR;
  reg clk;
    /*
     * 100Mhz (10ns) clock
     */
  always #5 clk =~ clk;
  gen_if 	_if (clk);
  FIR DUT ( 	.clk(clk),
             .reset(_if.reset),
             .s_axis_fir_tdata(_if.s_axis_fir_tdata),
             .s_axis_fir_tlast(_if.s_axis_fir_tlast),
             .s_axis_fir_tvalid (_if.s_axis_fir_tvalid),
             .m_axis_fir_tready(_if.m_axis_fir_tready),
             .m_axis_fir_tvalid(_if.m_axis_fir_tvalid),
             .s_axis_fir_tready(_if.s_axis_fir_tready),
             .m_axis_fir_tlast(_if.m_axis_fir_tlast),
             .m_axis_fir_tdata(_if.m_axis_fir_tdata));
  test t0;

  initial begin
    {clk, _if.reset} <= 0;

    // Apply reset and start stimulus
    $display("Reset is deasserted");
    #20 _if.reset <= 1;
    t0 = new;
    t0.e0.vif = _if;
    t0.run();

    // Because multiple components and clock are running
    // in the background, we need to call $finish explicitly
    #300 $finish;
  end

  // System tasks to dump VCD waveform file
  initial begin
    $dumpvars;
    $dumpfile ("dump.vcd");
  end
endmodule
