/* 
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- memory bank module */

module memorybank(
       clk,
       read_add, 
       write_add, 
       read_data, 
       write_data, 
       memwrite_en);
    
    input clk;
    input memwrite_en;
    input  [02:00] read_add;
    input  [02:00] write_add;
    input  [31:00] write_data;
    output [31:00] read_data;
    
    reg    [31:0] memory[07:00];
    
always @(posedge clk)
begin
   if (memwrite_en == 1)
   begin
      memory[write_add] <= write_data;
   end
 end
 
assign  read_data =  memory[read_add];
 
endmodule