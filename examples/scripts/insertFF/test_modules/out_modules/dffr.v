// another fake dffr module - does not work, just for testing 

module dffr (input d,
	     input r,
	     input clk,
	     output q);

assign q = d & ~r;

endmodule
