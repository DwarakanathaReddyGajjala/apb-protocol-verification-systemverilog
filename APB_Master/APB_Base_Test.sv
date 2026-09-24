`ifndef _APB_BASE_TEST_    // GAURD BAND
`define _APB_BASE_TEST_    //GAURD BAND

class APB_Base_Test;
  
  /*lass is dynamic and interface is static.
  So, we cannot directly instantiate an interface inside a class.
  We use a virtual interface handle to connect the class with the
  actual interface instance.
  The actual interface handle is passed through the constructor
  */
  virtual APB_Interface vif;
  APB_Env APB_Env_h ;
  
  function new(virtual APB_Interface vif,bit[2:0] test_case);
    $display("APB_Base_Test: new function started");
    this.vif = vif;
    APB_Env_h = new(vif,test_case);
    $display("APB_Base_Test: new function reached the end");
  endfunction 
    
  virtual task run();
    $display("APB_Base_Test: run task started");
    APB_Env_h.APB_Generator_h.pkt_count =50; 
    APB_Env_h.run();
    $display("APB_Base_Test: run task reached the end");
  endtask: run
endclass : APB_Base_Test

`endif 

