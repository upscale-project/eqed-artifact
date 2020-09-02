`include "counter.v"
module counter_tb();
// Declare inputs as regs and outputs as wires
reg clk, reset, enable;
wire [3:0] counter_out;

// Initialize all variables
initial begin        
  $display ("time\t clk reset enable counter");	
  $monitor ("%g\t %b   %b     %b      %b", 
	  $time, clk, reset, enable, counter_out);	
  clk = 1;       // initial value of clk
  reset = 0;       // initial value of reset
  enable = 0;      // initial value of enable
  #5 reset = 1;    // Assert the reset
  #10 reset = 0;   // De-assert the reset
  #10 enable = 1;  // Assert enable
  #100 enable = 0; // De-assert enable
  #5 $finish;      // Terminate simulation
end

// clk generator
always begin
  #5 clk = ~clk; // Toggle clk every 5 ticks
end

// Connect DUT to test bench
up_counter U_counter (
clk,
reset,
enable,
counter_out
);

endmodule
