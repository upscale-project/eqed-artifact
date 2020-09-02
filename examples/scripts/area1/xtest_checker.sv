module xtest_checker (
              //inputs
              a_ch, clk
              //outputs
              
              );

   input clk;
   input [3:0] a_ch ;

   reg_no_x: assert property (
			      @(posedge clk)
			      !($isunknown(xtest.reg_out))
			      );

   reg_no_allx: assert property (
			      @(posedge clk)
			      xtest.reg_out == 4'bx
			      );

   act_no_x: assert property (
			      @(posedge clk)
			      !($isunknown(xtest.act_t))
			      );

      endmodule // xtest_checker

      