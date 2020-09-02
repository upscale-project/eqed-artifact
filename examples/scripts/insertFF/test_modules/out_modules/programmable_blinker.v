`define SLOW1 4
`define FAST1 1

module programmable_blinker /*#(parameter dist = `SLOW1)*/ // dist_shift is either 1 or 4 (corresponding to fast/slow blinkers)
														 (input wire clk,
															input wire rst,
															input wire count_en,
															input wire shift_left,
															input wire shift_right,
															output wire out
    );

	wire [7:0] shifter_out;
	wire timer_done;
	//wire dist = `SLOW1; // for parameter

	shifter /*#(dist)*/ shft( .clk(clk),
															.rst(rst),
															.shift_left(shift_left),
															.shift_right(shift_right),
															.out(shifter_out)
														);

	timer tm( .load_value(shifter_out),
						.reset(rst),
						.clk(clk),
						.count_en(count_en),
						.out(timer_done)
					);

	blinker blk(.switch(timer_done),
							.reset(rst),
							.clk(clk),
							.out(out)
						);

endmodule
