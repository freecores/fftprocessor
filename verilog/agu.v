/*
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- Address Generation Module */

module agu(
            clk,
            en_fft,
            readmem_en,
            memwrite_en,
            agu_rd_addr0,
            agu_rd_addr1,
            agu_rd_addr2,
            agu_rd_addr3,
            agu_rd_addr4,
            agu_rd_addr5,
            agu_rd_addr6,
            agu_rd_addr7,
            agu_wr_addr0,
            agu_wr_addr1,
            agu_wr_addr2,
            agu_wr_addr3,
            agu_wr_addr4,
            agu_wr_addr5,
            agu_wr_addr6,
            agu_wr_addr7
);

input clk;
input readmem_en;
input memwrite_en;
input en_fft;

output [2:0] agu_rd_addr0;
output [2:0] agu_rd_addr1;
output [2:0] agu_rd_addr2;
output [2:0] agu_rd_addr3;
output [2:0] agu_rd_addr4;
output [2:0] agu_rd_addr5;
output [2:0] agu_rd_addr6;
output [2:0] agu_rd_addr7;

output [2:0] agu_wr_addr0;
output [2:0] agu_wr_addr1;
output [2:0] agu_wr_addr2;
output [2:0] agu_wr_addr3;
output [2:0] agu_wr_addr4;
output [2:0] agu_wr_addr5;
output [2:0] agu_wr_addr6;
output [2:0] agu_wr_addr7;


reg [3:0] counter_read;
reg [3:0] counter_write;
reg [2:0] agu_read  [7:0];
reg [2:0] agu_write [7:0];

always @(posedge clk)
begin 
if (en_fft)
 begin
 counter_read = 4'b0000;
 counter_write = 4'b0000;
 end
end

always @(negedge clk)
begin
if (readmem_en)
begin
    case(counter_read)
            4'h0: begin
                  agu_read[0]<=3'h0;
                  agu_read[1]<=3'h1;
                  agu_read[2]<=3'h2;
                  agu_read[3]<=3'h3;
                  agu_read[4]<=3'h4;
                  agu_read[5]<=3'h5;
                  agu_read[6]<=3'h6;
                  agu_read[7]<=3'h7;
                  end

            4'h1: begin
                  agu_read[0]<=3'h7;
                  agu_read[1]<=3'h0;
                  agu_read[2]<=3'h1;
                  agu_read[3]<=3'h2;
                  agu_read[4]<=3'h3;
                  agu_read[5]<=3'h4;
                  agu_read[6]<=3'h5;
                  agu_read[7]<=3'h6;
              end

            4'h2: begin
                  agu_read[0]<=3'h6;
                  agu_read[1]<=3'h7;
                  agu_read[2]<=3'h0;
                  agu_read[3]<=3'h1;
                  agu_read[4]<=3'h2;
                  agu_read[5]<=3'h3;
                  agu_read[6]<=3'h4;
                  agu_read[7]<=3'h5;
                  end

            4'h3: begin
                  agu_read[0]<=3'h5;
                  agu_read[1]<=3'h6;
                  agu_read[2]<=3'h7;
                  agu_read[3]<=3'h0;
                  agu_read[4]<=3'h1;
                  agu_read[5]<=3'h2;
                  agu_read[6]<=3'h3;
                  agu_read[7]<=3'h4;
                  end

            4'h4: begin
                  agu_read[0]<=3'h4;
                  agu_read[1]<=3'h5;
                  agu_read[2]<=3'h6;
                  agu_read[3]<=3'h7;
                  agu_read[4]<=3'h0;
                  agu_read[5]<=3'h1;
                  agu_read[6]<=3'h2;
                  agu_read[7]<=3'h3;
                  end

            4'h5: begin
                  agu_read[0]<=3'h3;
                  agu_read[1]<=3'h4;
                  agu_read[2]<=3'h5;
                  agu_read[3]<=3'h6;
                  agu_read[4]<=3'h7;
                  agu_read[5]<=3'h0;
                  agu_read[6]<=3'h1;
                  agu_read[7]<=3'h2;
                  end

            4'h6: begin
                  agu_read[0]<=3'h2;
                  agu_read[1]<=3'h3;
                  agu_read[2]<=3'h4;
                  agu_read[3]<=3'h5;
                  agu_read[4]<=3'h6;
                  agu_read[5]<=3'h7;
                  agu_read[6]<=3'h0;
                  agu_read[7]<=3'h1;
                  end

            4'h7: begin
                  agu_read[0]<=3'h1;
                  agu_read[1]<=3'h2;
                  agu_read[2]<=3'h3;
                  agu_read[3]<=3'h4;
                  agu_read[4]<=3'h5;
                  agu_read[5]<=3'h6;
                  agu_read[6]<=3'h7;
                  agu_read[7]<=3'h0;
                  end
                  
            4'h8: begin
                  agu_read[0]<=3'h0;
                  agu_read[1]<=3'h0;
                  agu_read[2]<=3'h0;
                  agu_read[3]<=3'h0;
                  agu_read[4]<=3'h0;
                  agu_read[5]<=3'h0;
                  agu_read[6]<=3'h0;
                  agu_read[7]<=3'h0;
                  end
                  
            4'h9: begin
                  agu_read[0]<=3'h1;
                  agu_read[1]<=3'h1;
                  agu_read[2]<=3'h1;
                  agu_read[3]<=3'h1;
                  agu_read[4]<=3'h1;
                  agu_read[5]<=3'h1;
                  agu_read[6]<=3'h1;
                  agu_read[7]<=3'h1;
                  end
                  
            4'ha: begin
                  agu_read[0]<=3'h2;
                  agu_read[1]<=3'h2;
                  agu_read[2]<=3'h2;
                  agu_read[3]<=3'h2;
                  agu_read[4]<=3'h2;
                  agu_read[5]<=3'h2;
                  agu_read[6]<=3'h2;
                  agu_read[7]<=3'h2;
                  end

            4'hb: begin
                  agu_read[0]<=3'h3;
                  agu_read[1]<=3'h3;
                  agu_read[2]<=3'h3;
                  agu_read[3]<=3'h3;
                  agu_read[4]<=3'h3;
                  agu_read[5]<=3'h3;
                  agu_read[6]<=3'h3;
                  agu_read[7]<=3'h3;
            end

            4'hc:begin
                  agu_read[0]<=3'h4;
                  agu_read[1]<=3'h4;
                  agu_read[2]<=3'h4;
                  agu_read[3]<=3'h4;
                  agu_read[4]<=3'h4;
                  agu_read[5]<=3'h4;
                  agu_read[6]<=3'h4;
                  agu_read[7]<=3'h4;
                  end

            4'hd:begin
                  agu_read[0]<=3'h5;
                  agu_read[1]<=3'h5;
                  agu_read[2]<=3'h5;
                  agu_read[3]<=3'h5;
                  agu_read[4]<=3'h5;
                  agu_read[5]<=3'h5;
                  agu_read[6]<=3'h5;
                  agu_read[7]<=3'h5;
                  end
            
            4'he:begin
                  agu_read[0]<=3'h6;
                  agu_read[1]<=3'h6;
                  agu_read[2]<=3'h6;
                  agu_read[3]<=3'h6;
                  agu_read[4]<=3'h6;
                  agu_read[5]<=3'h6;
                  agu_read[6]<=3'h6;
                  agu_read[7]<=3'h6;
                  end

            4'hf:begin
                  agu_read[0]<=3'h7;
                  agu_read[1]<=3'h7;
                  agu_read[2]<=3'h7;
                  agu_read[3]<=3'h7;
                  agu_read[4]<=3'h7;
                  agu_read[5]<=3'h7;
                  agu_read[6]<=3'h7;
                  agu_read[7]<=3'h7;
                  end
    endcase
    counter_read<=counter_read+1;
end
end

always @(negedge clk)
begin
if (memwrite_en)
begin
    case(counter_write)
            4'h0: begin
                  agu_write[0]<=3'h0;
                  agu_write[1]<=3'h1;
                  agu_write[2]<=3'h2;
                  agu_write[3]<=3'h3;
                  agu_write[4]<=3'h4;
                  agu_write[5]<=3'h5;
                  agu_write[6]<=3'h6;
                  agu_write[7]<=3'h7;
                  end

            4'h1: begin
                  agu_write[0]<=3'h7;
                  agu_write[1]<=3'h0;
                  agu_write[2]<=3'h1;
                  agu_write[3]<=3'h2;
                  agu_write[4]<=3'h3;
                  agu_write[5]<=3'h4;
                  agu_write[6]<=3'h5;
                  agu_write[7]<=3'h6;
              end

            4'h2: begin
                  agu_write[0]<=3'h6;
                  agu_write[1]<=3'h7;
                  agu_write[2]<=3'h0;
                  agu_write[3]<=3'h1;
                  agu_write[4]<=3'h2;
                  agu_write[5]<=3'h3;
                  agu_write[6]<=3'h4;
                  agu_write[7]<=3'h5;
                  end

            4'h3: begin
                  agu_write[0]<=3'h5;
                  agu_write[1]<=3'h6;
                  agu_write[2]<=3'h7;
                  agu_write[3]<=3'h0;
                  agu_write[4]<=3'h1;
                  agu_write[5]<=3'h2;
                  agu_write[6]<=3'h3;
                  agu_write[7]<=3'h4;
                  end

            4'h4: begin
                  agu_write[0]<=3'h4;
                  agu_write[1]<=3'h5;
                  agu_write[2]<=3'h6;
                  agu_write[3]<=3'h7;
                  agu_write[4]<=3'h0;
                  agu_write[5]<=3'h1;
                  agu_write[6]<=3'h2;
                  agu_write[7]<=3'h3;
                  end

            4'h5: begin
                  agu_write[0]<=3'h3;
                  agu_write[1]<=3'h4;
                  agu_write[2]<=3'h5;
                  agu_write[3]<=3'h6;
                  agu_write[4]<=3'h7;
                  agu_write[5]<=3'h0;
                  agu_write[6]<=3'h1;
                  agu_write[7]<=3'h2;
                  end

            4'h6: begin
                  agu_write[0]<=3'h2;
                  agu_write[1]<=3'h3;
                  agu_write[2]<=3'h4;
                  agu_write[3]<=3'h5;
                  agu_write[4]<=3'h6;
                  agu_write[5]<=3'h7;
                  agu_write[6]<=3'h0;
                  agu_write[7]<=3'h1;
                  end

            4'h7: begin
                  agu_write[0]<=3'h1;
                  agu_write[1]<=3'h2;
                  agu_write[2]<=3'h3;
                  agu_write[3]<=3'h4;
                  agu_write[4]<=3'h5;
                  agu_write[5]<=3'h6;
                  agu_write[6]<=3'h7;
                  agu_write[7]<=3'h0;
                  end
                  
            4'h8: begin
                  agu_write[0]<=3'h0;
                  agu_write[1]<=3'h0;
                  agu_write[2]<=3'h0;
                  agu_write[3]<=3'h0;
                  agu_write[4]<=3'h0;
                  agu_write[5]<=3'h0;
                  agu_write[6]<=3'h0;
                  agu_write[7]<=3'h0;
                  end
                  
            4'h9: begin
                  agu_write[0]<=3'h1;
                  agu_write[1]<=3'h1;
                  agu_write[2]<=3'h1;
                  agu_write[3]<=3'h1;
                  agu_write[4]<=3'h1;
                  agu_write[5]<=3'h1;
                  agu_write[6]<=3'h1;
                  agu_write[7]<=3'h1;
                  end
                  
            4'ha: begin
                  agu_write[0]<=3'h2;
                  agu_write[1]<=3'h2;
                  agu_write[2]<=3'h2;
                  agu_write[3]<=3'h2;
                  agu_write[4]<=3'h2;
                  agu_write[5]<=3'h2;
                  agu_write[6]<=3'h2;
                  agu_write[7]<=3'h2;
                  end

            4'hb: begin
                  agu_write[0]<=3'h3;
                  agu_write[1]<=3'h3;
                  agu_write[2]<=3'h3;
                  agu_write[3]<=3'h3;
                  agu_write[4]<=3'h3;
                  agu_write[5]<=3'h3;
                  agu_write[6]<=3'h3;
                  agu_write[7]<=3'h3;
            end

            4'hc:begin
                  agu_write[0]<=3'h4;
                  agu_write[1]<=3'h4;
                  agu_write[2]<=3'h4;
                  agu_write[3]<=3'h4;
                  agu_write[4]<=3'h4;
                  agu_write[5]<=3'h4;
                  agu_write[6]<=3'h4;
                  agu_write[7]<=3'h4;
                  end

            4'hd:begin
                  agu_write[0]<=3'h5;
                  agu_write[1]<=3'h5;
                  agu_write[2]<=3'h5;
                  agu_write[3]<=3'h5;
                  agu_write[4]<=3'h5;
                  agu_write[5]<=3'h5;
                  agu_write[6]<=3'h5;
                  agu_write[7]<=3'h5;
                  end
            
            4'he:begin
                  agu_write[0]<=3'h6;
                  agu_write[1]<=3'h6;
                  agu_write[2]<=3'h6;
                  agu_write[3]<=3'h6;
                  agu_write[4]<=3'h6;
                  agu_write[5]<=3'h6;
                  agu_write[6]<=3'h6;
                  agu_write[7]<=3'h6;
                  end

            4'hf:begin
                  agu_write[0]<=3'h7;
                  agu_write[1]<=3'h7;
                  agu_write[2]<=3'h7;
                  agu_write[3]<=3'h7;
                  agu_write[4]<=3'h7;
                  agu_write[5]<=3'h7;
                  agu_write[6]<=3'h7;
                  agu_write[7]<=3'h7;
                  end
    endcase

    counter_write<=counter_write+1;
end
end

assign agu_rd_addr0=agu_read[0];
assign agu_rd_addr1=agu_read[1];
assign agu_rd_addr2=agu_read[2];
assign agu_rd_addr3=agu_read[3];
assign agu_rd_addr4=agu_read[4];
assign agu_rd_addr5=agu_read[5];
assign agu_rd_addr6=agu_read[6];
assign agu_rd_addr7=agu_read[7];

assign agu_wr_addr0=agu_write[0];
assign agu_wr_addr1=agu_write[1];
assign agu_wr_addr2=agu_write[2];
assign agu_wr_addr3=agu_write[3];
assign agu_wr_addr4=agu_write[4];
assign agu_wr_addr5=agu_write[5];
assign agu_wr_addr6=agu_write[6];
assign agu_wr_addr7=agu_write[7];


endmodule