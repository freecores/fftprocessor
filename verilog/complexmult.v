/*
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- fixed point complex multiplier */

module complexmult (
    multiplier,
    results
);

  // Port mode declarations:
  input  signed  [31:00] multiplier;
  output signed  [63:00] results;


  reg  [63:00] results;
  wire [31:00] ac,ad,bc,bd	;	
  
  SCM mcmone_1(
        .X             (multiplier[31:16]),
        .Y1            (ac),
        .Y2            (ad)
        );
       
  SCM mcmone_2(
        .X             (multiplier[15:00]),
        .Y1            (bc),
        .Y2            (bd) //Note it will give +bd
        );
        
 
always @(ac or bd or ad or bc) 
begin
    results[63:32] = $signed(ac - bd);
    results[31:00] = $signed(ad + bc);
end

endmodule 

//complexmultiplier