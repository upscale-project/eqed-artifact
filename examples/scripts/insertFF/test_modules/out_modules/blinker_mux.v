module blinker( input wire switch,
				input wire clk,
				input wire reset,
				output wire out ,input wire  blinker_state_sel,input wire  blinker_state_sel);

	wire inv_out;

	dffre #(1) blinker_state (.clk(clk),
							  .r(reset), 
							  .en(switch),
							  .d(blinker_state_sel ^ inv_out), 
							  .q(out) );
	
	// When switch goes high, update out to be inv_out
	assign inv_out = ~out;

endmodule
