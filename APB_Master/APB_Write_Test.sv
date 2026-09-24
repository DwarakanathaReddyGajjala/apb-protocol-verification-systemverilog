`ifndef _APB_WRITE_TEST_    // GAURD BAND
`define _APB_WRITE_TEST_    //GAURD BAND

class APB_Write_Test extends APB_Base_Test;
  virtual APB_Interface vif;
  APB_Env APB_Env_h ;
  
  function new(virtual APB_Interface vif,bit[2:0] test_case);
    super.new(vif,test_case);
    $display("APB_Write_Test: inside new function");
    this.vif = vif;
    APB_Env_h = new(vif,test_case);
    $display("APB_Write_Test: new function reached the end");

  endfunction 
    
  virtual task run();
    $display("APB_Write_Test: run task started");
    APB_Env_h.APB_Generator_h.pkt_count =5; 
    APB_Env_h.APB_Generator_h.pwrite = 1'b1;
    APB_Env_h.run();
    $display("APB_Write_Test: run task reached the end");
  endtask: run
  
endclass : APB_Write_Test

`endif 

