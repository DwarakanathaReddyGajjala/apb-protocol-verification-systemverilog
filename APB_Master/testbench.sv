// Code your testbench here
// or browse Examples
`include "APB_Interface.sv"
`include "APB_Transaction.sv"
`include "APB_Generator.sv"
`include "APB_Driver.sv"
`include "APB_Monitor.sv"
`include "APB_Score_Board.sv"
`include "APB_Env.sv"
`include "APB_Base_Test.sv"
`include "APB_Write_Test.sv"
`include "APB_Read_Test.sv"

module tb;
  reg PCLK   ;
  reg PRESETn;
  
 /*
  Test Case 0: Write-only operation
  Test Case 1: Read-only operation
  Test Case 2: Random read and write operations
  Test Case 3: Write followed by Read operation
  Test Case 4: Reset condition
  Test Case 5: All Writes followed by Reads from the same addresses
  Test Cases 6, 7: Reserved for future implementation
*/
  
  bit[2:0] test_case = 5;
  
  APB_Interface apb_inf
  (
    .PCLK    ( PCLK   ),
    .PRESETn ( PRESETn)
  );
  
   apb_slave dut
  (
    .PCLK    ( PCLK            ),
    .PRESETn ( PRESETn         ),
    .PSELx   ( apb_inf.PSELx   ),
    .PENABLE ( apb_inf.PENABLE ),
    .PWRITE  ( apb_inf.PWRITE  ),
    .PADDR   ( apb_inf.PADDR   ),
    .PWDATA  ( apb_inf.PWDATA  ),
    .PRDATA  ( apb_inf.PRDATA  ),
    .PREADY  ( apb_inf.PREADY  ),
    .PSLVERR ( apb_inf.PSLVERR )
);
  
  initial PCLK = 1'b0;
  
  always #5 PCLK = ~ PCLK;
  
  initial begin 
    if(test_case == 4) begin 
      //test_case = 4  Reset condition
       PRESETn = 1'b0;
    end 
    else begin 
      PRESETn = 1'b0;
      @(posedge PCLK);
      #1; PRESETn = 1'b1;
    end 
  end 
  
  initial begin 
    if(test_case == 0 || test_case == 5) begin 
      //test_case = 0  Write-only operation (APB_Write_Test).
      APB_Write_Test APB_Write_Test_h;
      APB_Base_Test  APB_Base_Test_h;
      APB_Write_Test_h = new(apb_inf,test_case);
      APB_Base_Test_h = APB_Write_Test_h;
      APB_Base_Test_h.run();
    end 
    else if(test_case == 1) begin 
      //test_case = 1  Read-only operation (APB_Read_Test).
      APB_Read_Test APB_Read_Test_h;
      APB_Base_Test  APB_Base_Test_h;
      APB_Read_Test_h = new(apb_inf,test_case);
      APB_Base_Test_h = APB_Read_Test_h;
      APB_Base_Test_h.run();
    end
    else begin 
      //test_case = 2  Random read and write operations.
      //test_case = 3  Write followed by Read operation.
      APB_Base_Test APB_Base_Test_h;
      APB_Base_Test_h = new(apb_inf,test_case);
      APB_Base_Test_h.run();
    end 
  end 
  
  initial begin 
    $dumpfile("testbench.vcd");
    $dumpvars(0,tb);
  end 
  
  initial begin 
    #4500 $finish;
  end 
  
endmodule 

    
  
  
