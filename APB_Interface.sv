`ifndef _APB_INTERFACE// GAURD BAND
`define _APB_INTERFACE//GAURD BAND

interface APB_Interface(input logic PCLK,input logic PRESETn);

  //control signls 
  logic PSELx  ;
  logic PENABLE;
  logic PREADY ;
  logic PWRITE ;
  logic PSLVERR;

  //side band signls 
  logic [7:0] PADDR  ;
  logic [7:0] PWDATA ;
  logic [7:0] PRDATA ;
  
endinterface : APB_Interface 

`endif 
