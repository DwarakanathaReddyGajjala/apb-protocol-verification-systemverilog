`ifndef _APB_ENV_    // GAURD BAND
`define _APB_ENV_    //GAURD BAND

class APB_Env;
  
  virtual APB_Interface vif;
  mailbox mb1 ;
  mailbox mb2 ;
  APB_Generator   APB_Generator_h  ;
  APB_Driver      APB_Driver_h     ;
  APB_Monitor     APB_Monitor_h    ;
  APB_Score_Board APB_Score_Board_h;
  
  function new(virtual APB_Interface vif,bit[2:0] test_case);
    $display("APB_Env: new function started");
    this.vif            = vif;
    mb1                 = new();
    mb2                 = new();
    APB_Generator_h     = new(mb1,test_case);
    APB_Driver_h        = new(mb1,vif) ;
    APB_Monitor_h       = new(mb2,vif) ;
    APB_Score_Board_h   = new(mb2)     ;
    $display("APB_Env: new function reached the end");
  endfunction 
  
  task run();
    $display("APB_Env: run task started");
    fork 
      APB_Generator_h.run();
      APB_Driver_h.run();
      APB_Monitor_h.run();
      APB_Score_Board_h.run();
    join_any 
    $display("APB_Env: run task reached the end");
  endtask: run
  
endclass : APB_Env

`endif 
