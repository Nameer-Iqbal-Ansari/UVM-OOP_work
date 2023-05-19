// Design interface used to monitor activity and capture/drive
// transactions
interface gen_if (input bit clk);
  logic reset;//active low
  logic signed [15:0] s_axis_fir_tdata;
  logic s_axis_fir_tlast;
  logic s_axis_fir_tvalid;//master is giving valid data to FIR
  logic m_axis_fir_tready;//master is ready to take data from FIR
  logic m_axis_fir_tvalid;//output data is valid
  logic s_axis_fir_tready;//FIR is ready to take data
  logic m_axis_fir_tlast;
  logic signed [31:0] m_axis_fir_tdata;
endinterface
