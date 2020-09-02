`define SLOW1 4
`define FAST1 1

module programmable_blinker #(parameter dist = `SLOW1) // dist_shift is either 1 or 4 (corresponding to fast/slow blinkers)
														 (input wire clk,
															input wire rst,
															input wire count_en,
															input wire shift_left,
															input wire shift_right,
															output wire out
    ,input wire [3:0] shft_ff1_sel,input wire [7:0] tm_timer_state_sel,input wire  blk_blinker_state_sel,input wire [3:0] shft_ff1_sel,input wire [7:0] tm_timer_state_sel,input wire  blk_blinker_state_sel);

	wire [7:0] shifter_out;
	wire timer_done;
	//wire dist = `SLOW1; // for parameter

	shifter #(dist) shft( .clk(clk),
															.rst(rst),
															.shift_left(shift_left),
															.shift_right(shift_right),
															.out(shifter_out)
														,.ff1_sel(shft_ff1_sel),.ff1_sel(shft_ff1_sel));

	timer tm( .load_value(shifter_out),
						.reset(rst),
						.clk(clk),
						.count_en(count_en),
						.out(timer_done)
					,.timer_state_sel(tm_timer_state_sel),.timer_state_sel(tm_timer_state_sel));

	blinker blk(.switch(timer_done),
							.reset(rst),
							.clk(clk),
							.out(out)
						,.blinker_state_sel(blk_blinker_state_sel),.blinker_state_sel(blk_blinker_state_sel));

endmodule
