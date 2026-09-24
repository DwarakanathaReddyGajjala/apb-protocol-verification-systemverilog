`ifndef _APB_GENERATOR_    // GAURD BAND
`define _APB_GENERATOR_    //GAURD BAND

class APB_Generator;
  
  /*
  Test Case 0: Write-only operation
  Test Case 1: Read-only operation
  Test Case 2: Random read and write operations
  Test Case 3: Write followed by Read operation
  Test Case 4: Reset condition
  Test Case 5: All Writes followed by Reads from the same addresses
  Test Cases 6, 7: Reserved for future implementation
*/
  bit[2:0] test_case;
  
  APB_Transaction APB_Transaction_h,APB_Transaction_h1;
  mailbox mb1 ;
  mailbox mb;
  bit pwrite;
  int pkt_count;
  int write_count;
    
  function new(mailbox mb1,bit[2:0] test_case);
    $display("APB_Generator: new function started");
    this.test_case = test_case;
    this.mb1 = mb1;
    mb = new();
    $display("APB_Generator: new function reached the end");
  endfunction 
  
  task run();
    $display("APB_Generator: run task started");
    repeat(pkt_count) begin
      write_count = write_count + 1;
      if(test_case == 0 ||test_case == 1 ) begin 
        APB_Transaction_h = new();
        //test_case = 0  Write-only operation (APB_Write_Test).
        //test_case = 1  Read-only operation (APB_Write_Test).
        APB_Transaction_h.randomize () with {APB_Transaction_h.PWRITE == pwrite;}; 
        mb1.put(APB_Transaction_h);
        APB_Transaction_h.display("APB_Generator");
      end
      else if(test_case == 2) begin 
        APB_Transaction_h = new();
        //test_case = 2  Random read and write operations.
        APB_Transaction_h.randomize(); 
        mb1.put(APB_Transaction_h);
        APB_Transaction_h.display("APB_Generator");
      end 
      else if(test_case == 3) begin 
        APB_Transaction_h = new();  
        APB_Transaction_h.randomize();
        mb1.put(APB_Transaction_h);
        APB_Transaction_h.display("APB_Generator");
        //test_case =3 Write followed by Read operation.
        if(APB_Transaction_h.PWRITE) begin 
          APB_Transaction_h1 = new APB_Transaction_h;
          APB_Transaction_h1.PWRITE = 1'b0;
          mb1.put(APB_Transaction_h1);
          APB_Transaction_h1.display("APB_Generator1");
        end
      end
      else if(test_case == 5) begin 
        /*Test Case 5: Generate all WRITE transactions first,
        then generate READ transactions using the same WRITE addresses.*/
        APB_Transaction_h = new();  
        APB_Transaction_h.randomize()with{APB_Transaction_h.PWRITE == pwrite;};
        // Store WRITE address for later READ operation.
        mb.put(APB_Transaction_h.PADDR);
        // After the last WRITE transaction, switch to READ operation.
        mb1.put(APB_Transaction_h);
        APB_Transaction_h.display("APB_Generator");
        pwrite =  !(write_count == pkt_count); 
        // Generate READ transactions using the previously stored WRITE addresses.
        if(!pwrite ) begin
          repeat(write_count) begin 
            APB_Transaction_h = new();
            APB_Transaction_h.randomize()with{APB_Transaction_h.PWRITE == pwrite;};
            mb.get(APB_Transaction_h.PADDR);
            mb1.put(APB_Transaction_h);
            APB_Transaction_h.display("APB_Generator1");
          end 
         end
      end
      else 
        $display("APB_Generator: Reset condition");
    end 
      $display("APB_Generator: run task reached the end");
  endtask: run
endclass : APB_Generator

`endif 
