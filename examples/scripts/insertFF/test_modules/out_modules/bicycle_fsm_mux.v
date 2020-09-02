// Bicycle Light FSM
//
// This module determines how the light functions in the given state and what
// the next state is for the given state.
// 
// It is a structural module: it just instantiates other modules and hooks
// up the wires between them correctly.

/* For this lab, you need to implement the finite state machine following the
 * specifications in the lab hand-out */

// Programmable Blinker Parameter
`define SLOW 3'd4 // shift values for programmable blinkers
`define FAST 3'd1

module bicycle_fsm(
    input clk, 
    input up_button, 
    input down_button, 
    input next, 
    input reset, 
    output wire rear_light
,input wire [21:0] bt32_beat32_state_sel,input wire reg [2:0] mfsm_ff_sel,input wire [3:0] fast_shft_ff1_sel,input wire [7:0] fast_tm_timer_state_sel,input wire  fast_blk_blinker_state_sel,input wire [3:0] slow_shft_ff1_sel,input wire [7:0] slow_tm_timer_state_sel,input wire  slow_blk_blinker_state_sel,input wire [21:0] bt32_beat32_state_sel,input wire reg [2:0] mfsm_ff_sel,input wire [3:0] fast_shft_ff1_sel,input wire [7:0] fast_tm_timer_state_sel,input wire  fast_blk_blinker_state_sel,input wire [3:0] slow_shft_ff1_sel,input wire [7:0] slow_tm_timer_state_sel,input wire  slow_blk_blinker_state_sel);

    // Instantiations of master_fsm, beat32, fast_blinker, slow_blinker here
	wire count_en;	// Signal from beat32	
	wire slow_left, slow_right, fast_left, fast_right; // Shift signals from master_fsm to programmable blinkers	
	wire slow_blinker_out, fast_blinker_out; // Outputs of programmable blinkers
	wire [1:0] master_out; // Mux signal

	// Master fsm - manages overall state of bike light, passes inputs to blinkers.
	master_fsm mfsm( .next(next),
				.up_button(up_button),
				.down_button(down_button),
				.clk(clk),
				.reset(reset),

				.slow_left(slow_left), // Flash 1 Programmable blinker
				.slow_right(slow_right),
				.fast_left(fast_left), // Flash 2 Programmable blinker
				.fast_right(fast_right),
				.out(master_out) ,.ff_sel(mfsm_ff_sel),.ff_sel(mfsm_ff_sel));	 // To multiplexer

	beat32 bt32(.reset(reset), .clk(clk), .out(count_en),.beat32_state_sel(bt32_beat32_state_sel),.beat32_state_sel(bt32_beat32_state_sel));

	programmable_blinker #(4) slow (.clk(clk),
								   	.rst(reset),
									.count_en(count_en),
									.shift_left(slow_left),
									.shift_right(slow_right),
									.out(slow_blinker_out) ,.shft_ff1_sel(slow_shft_ff1_sel),.tm_timer_state_sel(slow_tm_timer_state_sel),.blk_blinker_state_sel(slow_blk_blinker_state_sel),.shft_ff1_sel(slow_shft_ff1_sel),.tm_timer_state_sel(slow_tm_timer_state_sel),.blk_blinker_state_sel(slow_blk_blinker_state_sel));

	programmable_blinker #(1) fast (.clk(clk),
								   	.rst(reset),
									.count_en(count_en),
									.shift_left(fast_left),
									.shift_right(fast_right),
									.out(fast_blinker_out) ,.shft_ff1_sel(fast_shft_ff1_sel),.tm_timer_state_sel(fast_tm_timer_state_sel),.blk_blinker_state_sel(fast_blk_blinker_state_sel),.shft_ff1_sel(fast_shft_ff1_sel),.tm_timer_state_sel(fast_tm_timer_state_sel),.blk_blinker_state_sel(fast_blk_blinker_state_sel));

    // Output mux here
	mux_bs #(1) mux_out( .in0(1'b0), // OFF
					.in1(1'b1), // ON
					.in2(slow_blinker_out), // fast output signal
					.in3(fast_blinker_out), // slow output signal
					.bs(master_out),
					.out(rear_light) );

endmodule
