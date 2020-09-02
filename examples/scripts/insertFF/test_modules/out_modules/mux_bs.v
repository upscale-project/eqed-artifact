// -------------------------------------------
// mux_bs - 4-input mux with binary select
//
// Parameters:
// n 		- signal length
// 
// Inputs:
// in0		- input 0
// in1		- input 1
// in2 		- input 2
// in3 		- input 3
// bs 		- binary select signal
//
// Outputs:
// out		- output
// -------------------------------------------

module mux_bs /*#( parameter n = 1 )*/
			  ( input [n-1:0] in0,
			    input [n-1:0] in1,
			    input [n-1:0] in2,
			    input [n-1:0] in3,
			    input [1:0] bs,
			    output reg [n-1:0] out );

	always @(*) begin
		case (bs)
			2'd0: out = in0;
			2'd1: out = in1;
			2'd2: out = in2;
			2'd3: out = in3;
			default: out = {/*n*/1{1'bx}};
		endcase
	end

endmodule
