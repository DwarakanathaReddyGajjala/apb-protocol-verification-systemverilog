`ifndef _APB_MONITOR_    // GAURD BAND
`define _APB_MONITOR_    //GAURD BAND

class APB_Monitor;

  APB_Transaction APB_Transaction_h;
  virtual APB_Interface vif;
  
  mailbox mb2 ;
  function new(mailbox mb2,virtual APB_Interface vif);
    $display("APB_Monitor: new function started");
    this.mb2 = mb2;
    this.vif = vif;
    $display("APB_Monitor: new function reached the end");
  endfunction   
  
  task run();
    $display("APB_Monitor: run task started");
    forever begin
      APB_Transaction_h = new();
      wait(vif.PSELx && vif.PENABLE && vif.PREADY);
      APB_Transaction_h.PREADY  = vif.PREADY ;
      APB_Transaction_h.PWRITE  = vif.PWRITE ;
      APB_Transaction_h.PADDR   = vif.PADDR  ;
      APB_Transaction_h.PWDATA  = vif.PWDATA ;
      APB_Transaction_h.PRDATA  = vif.PRDATA ;
      APB_Transaction_h.PSLVERR = vif.PSLVERR;
      mb2.put(APB_Transaction_h);
      APB_Transaction_h.display("APB_Monitor");
      wait(!vif.PSELx && !vif.PENABLE);
    end 
    $display("APB_Monitor: run task reached the end");
  endtask: run
  
endclass : APB_Monitor

`endif 
