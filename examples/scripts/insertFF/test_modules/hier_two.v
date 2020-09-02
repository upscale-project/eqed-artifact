

module hier_two(
input wire a,
input wire yo,
input wire tohi,
input wire b,
output wire out
) ;

wire c;

dff ff2 (.d(a), .q(c));

assign out = c & b;

endmodule

module one_two (
input wire in,
output wire out );

wire temp, out_temp;

hier_two this_two (.a(in),
		 .yo(),
		 .tohi(),
		 .b(temp),
		 .out(out_temp));

dff ff5 (.d(out_temp), .q(out));

endmodule
