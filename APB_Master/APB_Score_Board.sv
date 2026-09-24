`ifndef _APB_SCORE_BOARD    // GAURD BAND
`define _APB_SCORE_BOARD    //GAURD BAND

class APB_Score_Board;
  reg [7:0] memory_sb [127:0];
  APB_Transaction APB_Transaction_h;  
  mailbox mb2 ;
  
  function new(mailbox mb2);
    $display("APB_Score_Board: new function started");
    this.mb2 = mb2;
    $display("APB_Score_Board: new function reached the end");
  endfunction   
  
  task run();
    $display("APB_Score_Board: run task started");
    for(integer i=0; i<127; i++) begin 
        memory_sb[i] = i;
    end 
    forever begin 
      APB_Transaction_h = new();
      APB_Transaction_h.display("SCOREBOARD: Before receiving transaction");
      mb2.get(APB_Transaction_h);
      APB_Transaction_h.display("SCOREBOARD: Received transaction");
      if(APB_Transaction_h.PWRITE) begin 
        memory_sb[APB_Transaction_h.PADDR] = APB_Transaction_h.PWDATA;
        $display("APB_Scoreboard: Write data stored in reference memory");
      end 
      else begin
        APB_Transaction_h.display("SCOREBOARD: before read data compare ");
        $display("APB_Scoreboard: memory_sb[%0d]=%0d",APB_Transaction_h.PADDR,memory_sb[APB_Transaction_h.PADDR]);
        if(memory_sb[APB_Transaction_h.PADDR] == APB_Transaction_h.PRDATA)begin
          $display("APB_Scoreboard: Read data matched");
        end
        else 
          $display("APB_Scoreboard: Read data mismatched");
      end 
    end 
    $display("APB_Score_Board: run task reached the end");
  endtask: run
  
endclass : APB_Score_Board

`endif 
