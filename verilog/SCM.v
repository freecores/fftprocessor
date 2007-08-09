/*
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- 2 32 bit fixed point multipliers */
module SCM (
    clk,
    X,
    Y1,
    Y2
);

  // Port mode declarations:
  input clk;
  input  signed  [15:00] X;
  output signed  [31:0]
    Y1,
    Y2;

  wire [31:0] Y [0:1];

  assign Y1 = Y[0];
  assign Y2 = Y[1];

  //Multipliers:

  wire signed [31:00]
    w1,
    w4,
    w5,
    w320,
    w315,
    w65536,
    w65221,
    w3,
    w1280,
    w1283,
    w5132,
    w6415,
    w6415_;

  assign w1 = X;
  assign w4 = w1 << 2;
  assign w5 = w1 + w4;
  assign w320 = w5 << 6;
  assign w315 = w320 - w5;
  assign w65536 = w1 << 16;
  assign w65221 = w65536 - w315;
  assign w3 = w4 - w1;
  assign w1280 = w5 << 8;
  assign w1283 = w3 + w1280;
  assign w5132 = w1283 << 2;
  assign w6415 = w1283 + w5132;
  assign w6415_ = -1 * w6415;

  assign Y[0] = w65221[31:00];
  assign Y[1] = w6415_[31:00];

endmodule //multiplier_block