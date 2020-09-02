`define MAXCOUNT 22'd3125000
//`define MAXCOUNT 22'd1 //0.5 clk rate - for simulation

module beat32(input wire reset,
							input wire clk,
    					output wire out
    ,input wire [21:0] beat32_state_sel,input wire [21:0] beat32_state_sel);
	
	wire [21:0] cur_state, next_state, cur_state_add1, count_done;

	dffr #(22) beat32_state(.clk(clk),.r(reset), .d(beat32_state_sel ^ next_state), .q(cur_state)  /*comment testing */
	);

	assign count_done = (cur_state == (`MAXCOUNT - 1)); //check if current state is 1/32th of a sec
	assign cur_state_add1 = cur_state + 1;
	assign out = (cur_state == 22'd0);
	assign next_state = count_done? 22'd0 : cur_state_add1; //check if counting is done

endmodule
