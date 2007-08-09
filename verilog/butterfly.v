/*
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- butterfly processor module */

Module butterfly (
       clk,
       reset,
       bfpcontrol, 
       read_data_a, 
       read_data_b, 
       write_data_a, 
       write_data_b);
       
    input clk;
    input reset; 
    input [04:00] bfpcontrol;
    input [31:00] read_data_a;
    input [31:00] read_data_b;
    
    output [31:00] write_data_a;
    output [31:00] write_data_b;
    
    wire [31:00] aplusb;
    wire [31:00] aminb;  
    wire [31:00] aminusb;
    
    reg [31:00] d_aplusb;
    reg [31:00] d_aminusb;
    reg [31:00] dd_aplusb;
    reg [63:00] d_aminusbcsd1;
    reg [63:00] aminusbcsd1;
    reg [63:00] write_data_b_reg;
    
    wire [2:0] csdb1; 
    reg  [2:0] d_csdb1;
    wire [1:0] csdb2; 
    reg  [1:0] d_csdb2;
    reg  [1:0] dd_csdb2;

    reg [31:00]  multiplier1;
    reg [15:00]  multiplicand1_1;
    reg [15:00]  multiplicand1_2;
    wire [63:00] firstmultipres;
    
    two16bitmult firstmultiplier(
		 .clk            (clk),
		 .multiplier     (multiplier1), 
		 .multiplicand1  (multiplicand1_1),
		 .multiplicand2  (multiplicand1_2),
		 .results        (firstmultipres)
		);
		
    reg [31:00] multiplier2;
    reg [15:00] multiplicand2_1;
    reg [15:00] multiplicand2_2;
    wire [63:00] secondmultipres;
    
    two16bitmult secondmultiplier(
		 .clk            (clk),
		 .multiplier     (multiplier2), 
		 .multiplicand1  (multiplicand2_1),
		 .multiplicand2  (multiplicand2_2),
		 .results        (secondmultipres)
		);
               
    // 10 CSD's [real and imaginary parts]
       parameter csd1r =  16'h7f63;  // 0.9952  W1
       parameter csd1i =  16'hf378;  //-0.0979, 2s complement
       parameter csd2r =  16'h7d8b;  // 0.9808  W2
       parameter csd2i =  16'he707;  //-0.1951, 2s complement
       parameter csd3r =  16'h7a7c;  // 0.9569  W3
       parameter csd3i =  16'hdad7;  //-0.2903, 2s complement
       parameter csd4r =  16'h763f;  // 0.9238  W4
       parameter csd4i =  16'hcf07;  //-0.3826, 2s complement
       parameter csd5r =  16'h70e2;  // 0.8819  W5
       parameter csd5i =  16'hc3a9;  //-0.4714, 2s complement
       parameter csd6r =  16'h6a6b;  // 0.8314  W6
       parameter csd6i =  16'hb8e5;  //-0.5555, 2s complement
       parameter csd7r =  16'h62f2;  // 0.7730  W7
       parameter csd7i =  16'haecc;  //-0.6344, 2s complement
       parameter csd8r =  16'h5a82;  // 0.7071  W8
       parameter csd8i =  16'ha57e;  //-0.7071, 2s complement
       parameter csd9r =  16'h0000;  // 0.0000  W16
       parameter csd9i =  16'h8000;  //-1.0000, 2s complement
       parameter csd10r=  16'ha57e;  //-0.7071, W24: 2s complement
       parameter csd10i=  16'ha57e;  //-0.7071, 2s complement
       
    assign csdb1[2:0] = bfpcontrol[4:2]; 
    assign csdb2[1:0] = bfpcontrol[1:0];   
    
    assign aplusb [31:16] = $signed(read_data_a[31:16] + read_data_b[31:16])/2;
    assign aplusb [15:00] = $signed(read_data_a[15:00] + read_data_b[15:00])/2;
    
    assign aminusb[31:16] = $signed(read_data_a[31:16] - read_data_b[31:16])/2;
    assign aminusb[15:00] = $signed(read_data_a[15:00] - read_data_b[15:00])/2;
    
    assign write_data_a = dd_aplusb;
    assign write_data_b[31:16] = write_data_b_reg[62:47];
    assign write_data_b[15:00] = write_data_b_reg[30:15];
    
    always @( d_csdb1 or d_aminusb or firstmultipres)
    begin
    case(d_csdb1)
        3'b000: begin
                aminusbcsd1[63]    <= 1'b0;
                aminusbcsd1[62:47] <= d_aminusb[31:16];
                aminusbcsd1[46:32] <= 15'h0000;
                aminusbcsd1[31]    <= 1'b0;
                aminusbcsd1[30:15] <= d_aminusb[15:00];
                aminusbcsd1[14:00] <= 15'h0000;
             end
        3'b001: begin
                multiplier1      <= d_aminusb;
                multiplicand1_1  <= csd1r;
                multiplicand1_2  <= csd1i;
                aminusbcsd1      <= firstmultipres;
                //aminusbcsd1[63:32]  <= ((d_aminusb[31:16]*csd1r - d_aminusb[15:00]*csd1i));
                //aminusbcsd1[31:00]  <= ((d_aminusb[31:16]*csd1i + d_aminusb[15:00]*csd1r));  
                end
            
        3'b010:begin
                multiplier1      <= d_aminusb;
                multiplicand1_1  <= csd2r;
                multiplicand1_2  <= csd2i;
                aminusbcsd1      <= firstmultipres;
                //aminusbcsd1[63:32]  <= ((d_aminusb[31:16]*csd2r - d_aminusb[15:00]*csd2i));
                //aminusbcsd1[31:00]  <= ((d_aminusb[31:16]*csd2i + d_aminusb[15:00]*csd2r));
                end
           
        3'b011: begin
                multiplier1      <= d_aminusb;
                multiplicand1_1  <= csd3r;
                multiplicand1_2  <= csd3i;
                aminusbcsd1      <= firstmultipres;
                //aminusbcsd1[63:32]  <= ((d_aminusb[31:16]*csd3r - d_aminusb[15:00]*csd3i));
                //aminusbcsd1[31:00]  <= ((d_aminusb[31:16]*csd3i + d_aminusb[15:00]*csd3r));
                end
            
        3'b100: begin
                multiplier1      <= d_aminusb;
                multiplicand1_1  <= csd4r;
                multiplicand1_2  <= csd4i;
                aminusbcsd1      <= firstmultipres;
                //aminusbcsd1[63:32]  <= ((d_aminusb[31:16]*csd4r - d_aminusb[15:00]*csd4i));
                //aminusbcsd1[31:00]  <= ((d_aminusb[31:16]*csd4i + d_aminusb[15:00]*csd4r));
                end
         
        3'b101: begin
                multiplier1      <= d_aminusb;
                multiplicand1_1  <= csd5r;
                multiplicand1_2  <= csd5i;
                aminusbcsd1      <= firstmultipres;
                //aminusbcsd1[63:32]  <= ((d_aminusb[31:16]*csd5r - d_aminusb[15:00]*csd5i));
                //aminusbcsd1[31:00]  <= ((d_aminusb[31:16]*csd5i + d_aminusb[15:00]*csd5r));
                end
                
        3'b110: begin
                multiplier1      <= d_aminusb;
                multiplicand1_1  <= csd6r;
                multiplicand1_2  <= csd6i;
                aminusbcsd1      <= firstmultipres;
                //aminusbcsd1[63:32]  <= ((d_aminusb[31:16]*csd6r - d_aminusb[15:00]*csd6i)>>16);
                //aminusbcsd1[31:00]  <= ((d_aminusb[31:16]*csd6i + d_aminusb[15:00]*csd6r)>>16);
                end
        
        3'b111: begin
                multiplier1      <= d_aminusb;
                multiplicand1_1  <= csd7r;
                multiplicand1_2  <= csd7i;
                aminusbcsd1      <= firstmultipres;
                //aminusbcsd1[63:32]  <= ((d_aminusb[31:16]*csd7r - d_aminusb[15:00]*csd7i)>>16);
                //aminusbcsd1[31:00]  <= ((d_aminusb[31:16]*csd7i + d_aminusb[15:00]*csd7r)>>16);
                end
    endcase
end


always @(clk or dd_csdb2 or d_aminusbcsd1 or secondmultipres)
begin
    
    case(dd_csdb2)
        2'b00: begin
               write_data_b_reg = d_aminusbcsd1;
               
           end
        
        2'b01: begin
               multiplier2      <= {d_aminusbcsd1[62:47], d_aminusbcsd1[30:15]};
               multiplicand2_1  <= csd8r;
               multiplicand2_2  <= csd8i;
               write_data_b_reg <= secondmultipres;
               //write_data_b_reg[63:32]   <=   ((d_aminusbcsd1[63:48]*csd8r - d_aminusbcsd1[31:16]*csd8i));
               //write_data_b_reg[31:00]   <=   ((d_aminusbcsd1[63:48]*csd8i + d_aminusbcsd1[31:16]*csd8r));
           end
            
        2'b10: begin
               multiplier2       <= {d_aminusbcsd1[62:47], d_aminusbcsd1[30:15]};
               multiplicand2_1    <= csd9r;
               multiplicand2_2    <= csd9i;
               write_data_b_reg <= secondmultipres;
               //write_data_b_reg[63:32]   <=   ((d_aminusbcsd1[62:47]*csd9r - d_aminusbcsd1[30:15]*csd9i));
               //write_data_b_reg[31:00]   <=   ((d_aminusbcsd1[30:15]*csd9i + d_aminusbcsd1[30:15]*csd9r));
           end
        
        2'b11: begin
               multiplier2       <= {d_aminusbcsd1[62:47], d_aminusbcsd1[30:15]};
               multiplicand2_1    <= csd10r;
               multiplicand2_2    <= csd10i;
               write_data_b_reg <= secondmultipres;
               //write_data_b_reg[63:32]   <=   ((d_aminusbcsd1[62:47]*csd10r - d_aminusbcsd1[30:15]*csd10i));
               //write_data_b_reg[31:00]   <=   ((d_aminusbcsd1[62:47]*csd10i + d_aminusbcsd1[30:15]*csd10r));
          end
    endcase
end
     always @(posedge clk)
     begin 
        if (reset == 1'b1)
        begin
           d_aminusb     <= 32'h0;
           d_aminusbcsd1 <= 32'h0;
           dd_csdb2      <= 2'b0;
           d_csdb2       <= 2'b0;
           d_csdb1       <= 3'b0;
           dd_aplusb     <= 32'h0;
           d_aplusb      <= 32'h0; 
       end
        
        else
        begin 
        d_aminusb     <= aminusb;
        d_aminusbcsd1 <= aminusbcsd1;
        dd_csdb2      <= d_csdb2;
        d_csdb2       <= csdb2;
        d_csdb1       <= csdb1;
        dd_aplusb     <= d_aplusb;
        d_aplusb      <= aplusb;
        end
    end
endmodule