/* Small test top module */

module hier_top (

input wire a,
input wire b,
output wire c);

wire out_one;
wire out_two;
wire out_three;

hier_one one (.ina(a), .inb(b), .out(out_one));

hier_one two (.ina(b), .inb(a), .out(out_two));

hier_three three (.a({a,a,a}), .b({b,b,b}), .out(out_three));

assign c = out_one + out_two;

endmodule

module hier_three (

input wire [2:0] a,
input wire [2:0] b,
output reg out);

wire [2:0] c;
wire [2:0] d;
wire [2:0] out_temp;

dff3 ff3 (.d(a), .q(c));

dff3 ff4 (.d(b), .q(d));

assign out_temp = c|a^b;
assign out = out_temp[0];

endmodule
