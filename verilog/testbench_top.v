/*-- Arish Alreja: ECE 4902 Special Problems Spring 2006
-- School of Electrical & Computer Engineering
-- Georgia Institute of Technology
-- Atlanta, GA 30332
--
-- 64 point FFT Processor 
--		
-- FFT Processor test application Top Level                      
-- Author(s):                                                  
--     - Mohanned Sinnokrot
--     - Arish Alreja*/
 

`define RESET_TIME 8
`define FFT_DMEM0_INIT "mem0.in"
`define FFT_DMEM1_INIT "mem1.in"
`define FFT_DMEM2_INIT "mem2.in"
`define FFT_DMEM3_INIT "mem3.in"
`define FFT_DMEM4_INIT "mem4.in"
`define FFT_DMEM5_INIT "mem5.in"
`define FFT_DMEM6_INIT "mem6.in"
`define FFT_DMEM7_INIT "mem7.in"

`define FFT_DMEM0_DUMP "mem0.out"
`define FFT_DMEM1_DUMP "mem1.out"
`define FFT_DMEM2_DUMP "mem2.out"
`define FFT_DMEM3_DUMP "mem3.out"
`define FFT_DMEM4_DUMP "mem4.out"
`define FFT_DMEM5_DUMP "mem5.out"
`define FFT_DMEM6_DUMP "mem6.out"
`define FFT_DMEM7_DUMP "mem7.out"

module testbench_top ();


// --------------------------------------------------
// System Tasks
// --------------------------------------------------
reg           clk;
reg           rst;
reg           en_fft;

// -----------------------------------------------------------------------------
// Clock Task
// -----------------------------------------------------------------------------
initial
  clk = 1'b0;

always
  clk = #10 ~clk;


 

// -----------------------------------------------------------------------------
// NAME    : Reset
// TYPE    : Task
// PURPOSE : The purpose of this task is to reset the FFT Processor.
// -----------------------------------------------------------------------------
 initial
   rst = 1'b1;
 
 task reset;
 begin
   $display ("\n\t\t *********************** -------------------------- ***********************");
   $display ("\n\t\t                          Resetting FFT PROCESSOR                          ");
   $display ("\n\t\t *********************** -------------------------- ***********************");
   rst <= #1 1'b1;
   tk_wait(`RESET_TIME);
   rst <= #1 1'b0;
 end

 endtask

// -----------------------------------------------------------------------------
// NAME    : init_dmem
// TYPE    : Task
// PURPOSE : The purpose of this task is to initialize Data memory 
// -----------------------------------------------------------------------------
 
 task init_dmem;
 begin
   $display ("\n\t\t *********************** -------------------------- ***********************");
   $display ("\n\t\t                             Loading Data Memory                        ");
   $display ("\n\t\t *********************** -------------------------- ***********************");
   $readmemh(`FFT_DMEM0_INIT, memory0.memory);
   $readmemh(`FFT_DMEM1_INIT, memory1.memory);
   $readmemh(`FFT_DMEM2_INIT, memory2.memory);
   $readmemh(`FFT_DMEM3_INIT, memory3.memory);
   $readmemh(`FFT_DMEM4_INIT, memory4.memory);
   $readmemh(`FFT_DMEM5_INIT, memory5.memory);
   $readmemh(`FFT_DMEM6_INIT, memory6.memory);
   $readmemh(`FFT_DMEM7_INIT, memory7.memory);   
 end
 endtask
 
 
// -----------------------------------------------------------------------------
// NAME    : tk_wait
// TYPE    : Task
// PURPOSE : task to wait for specified number of cycles
// -----------------------------------------------------------------------------
 task tk_wait;
 input[31:0] count;
 integer i;
 begin
   $display ("\n\t\t *********************** -------------------------- ***********************");
   $display ("\n\t\t                         Waiting for FFT to execute                       ");
   $display ("\n\t\t *********************** -------------------------- ***********************");
 
      for(i=0;i<=count;i=i+1)
          @(posedge clk);
 end
 endtask

// -----------------------------------------------------------------------------
// NAME    : dump_dmem
// TYPE    : Task
// PURPOSE : task to dump Memory Contents
// ---------------------------------------------------------------------------
task dump_dmem;
integer i;
integer fdmem0;
integer fdmem1;
integer fdmem2;
integer fdmem3;
integer fdmem4;
integer fdmem5;
integer fdmem6;
integer fdmem7;

reg [31:0] dmemw0;
reg [31:0] dmemw1;
reg [31:0] dmemw2;
reg [31:0] dmemw3;
reg [31:0] dmemw4;
reg [31:0] dmemw5;
reg [31:0] dmemw6;
reg [31:0] dmemw7;

begin
	$display ("\n\t\t *********************** -------------------------- ***********************");
   $display ("\n\t\t                             Dumping Data Memory                        ");
   $display ("\n\t\t *********************** -------------------------- ***********************");
   fdmem0 = $fopen(`FFT_DMEM0_DUMP);
	fdmem1 = $fopen(`FFT_DMEM1_DUMP);
	fdmem2 = $fopen(`FFT_DMEM2_DUMP);
	fdmem3 = $fopen(`FFT_DMEM3_DUMP);
	fdmem4 = $fopen(`FFT_DMEM4_DUMP);
	fdmem5 = $fopen(`FFT_DMEM5_DUMP);
	fdmem6 = $fopen(`FFT_DMEM6_DUMP);
	fdmem7 = $fopen(`FFT_DMEM7_DUMP);
	for (i = 0; i < (8); i = i + 1)
	begin
      dmemw0 = memory0.memory[i];
      dmemw1 = memory1.memory[i];
      dmemw2 = memory2.memory[i];
      dmemw3 = memory3.memory[i];
      dmemw4 = memory4.memory[i];
      dmemw5 = memory5.memory[i];
      dmemw6 = memory6.memory[i];
      dmemw7 = memory7.memory[i];
		$fdisplay(fdmem0, "%d \n",dmemw0);
		$fdisplay(fdmem1, "%d \n",dmemw1);
		$fdisplay(fdmem2, "%d \n",dmemw2);
		$fdisplay(fdmem3, "%d \n",dmemw3);
		$fdisplay(fdmem4, "%d \n",dmemw4);
		$fdisplay(fdmem5, "%d \n",dmemw5);
		$fdisplay(fdmem6, "%d \n",dmemw6);
		$fdisplay(fdmem7, "%d \n",dmemw7);
   end
   $fclose(fdmem0);
   $fclose(fdmem1);
   $fclose(fdmem2);
   $fclose(fdmem3);
   $fclose(fdmem4);
   $fclose(fdmem5);
   $fclose(fdmem6);
   $fclose(fdmem7);
end
endtask


// -----------------------------------------------------------------------------
// NAME    : enable_fft
// TYPE    : Task
// PURPOSE : The purpose of this task is to send the en_fft signal to start the FFT.
// -----------------------------------------------------------------------------
 initial
   en_fft = 1'b0;
 
 task enable_fft ;
 begin
   $display ("\n\t\t *********************** -------------------------- ***********************");
   $display ("\n\t\t                                 Enabling FFT                                     ");
   $display ("\n\t\t *********************** -------------------------- ***********************");
   en_fft <= #1 1'b1;
   @(posedge clk);
   en_fft <= #1 1'b0;
 end

 endtask



// -----------------------------------------------------------------------------
// Sequence of Events of FFT Simulation
// ----------------------------------------------------------------------------- 

 initial
 begin

       reset;              // Resetting the FFT processor
       
       init_dmem;          // Initialize Data Memory
       
       enable_fft;         // Enable FFT
      
       tk_wait(210);       // Wait for FFT to complete (196 cycles)

       // --Simulation has ended--
       
       dump_dmem;          // Dump the data memory
       
       $stop;

 end



// --------------------------------------------------
// Module Instantiation
// --------------------------------------------------
//

//
// Declare the wires to connect the memory to the fft processor
//

wire [2:0] read_add0;
wire [2:0] read_add1;
wire [2:0] read_add2;
wire [2:0] read_add3;
wire [2:0] read_add4;
wire [2:0] read_add5;
wire [2:0] read_add6;
wire [2:0] read_add7;

wire [2:0] write_add0;
wire [2:0] write_add1;
wire [2:0] write_add2;
wire [2:0] write_add3;
wire [2:0] write_add4;
wire [2:0] write_add5;
wire [2:0] write_add6;
wire [2:0] write_add7;

wire [31:00] read_data0;
wire [31:00] read_data1;
wire [31:00] read_data2;
wire [31:00] read_data3;
wire [31:00] read_data4;
wire [31:00] read_data5;
wire [31:00] read_data6;
wire [31:00] read_data7;

wire [31:00] write_data0;
wire [31:00] write_data1;
wire [31:00] write_data2;
wire [31:00] write_data3;
wire [31:00] write_data4;
wire [31:00] write_data5;
wire [31:00] write_data6;
wire [31:00] write_data7;


wire memwrite_en;
wire done_fft;
// Instantiate the FFT Processor MODULE
//
fft fft(

	.clk		         (clk),
	.en_fft		      (en_fft),
	.done_fft	     (done_fft),
   .memwrite_en   (memwrite_en),
   
	.mem_rd_addr0  (read_add0), 
   .mem_rd_addr1  (read_add1), 
   .mem_rd_addr2  (read_add2), 
   .mem_rd_addr3  (read_add3), 
   .mem_rd_addr4  (read_add4), 
   .mem_rd_addr5  (read_add5), 
   .mem_rd_addr6  (read_add6), 
   .mem_rd_addr7  (read_add7), 
      
   .mem_wr_addr0  (write_add0), 
   .mem_wr_addr1  (write_add1), 
   .mem_wr_addr2  (write_add2), 
   .mem_wr_addr3  (write_add3), 
   .mem_wr_addr4  (write_add4), 
   .mem_wr_addr5  (write_add5), 
   .mem_wr_addr6  (write_add6), 
   .mem_wr_addr7  (write_add7), 
        
   .rd_data0      (read_data0), 
   .rd_data1      (read_data1), 
   .rd_data2      (read_data2), 
   .rd_data3      (read_data3), 
   .rd_data4      (read_data4), 
   .rd_data5      (read_data5), 
   .rd_data6      (read_data6), 
   .rd_data7      (read_data7), 
       
   .wr_data0      (write_data0),
   .wr_data1      (write_data1),
   .wr_data2      (write_data2),
   .wr_data3      (write_data3),
   .wr_data4      (write_data4),
   .wr_data5      (write_data5),
   .wr_data6      (write_data6),
   .wr_data7      (write_data7)
       
);


//
// Instantiate the memory (8 banks)
//
 memory memory0(
       .clk         (clk),
       .read_add    (read_add0), 
       .write_add   (write_add0), 
       .read_data   (read_data0), 
       .write_data  (write_data0), 
       .memwrite_en (memwrite_en)
       );
    
 memory memory1(
       .clk         (clk),
       .read_add    (read_add1), 
       .write_add   (write_add1), 
       .read_data   (read_data1), 
       .write_data  (write_data1), 
       .memwrite_en (memwrite_en)
       );
    
 memory memory2(
       .clk         (clk),
       .read_add    (read_add2), 
       .write_add   (write_add2), 
       .read_data   (read_data2), 
       .write_data  (write_data2), 
       .memwrite_en (memwrite_en)
       );
       
 memory memory3(
       .clk         (clk),
       .read_add    (read_add3), 
       .write_add   (write_add3), 
       .read_data   (read_data3), 
       .write_data  (write_data3), 
       .memwrite_en (memwrite_en)
       );
    
 memory memory4(
       .clk         (clk),
       .read_add    (read_add4), 
       .write_add   (write_add4), 
       .read_data   (read_data4), 
       .write_data  (write_data4), 
       .memwrite_en (memwrite_en)
       );
    
 memory memory5(
       .clk         (clk),
       .read_add    (read_add5), 
       .write_add   (write_add5), 
       .read_data   (read_data5), 
       .write_data  (write_data5), 
       .memwrite_en (memwrite_en)
       );
       
memory memory6(
       .clk         (clk),
       .read_add    (read_add6), 
       .write_add   (write_add6), 
       .read_data   (read_data6), 
       .write_data  (write_data6), 
       .memwrite_en (memwrite_en)
       );

 memory memory7(
       .clk         (clk),
       .read_add    (read_add7), 
       .write_add   (write_add7), 
       .read_data   (read_data7), 
       .write_data  (write_data7), 
       .memwrite_en (memwrite_en)
       );
    
     
endmodule