/*
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- 2 32 bit fixed point multipliers */

module two16bitmult(
							clk,
							multiplier,
							multiplicand1,
							multiplicand2,
							results
							);
input clk;
input [31:00] multiplier;
input [15:00] multiplicand1;
input [15:00] multiplicand2;
output[63:00] results;

reg [63:00] results;
wire [127:00] result	;	

multiply multiplier1(
        .clk           (clk),
        .multiplier    (multiplier[31:16]),
        .multiplicand  (multiplicand1),
        .result        (result[127:96])
        );
       
 multiply multiplier2(
        .clk           (clk),
        .multiplier    (multiplier[15:00]),
        .multiplicand  (multiplicand2),
        .result        (result[95:64])
        );
        
 multiply multiplier3(
        .clk           (clk),
        .multiplier    (multiplier[31:16]),
        .multiplicand  (multiplicand2),
        .result        (result[63:32])
        );
        
multiply multiplier4(
        .clk           (clk),
        .multiplier    (multiplier[15:00]),
        .multiplicand  (multiplicand1),
        .result        (result[31:00])
        );

always @(result) 
begin
    results[63:32] = result[127:96] - result[95:64];
    results[31:00] = result[63:32]  + result[31:00];
end
endmodule