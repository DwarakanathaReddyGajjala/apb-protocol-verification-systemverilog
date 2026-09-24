`ifndef _APB_DRIVER_    // GAURD BAND
`define _APB_DRIVER_    //GAURD BAND

class APB_Driver;

  APB_Transaction APB_Transaction_h;  
  virtual APB_Interface vif;
  mailbox mb1 ;
  
  function new(mailbox mb1,virtual APB_Interface vif);
    $display("APB_Driver: new function started");
    this.mb1 = mb1;
    this.vif = vif;
    $display("APB_Driver: new function reached the end");
  endfunction 
  
  task run();
    $display("APB_Driver: run task started");
    APB_Transaction_h = new();
    forever begin 
      if(!vif.PRESETn)
        reset_logic();
      else begin 
        mb1.get(APB_Transaction_h);
        driver_logic();
      end 
    end 
    $display("APB_Driver: run task reached the end");
  endtask : run 
  
  task reset_logic();
    $display("APB_Driver: TIME=[%0t] Entered reset logic task of driver",$time);
    vif.PSELx  <= 1'b0 ;
    vif.PENABLE<= 1'b0 ;
    vif.PWRITE <= 1'b0 ;
    vif.PADDR  <= 32'b0;
    vif.PWDATA <= 32'b0;
    /*Delay is required at the end of reset_logic.
    Without the delay, the test may hang when PRESETn = 0.*/
    @(posedge vif.PCLK);
    $display("APB_Driver: TIME=[%0t] out of reset logic task of driver",$time);
  endtask : reset_logic 
    
  task driver_logic();
    //setup state
    $display("APB_Driver: TIME=[%0t] Entered to driver logic of setup state",$time);
    APB_Transaction_h.display("APB_Driver");
    vif.PSELx   <= 1'b1                    ;
    vif.PENABLE <= 1'b0                    ;
    vif.PWRITE  <= APB_Transaction_h.PWRITE;
    vif.PADDR   <= APB_Transaction_h.PADDR ;
    vif.PWDATA  <= APB_Transaction_h.PWDATA;
    @(posedge vif.PCLK); 
    //access state
    $display("APB_Driver: TIME=[%0t] inside driver logic of access state ",$time);
    vif.PSELx   <= 1'b1 ;
    vif.PENABLE <= 1'b1 ;
    $display("APB_Driver: TIME=[%0t] inside driver logic waiting for Pready",$time);
    wait(vif.PREADY)    ;
    @(posedge vif.PCLK) ; 
    $display("APB_Driver: TIME=[%0t] inside driver logic Pready asseted by slave",$time);
    //ideal state
    $display("APB_Driver: TIME=[%0t] Entered to idle state of driver",$time);
    vif.PSELx   <= 1'b0 ;
    vif.PENABLE <= 1'b0 ;
    @(posedge vif.PCLK) ; 
    $display("APB_Driver: TIME=[%0t] inside driver logic going back to idle state",$time);
  endtask : driver_logic
endclass : APB_Driver

`endif 
