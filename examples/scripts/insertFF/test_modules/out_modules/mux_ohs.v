// -------------------------------------------
// mux_ohs - 4-input mux with one-hot select
//
// Parameters:
// n 		- signal length
// 
// Inputs:
// in0		- input 0
// in1		- input 1
// in2 		- input 2
// in3 		- input 3
// ohs 		- one-hot select signal
//
// Outputs:
// out		- output
// -------------------------------------------

module mux_ohs /*#( parameter n = 1 )*/
			    ( input [n-1:0] in0,
			      input [n-1:0] in1,
			      input [n-1:0] in2,
			      input [n-1:0] in3,
			      input [3:0] ohs,
			      output reg [n-1:0] out );

	always @(*) begin
		case (ohs)
			4'b0001: out = in0;
			4'b0010: out = in1;
			4'b0100: out = in2;
			4'b1000: out = in3;
			default: out = in0; //{n{1'bx}};
		endcase
	end

endmodule
