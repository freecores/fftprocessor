/* 
-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- Top level FFT module */
 
module fft (
       clk, 
       en_fft, 
       done_fft, 
       memwrite_en,
       
       mem_rd_addr0, 
       mem_rd_addr1,
       mem_rd_addr2,
       mem_rd_addr3,
       mem_rd_addr4,
       mem_rd_addr5,
       mem_rd_addr6,
       mem_rd_addr7,
       
       mem_wr_addr0, 
       mem_wr_addr1, 
       mem_wr_addr2, 
       mem_wr_addr3, 
       mem_wr_addr4, 
       mem_wr_addr5, 
       mem_wr_addr6, 
       mem_wr_addr7,
        
       rd_data0, 
       rd_data1, 
       rd_data2, 
       rd_data3, 
       rd_data4, 
       rd_data5, 
       rd_data6, 
       rd_data7, 
       
       wr_data0,
       wr_data1,
       wr_data2,
       wr_data3,
       wr_data4,
       wr_data5,
       wr_data6,
       wr_data7
       
);
    
   // Clock and initialization signal    
    input clk;
    input en_fft;
   
   // Read Address buses 
    output [02:00] mem_rd_addr0;
    output [02:00] mem_rd_addr1;
    output [02:00] mem_rd_addr2;
    output [02:00] mem_rd_addr3;
    output [02:00] mem_rd_addr4;
    output [02:00] mem_rd_addr5;
    output [02:00] mem_rd_addr6;
    output [02:00] mem_rd_addr7;

   // Write Address buses
    output [02:00] mem_wr_addr0; 
    output [02:00] mem_wr_addr1; 
    output [02:00] mem_wr_addr2; 
    output [02:00] mem_wr_addr3; 
    output [02:00] mem_wr_addr4; 
    output [02:00] mem_wr_addr5; 
    output [02:00] mem_wr_addr6; 
    output [02:00] mem_wr_addr7; 
   
   // Read Data buses
    input [31:00] rd_data0;
    input [31:00] rd_data1;
    input [31:00] rd_data2;
    input [31:00] rd_data3;
    input [31:00] rd_data4;
    input [31:00] rd_data5;
    input [31:00] rd_data6;
    input [31:00] rd_data7;

   // Write Data buses
    output [31:00] wr_data0;
    output [31:00] wr_data1;
    output [31:00] wr_data2;
    output [31:00] wr_data3;
    output [31:00] wr_data4;
    output [31:00] wr_data5;
    output [31:00] wr_data6;
    output [31:00] wr_data7;
    
   // Signal to enable Write to memory
     output memwrite_en;
    
   // Signal to indicate completion of FFT
     output done_fft;
    
   // REGISTER BANKS TO PROVIDE INPUT TO AND RECEIVE OUTPUT FROM THE BUTTERFLY PROC.
     reg [31:0] regbankone[7:0];
     reg [31:0] regbanktwo[7:0];
         
   // control signal wire coming out of the microcoded state machine  
     wire [14:0] controlsignal;
   
    // Signals to go into and come out of the butterfly processor
     reg  [31:00] bfp_in_a;
     reg  [31:00] bfp_in_b;
     wire [31:00] bfp_out_a;
     wire [31:00] bfp_out_b;
    
    // delayed output of the butterfly processor
     reg  [31:0] d_bfp_out_a;
     reg  [31:0] d_bfp_out_b;
     reg  [31:0] dd_bfp_out_a;
     reg  [31:0] dd_bfp_out_b;
    
    
    // Instantiation of the butterfly processor
    butterfly butterfly (
    .clk               (clk), 
    .reset             (en_fft),
    .read_data_a       (bfp_in_a),
    .read_data_b       (bfp_in_b), 
    .write_data_a      (bfp_out_a),
    .write_data_b      (bfp_out_b),
    .bfpcontrol        (controlsignal[4:0])
    );
    
    
    // Registers to hold the signals coming out of the control module
    // along with their delayed versions
     wire [2:0] RS1;
     wire [2:0] RS2;
     reg  [2:0] D_RS1;
     reg  [2:0] D_RS2;
     reg  [2:0] DD_RS1;
     reg  [2:0] DD_RS2;
     reg  [2:0] DDD_RS1;
     reg  [2:0] DDD_RS2;
     reg  [2:0] DDDD_RS1;
     reg  [2:0] DDDD_RS2;


     reg D_input_reg_sel;
     reg DD_input_reg_sel;
     reg DDD_input_reg_sel;
     reg DDDD_input_reg_sel;
     reg D_dest_bank_sel;
     reg DD_dest_bank_sel;
     reg DDD_dest_bank_sel;
     reg DDDD_dest_bank_sel;

     wire dest_bank_sel;
     wire readmem_en;
     wire input_reg_sel;
    
    assign memwrite_en   = controlsignal[14];
    assign readmem_en    = controlsignal[13];
    assign RS1[2:0]      = controlsignal[12:10];
    assign RS2[2:0]      = controlsignal[9:7];
    assign input_reg_sel = controlsignal[6];
    assign dest_bank_sel = controlsignal[5];
    
    
    // Instantiation of the MICROCODED STATE MACHINE control module
    control control(
    .clk               (clk),
    .en_fft            (en_fft),
    .done_fft          (done_fft),
    .controlsignal     (controlsignal)
    );
    
 // Instantiation of the Address Generation Unit
    agu agu(
    .clk               (clk),
    .en_fft            (en_fft),
    .readmem_en        (readmem_en),
    .memwrite_en       (memwrite_en),
    
    .agu_rd_addr0          (mem_rd_addr0),
    .agu_rd_addr1          (mem_rd_addr1),
    .agu_rd_addr2          (mem_rd_addr2),
    .agu_rd_addr3          (mem_rd_addr3),
    .agu_rd_addr4          (mem_rd_addr4),
    .agu_rd_addr5          (mem_rd_addr5),
    .agu_rd_addr6          (mem_rd_addr6),
    .agu_rd_addr7          (mem_rd_addr7),
    
    .agu_wr_addr0         (mem_wr_addr0),
    .agu_wr_addr1         (mem_wr_addr1),
    .agu_wr_addr2         (mem_wr_addr2),
    .agu_wr_addr3         (mem_wr_addr3),
    .agu_wr_addr4         (mem_wr_addr4),
    .agu_wr_addr5         (mem_wr_addr5),
    .agu_wr_addr6         (mem_wr_addr6),
    .agu_wr_addr7         (mem_wr_addr7)
    );
    
     
 
    // Multiplexer for selecting the butterfly input 'a' from reg bank 1
    reg [31:0]bfpr1_a;
    always @(RS1 or regbankone[0] or regbankone[1] or regbankone[2] or regbankone[3]
             or regbankone[4] or regbankone[5] or regbankone[6] or regbankone[7])
    begin
        if (RS1 == 0) begin
           bfpr1_a = regbankone[0];end
        if (RS1 == 1) begin
            bfpr1_a = regbankone[1]; end
        if (RS1 == 2) begin
           bfpr1_a= regbankone[2]; end
        if (RS1 == 3) begin
           bfpr1_a = regbankone[3]; end
        if (RS1 == 4) begin
           bfpr1_a = regbankone[4]; end   
        if (RS1 == 5) begin 
           bfpr1_a = regbankone[5]; end
        if (RS1 == 6) begin 
           bfpr1_a = regbankone[6]; end
        if (RS1 == 7) begin 
           bfpr1_a = regbankone[7]; end
    end           
       
           
    // Multiplexer for selecting the butterfly input 'b' from reg bank 1
    reg [31:0]bfpr1_b;
    always @(RS2 or regbankone[0] or regbankone[1] or regbankone[2] or regbankone[3]
             or regbankone[4] or regbankone[5] or regbankone[6] or regbankone[7])
    begin
        if (RS2 == 0) begin
           bfpr1_b = regbankone[0]; end
        if (RS2 == 1) begin
           bfpr1_b = regbankone[1]; end
        if (RS2 == 2) begin
           bfpr1_b = regbankone[2]; end
        if (RS2 == 3) begin
           bfpr1_b = regbankone[3]; end
        if (RS2 == 4) begin
           bfpr1_b = regbankone[4]; end   
        if (RS2 == 5) begin 
           bfpr1_b = regbankone[5]; end
        if (RS2 == 6) begin 
           bfpr1_b = regbankone[6]; end
        if (RS2 == 7) begin 
           bfpr1_b = regbankone[7]; end
    end 
    
       
    
    // Multiplexer for selecting the butterfly input 'a' from reg bank 2
    reg [31:0]bfpr2_a;
    always @(RS1 or regbanktwo[0] or regbanktwo[1] or regbanktwo[2] or regbanktwo[3]
             or regbanktwo[4] or regbanktwo[5] or regbanktwo[6] or regbanktwo[7])
    begin
        if (RS1 == 0) begin
           bfpr2_a = regbanktwo[0]; end
        if (RS1 == 1) begin
           bfpr2_a = regbanktwo[1]; end
        if (RS1 == 2) begin
           bfpr2_a = regbanktwo[2]; end
        if (RS1 == 3) begin
           bfpr2_a = regbanktwo[3]; end
        if (RS1 == 4) begin
           bfpr2_a = regbanktwo[4]; end   
        if (RS1 == 5) begin 
           bfpr2_a = regbanktwo[5]; end
        if (RS1 == 6) begin 
           bfpr2_a = regbanktwo[6]; end
        if (RS1 == 7) begin 
           bfpr2_a = regbanktwo[7]; end
    end       
    
    
    
     // Multiplexer for selecting the butterfly input 'b' from reg bank 2
    reg [31:0]bfpr2_b;
    always @(RS2 or regbanktwo[0] or regbanktwo[1] or regbanktwo[2] or regbanktwo[3]
             or regbanktwo[4] or regbanktwo[5] or regbanktwo[6] or regbanktwo[7])
    begin
        if (RS2 == 0) begin
           bfpr2_b = regbanktwo[0]; end
        if (RS2 == 1) begin
           bfpr2_b = regbanktwo[1]; end
        if (RS2 == 2) begin
           bfpr2_b = regbanktwo[2]; end
        if (RS2 == 3) begin
           bfpr2_b = regbanktwo[3]; end
        if (RS2 == 4) begin
           bfpr2_b = regbanktwo[4]; end   
        if (RS2 == 5) begin 
           bfpr2_b = regbanktwo[5]; end
        if (RS2 == 6) begin 
           bfpr2_b = regbanktwo[6]; end
        if (RS2 == 7) begin 
           bfpr2_b = regbanktwo[7]; end
    end    
    
    // Multiplexer to select the input a (from regbank 1 or 2)
    always @(input_reg_sel or bfpr1_a or bfpr2_a)
    begin
    bfp_in_a = (input_reg_sel == 1) ? bfpr2_a : bfpr1_a;
    end
             
     // Multiplexer to select the input b (from regbank 1 or 2)
    always @(input_reg_sel or bfpr1_b or bfpr2_b)
    begin
    bfp_in_b = (input_reg_sel == 1) ? bfpr2_b : bfpr1_b;
    end       
        
    reg dest_bank;      // signal to choose the target register bank.
    // Multiplexer to choose the Destination Register Bank for the output
    // of the Butterfly Processor
    always @(DDDD_input_reg_sel or DDDD_dest_bank_sel)
    begin
        dest_bank =(DDDD_dest_bank_sel)? ~DDDD_input_reg_sel : DDDD_input_reg_sel;
    end
    
    // Demultiplexer to choose the destination register bank for butterfly
    // outputs 'a' and 'b'.
    
    always @(readmem_en or dd_bfp_out_a or dd_bfp_out_b or dest_bank)
    begin
       if (readmem_en == 0) begin
          if (dest_bank == 0 )begin
           regbankone[DDDD_RS1] = dd_bfp_out_a;
           regbankone[DDDD_RS2] = dd_bfp_out_b; end
       
          if (dest_bank ==1) begin
           regbanktwo[DDDD_RS1] = dd_bfp_out_a;
           regbanktwo[DDDD_RS2] = dd_bfp_out_b; end
       end
   end
   
    
    // Write data buses are asynchronous
     assign wr_data0 = regbanktwo[0];
     assign wr_data1 = regbanktwo[1];
     assign wr_data2 = regbanktwo[2];
     assign wr_data3 = regbanktwo[3];
     assign wr_data4 = regbanktwo[4];
     assign wr_data5 = regbanktwo[5];
     assign wr_data6 = regbanktwo[6];
     assign wr_data7 = regbanktwo[7]; 
        
        
        
        
    // ALWAYS STATEMENT FOR DEFAULT INITIALIZATION OF DELAYED SIGNALS
    // AND TO DELAY ALL THE NECESSARY SIGNALS
    always @(posedge clk)
    begin
        if (en_fft==1)
        begin 
        // reset all the signals here
        DDDD_RS1<=0;
        DDD_RS1<=0;
        DD_RS1 <=0;
        D_RS1  <=0;
        
        DDDD_RS2<=0;
        DDD_RS2<=0;
        DD_RS2 <=0;
        D_RS2  <=0;
        
        DDDD_input_reg_sel<=0;
        DDD_input_reg_sel<=0;
        DD_input_reg_sel <=0;
        D_input_reg_sel  <=0;
        
        DDDD_dest_bank_sel<=0;
        DDD_dest_bank_sel<=0;
        DD_dest_bank_sel <=0;
        D_dest_bank_sel  <=0;
        end
        
        // DELAY ALL THE SIGNALS HERE //
        DDDD_RS1<=DDD_RS1;
        DDD_RS1<=DD_RS1;
        DD_RS1 <=D_RS1;
        D_RS1  <=RS1;
        
        DDDD_RS2<=DDD_RS2;
        DDD_RS2<=DD_RS2;
        DD_RS2 <=D_RS2;
        D_RS2  <=RS2;
   
        dd_bfp_out_a <= d_bfp_out_a;
        dd_bfp_out_b <= d_bfp_out_b;
        d_bfp_out_a <= bfp_out_a;
        d_bfp_out_b <= bfp_out_b;
        
        DDDD_input_reg_sel<= DDD_input_reg_sel;
        DDD_input_reg_sel<= DD_input_reg_sel;
        DD_input_reg_sel <= D_input_reg_sel;
        D_input_reg_sel  <= input_reg_sel;
        
        DDDD_dest_bank_sel<=DDD_dest_bank_sel;
        DDD_dest_bank_sel<=DD_dest_bank_sel;
        DD_dest_bank_sel <=D_dest_bank_sel;
        D_dest_bank_sel  <=dest_bank_sel;

     // Write read data bus onto regbank 1 when reading from memory
        if (readmem_en == 1) 
       begin
            regbankone[0] = rd_data0;
            regbankone[1] = rd_data1;
            regbankone[2] = rd_data2;
            regbankone[3] = rd_data3;
            regbankone[4] = rd_data4;
            regbankone[5] = rd_data5;
            regbankone[6] = rd_data6;
            regbankone[7] = rd_data7; 
        end
        
    end
endmodule