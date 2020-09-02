`timescale 1ns / 1ps

/*
 * master_fsm
 * Inputs:
 * next, up_button, down_button - buttons from bicycle_fsm
 * clk - Clock signal
 * reset - Reset signal for states
 *
 * Outputs:
 * slow_left, slow_right - shift signals for the slow programmable blinker
 * fast_left, fast_right - shift signals for the fast programmable blinker
 * out - binary select signal for the output multiplexer
 */


/* States (6):
 * 1. OFF1 	(reset to here)
 * 2. ON 		
 * 3. OFF2 		
 * 4. Flash 1 	
 * 5. OFF3 		
 * 6. Flash 2 	
 */

`define OFF1 	3'b000
`define ON		3'b001
`define OFF2	3'b010
`define FLASH1	3'b011
`define OFF3	3'b100
`define	FLASH2	3'b101


/* Outputs (5):
 * out signal to the multiplexer (binary)
 *		- OFF1/OFF2/OFF3
 *		- ON			
 *		- Flash1 	 
 *		- Flash2		
 */

`define OUT_OFF	2'b00
`define OUT_ON  2'b01
`define OUT_FLASHSLOW 2'b10
`define OUT_FLASHFAST 2'b11


module master_fsm( input wire next,
				   input wire up_button,
				   input wire down_button,
				   input wire clk,
				   input wire reset,

				   output reg slow_left, // Slow Programmable blinker
				   output reg slow_right,
				   output reg fast_left, // Fast Programmable blinker
				   output reg fast_right,
				   output reg [1:0] out	 // To multiplexer
				   );


	wire [2:0] state;
	reg [2:0] next_state;


	dffr /*#(3)*/ ff(.clk(clk), .d(next_state), .q(state), .r(reset));


	always @(*) begin
		// Set outputs according to current state and inputs

 		// Up corresponds to shift right (higher speed), down corresponds to shift left (lower speed)
		if (state == `ON) begin
			out = `OUT_ON;
			slow_right = 1'b0;
			slow_left = 1'b0;
			fast_right = 1'b0;
			fast_left = 1'b0;
		end
		// Slow blinker
		else if (state == `FLASH1) begin
			out = `OUT_FLASHSLOW;
			if (up_button && ~down_button) slow_right = 1'b1;
			else slow_right = 1'b0;
			if (down_button && ~up_button) slow_left = 1'b1; 
			else  slow_left = 1'b0;
			fast_right = 1'b0;
			fast_left = 1'b0;
		end
		// Fast blinker
		else if (state == `FLASH2) begin
			out = `OUT_FLASHFAST;
			if (up_button && ~down_button) fast_right = 1'b1;
			else fast_right = 1'b0;
			if (down_button && ~up_button) fast_left = 1'b1;
			else fast_left = 1'b0;
			slow_right = 1'b0;
			slow_left = 1'b0;
		end
		// OFF
		else begin
			out = `OUT_OFF;
			slow_right = 1'b0;
			slow_left = 1'b0;
			fast_right = 1'b0;
			fast_left = 1'b0;
		end

		// Generate next_state separately
		case(state) 
			`OFF1:	next_state = next ? `ON : `OFF1; 
			`ON:	next_state = next ? `OFF2 : `ON;
			`OFF2:	next_state = next ? `FLASH1 : `OFF2;
			`FLASH1:next_state = next ? `OFF3   : `FLASH1;
			`OFF3:	next_state = next ? `FLASH2 : `OFF3;
			`FLASH2:next_state = next ? `OFF1 : `FLASH2;
			default: next_state = `OFF1;
		endcase
	end

endmodule
