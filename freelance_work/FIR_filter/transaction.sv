// This is the base transaction object that will be used
// in the environment to initiate new transactions and
// capture transactions at DUT interface
class trans_obj;
  rand reg signed [15:0] s_axis_fir_tdata;
  reg s_axis_fir_tlast;
  reg s_axis_fir_tvalid;//master is giving valid data to FIR
  reg m_axis_fir_tready;//master is ready to take data from FIR
  reg m_axis_fir_tvalid;//output data is valid
  reg s_axis_fir_tready;//FIR is ready to take data
  reg m_axis_fir_tlast;
  reg signed [31:0] m_axis_fir_tdata;

    // This function allows us to print contents of the data
  	// packet so that it is easier to track in a logfile
  function void print (string tag="");
    $display ("T=%0t %s s_axis_fir_tdata=0x%0h s_axis_fir_tlast=0x%0h s_axis_fir_tvalid=0x%0h m_axis_fir_tready=0x%0h m_axis_fir_tvalid=0x%0h s_axis_fir_tready=0x%0h m_axis_fir_tlast=0x%0h m_axis_fir_tdata=0x%0h",
              	$time, tag, s_axis_fir_tdata, s_axis_fir_tlast, s_axis_fir_tvalid, m_axis_fir_tready, m_axis_fir_tvalid, s_axis_fir_tready, m_axis_fir_tlast,m_axis_fir_tdata);
  endfunction
endclass
