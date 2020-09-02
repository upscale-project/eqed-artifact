module xtest (
	      //inputs
	      a, clk,
	      //outputs
	      reg_out
	      );

   input clk;
   input [3:0] a ;
   output [3:0] reg_out ;

   wire 	out1;
   reg [3:0] 	out_reg; // buffer before the output
   

   assign reg_out = out_reg ;
   assign out1 = &a ;

   reg [6:0] 	trojan ;
   wire 	act_t ;
   
   initial trojan = 6'b0 ;
   
   assign act_t = &trojan ;

   always @ (posedge clk) trojan <= trojan + 1 ;
   
   always @ (posedge clk)
     begin
	if (act_t)
	  out_reg <= 4'b1 ;
	else
	  out_reg <= {out1,1'b0,out1,1'b0} ;
     end


endmodule // xtest

	
   
	 