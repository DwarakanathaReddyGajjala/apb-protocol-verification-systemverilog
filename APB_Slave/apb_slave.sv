// Code your design here

module apb_slave (
    input             PCLK   , // Peripheral Clock
    input             PRESETn, // Active Low Reset
    input             PSELx  , // Slave Select
    input             PENABLE, // Enable Signal
    input             PWRITE , // Write (1) / Read (0)
    input      [7:0]  PADDR  , // Address of Slave
    input      [7:0]  PWDATA , // Write Data
    output reg [7:0]  PRDATA , // Read Data
    output reg        PREADY ,  
    output reg        PSLVERR  
);

  parameter N = 4;  // Number of wait states

  reg [7:0] mem [255:0]         ; // 8x8-bit memory
  reg [2:0] wait_counter        ; // Counter for wait states
  reg transaction_active   = 0  ; //  indicate an active transaction
  reg transaction_active_d = 0  ; //  indicate an active transaction
  reg PREADY_reg ;

  always @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
      PSLVERR            <= 0   ;
      PRDATA             <= 8'b0;
      transaction_active <= 0   ;
      wait_counter       <= 0   ;
      PREADY_reg <=0;
      for (integer i = 0; i < 256; i = i + 1) begin
        mem[i] <= i; 
      end
    end 
    else begin
      if (PSELx && PENABLE && !transaction_active && !PREADY_reg) begin
        transaction_active <= 1; 
        wait_counter       <= 0;
      end
      if (transaction_active) begin
        if (wait_counter < N - 1) begin
          wait_counter <= wait_counter + 1; 
        end 
        else begin
          PREADY_reg         <= 1;  
          transaction_active <= 0; 
          if (PWRITE) begin
            mem[PADDR] <= PWDATA;  
          end
          else begin
            PRDATA <= mem[PADDR]; 
          end
        end
      end 
      else begin
        PREADY_reg <= 0; 
      end
    end
  end
  
  always @(posedge PCLK) begin 
    transaction_active_d <= transaction_active;
  end
  
  assign PREADY = PREADY_reg;
  
endmodule






