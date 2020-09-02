
module DUT (A, B, clk, rst, X, Y, Z);

input A, B, clk, rst;
output X, Y, Z;
wire aFFout, bFFout, aFF2xFF, bFF2zFF, and2yFF;
wire xFF2xSR, yFF2ySR, zFF2zSR;

dff_async_reset aFF(A, clk, rst, aFFout);
dff_async_reset bFF(B, clk, rst, bFFout);

and U1(and2yFF, aFFout, bFFout);

dff_async_reset xFF(aFFout, clk, rst, xFF2xSR);
dff_async_reset yFF(and2yFF, clk, rst, yFF2ySR);
dff_async_reset zFF(bFFout, clk, rst, zFF2zSR);

shift xSR(clk, xFF2xSR, X);
shift xSR(clk, yFF2ySR, Y);
shift xSR(clk, zFF2zSR, Z);

endmodule


endmodule

// 3 bit shift register
module shift (C, SI, SO); 
input C,SI; 
output SO; 
reg [2:0] tmp; 
 
  always @(posedge C) 
    begin 
      tmp = tmp << 1; 
      tmp[0] = SI; 
    end 
    assign SO  = tmp[2]; 
endmodule 


module dff_async_reset (
data  , // Data Input
clk    , // Clock Input
reset , // Reset input 
q         // Q output
);
input data, clk, reset ; 
output q;
reg q;
always @ ( posedge clk or negedge reset)
if (~reset) begin
  q <= 1'b0;
end  else begin
  q <= data;
end

endmodule 
