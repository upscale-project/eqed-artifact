// ----------------------------------------------------------------
// speed_shift - combinational logic to generate next timer speed
// 
// Inputs:
// shl			- left shift signal decreases speed
// shr			- right shift signal increases speed
// speed 		- current speed
//
// Outputs:
// next_speed	- next speed
// ----------------------------------------------------------------

`define SPEED1 4'b0001 // fastest speed
`define SPEED2 4'b0010
`define SPEED3 4'b0100
`define SPEED4 4'b1000 // slowest speed

module speed_shift ( input wire shl, 
					 input wire shr,
					 input wire [3:0] speed,
					 output wire [3:0] next_speed );

	wire [3:0] s1, s2, s3, s4;
	// Current speed = 0001
	mux_bs /*#( 4 )*/ mux_speed1 ( .in0(`SPEED1), // no shift
							   .in1(`SPEED1), // right shift (higher speed)
							   .in2(`SPEED2), // left shift (lower speed)
							   .in3(`SPEED1), // both shift (no change)
							   .bs({shl, shr}),
							   .out(s1) );
	// Current speed = 0010
	mux_bs /*#( 4 )*/ mux_speed2 ( .in0(`SPEED2),
							   .in1(`SPEED1),
							   .in2(`SPEED3),
							   .in3(`SPEED2),
							   .bs({shl, shr}),
							   .out(s2) );
	// Current speed = 0100
	mux_bs /*#( 4 )*/ mux_speed3 ( .in0(`SPEED3),
							   .in1(`SPEED2),
							   .in2(`SPEED4),
							   .in3(`SPEED3),
							   .bs({shl, shr}),
							   .out(s3) );
	// Current speed = 1000
	mux_bs /*#( 4 )*/ mux_speed4 ( .in0(`SPEED4),
							   .in1(`SPEED3),
							   .in2(`SPEED4),
							   .in3(`SPEED4),
							   .bs({shl, shr}),
							   .out(s4) );

	mux_ohs /*#( 4 )*/ mux_final ( .in0(s1), // Current speed = 0001
							   .in1(s2), // Current speed = 0010
							   .in2(s3), // Current speed = 0100
							   .in3(s4), // Current speed = 1000
							   .ohs(speed),
							   .out(next_speed) );

endmodule
