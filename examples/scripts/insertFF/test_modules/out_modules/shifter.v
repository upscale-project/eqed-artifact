// -----------------------------------------------------
// shifter - shift timer speed up or down
// 
// Parameters:
// dist 		- distance to left shift current state
// 				  to get smallest timer load value, e.g.
// 				  for flash1 dist = 5, flash dist = 2 
// 				  
// Inputs:
// clk			- system clock
// rst 			- reset
// shift_left	- left shift signal decreases speed
// shift_right	- right shift signal increases speed
//
// Outputs:
// out			- output value to load on timer
// -----------------------------------------------------

`define SPEED1 4'b0001 // fastest speed
`define SPEED2 4'b0010
`define SPEED3 4'b0100
`define SPEED4 4'b1000 // slowest speed

module shifter #( parameter dist = 1 ) // dist is either 1 or 4 (corresponding to fast/slow blinkers)
			   ( input wire clk,
			  	 input wire rst,
			  	 input wire shift_left,
			  	 input wire shift_right,
			  	 output wire [7:0] out);

	wire [3:0] speed, temp_speed, next_speed;
	wire [3:0] init_speed;

	speed_shift ss1 ( .shl(shift_left),
					  .shr(shift_right),
					  .speed(speed),
					  .next_speed(next_speed) );
	
	assign init_speed = (dist == 4) ? `SPEED1 : `SPEED4;
	assign speed = rst ? init_speed : temp_speed;

	//dff #( 4 ) ff1 ( .clk(clk), 
				   	 .d(next_speed),
				  	 .q(temp_speed) );

	assign out = ({{4'b0000}, speed} << dist) - 8'd1; // Append 4 zeros to the front of speed to make it an 8-bit number
	//assign out = ({{4'b0000}, speed} << (dist-1)); // for lab_top_tb simulation

endmodule
