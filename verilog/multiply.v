/*
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- fixed point multiplier */

module multiply(
                clk,
                multiplier,
                multiplicand,
                result
                );

input clk;
input [15:00] multiplier;
input [15:00] multiplicand;
output[31:00] result;

reg [31:00] result;
reg [15:00] abs_multiplicand;
reg lsb;

integer i,j;

always @( multiplicand or multiplier)
begin
    result = { 16'h0000, multiplier[15] ? -multiplier : multiplier };  
    abs_multiplicand = multiplicand[15] ? -multiplicand : multiplicand;
  
   for (i=15; i>=0; i = i - 1)
   begin    
       lsb    = result[0];
       result = result >>1;
       
       if (lsb == 1'b1)
       begin
         result[31:15] = result[30:15] + abs_multiplicand;   
       end
   
       if ((!i) && (multiplier[15] ^ multiplicand[15]))
       begin
         result = -result;
       end 
   
   end

end

endmodule