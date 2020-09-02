//4-bit Up counter



module up_counter    (
counter_out     ,  // counter_output of the counter
enable  ,  // enable for counter
clk     ,  // clock Input
reset      // reset Input
);
//----------counter_output Ports--------------
   output [3:0] counter_out;
//------------Input Ports--------------
   input enable, clk, reset;
//------------Internal Variables--------
   reg [3:0] counter_out;
//-------------Code Starts Here-------
always @(posedge clk)
if (reset) begin
   counter_out <= 4'b0 ;
end else if (enable) begin
   counter_out <= counter_out + 1;
end

endmodule 
