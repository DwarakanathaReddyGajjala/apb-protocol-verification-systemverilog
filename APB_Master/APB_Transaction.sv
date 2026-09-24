`ifndef _APB_TRANSACTION_    // GAURD BAND
`define _APB_TRANSACTION_    //GAURD BAND

class APB_Transaction;
       bit        PSELx   ;
       bit        PENABLE ;
  rand bit        PWRITE  ;
  rand bit [7:0]  PADDR   ;
  rand bit [7:0]  PWDATA  ;
       bit [7:0]  PRDATA  ;
       bit        PREADY  ;
       bit        PSLVERR ;
 /*
   By default, constraints are hard constraints.
   A hard constraint cannot be overridden by an inline constraint.
   To allow an inline constraint to override a constraint,
   declare the original constraint as a soft constraint.
  */
  constraint PADDR_c {soft PADDR inside{[1:125]};} 
  
  function void display(string name);
    $display("Time=[%0t] class=%0s,PSELx=%0d,PENABLE=%0d,PWRITE=%0d,PADDR=%0d,PWDATA=%0d,PRDATA=%0d,PREADY=%0d,PSLVERR=%0d" ,$time,name,PSELx,PENABLE,PWRITE,PADDR,PWDATA,PRDATA,PREADY,PSLVERR);
  endfunction : display
endclass : APB_Transaction

`endif 
