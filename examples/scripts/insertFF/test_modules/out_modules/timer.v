module timer( input wire [7:0] load_value,
			  input wire reset,
			  input wire clk,
			  input wire count_en,
			  output wire out );

	wire [7:0] next_state, cur_state;
	wire cur_state_zero;

	dffre /*#(8)*/ timer_state( .r(reset),
							.clk(clk),
							.en(count_en),
							.d(next_state),
							.q(cur_state) );

	assign cur_state_zero = (cur_state == 8'd0);
	
	assign next_state = cur_state_zero ? load_value : cur_state - 8'd1; // reload value if current state hits zero

	assign out = (count_en & cur_state_zero); // output 1 for only one clock cycle, not 1/32 of a second.
	

endmodule
