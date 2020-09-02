/* Small test top module */

module hier_top (

input wire a,
input wire b,
output wire c,input wire one_yo_ff2_sel,input wire one_ff1_sel,input wire two_ff1_sel,input wire two_yo_ff2_sel,input wire [2:0] three_ff3_sel,input wire [2:0] three_ff4_sel,input wire one_t_ff5_sel,input wire two_t_ff5_sel,input wire one_t_this_two_ff2_sel,input wire two_t_this_two_ff2_sel,input wire one_yo_ff2_sel,input wire one_ff1_sel,input wire two_ff1_sel,input wire two_yo_ff2_sel,input wire [2:0] three_ff3_sel,input wire [2:0] three_ff4_sel,input wire one_t_ff5_sel,input wire two_t_ff5_sel,input wire one_t_this_two_ff2_sel,input wire two_t_this_two_ff2_sel,input wire one_yo_ff2_sel,input wire one_ff1_sel,input wire two_ff1_sel,input wire two_yo_ff2_sel,input wire [2:0] three_ff3_sel,input wire [2:0] three_ff4_sel,input wire one_t_ff5_sel,input wire two_t_ff5_sel,input wire one_t_this_two_ff2_sel,input wire two_t_this_two_ff2_sel);

wire out_one;
wire out_two;
wire out_three;

hier_one one (.ina(a), .inb(b), .out(out_one),.yo_ff2_sel(one_yo_ff2_sel),.ff1_sel(one_ff1_sel),.t_ff5_sel(one_t_ff5_sel),.t_this_two_ff2_sel(one_t_this_two_ff2_sel),.yo_ff2_sel(one_yo_ff2_sel),.ff1_sel(one_ff1_sel),.t_ff5_sel(one_t_ff5_sel),.t_this_two_ff2_sel(one_t_this_two_ff2_sel),.yo_ff2_sel(one_yo_ff2_sel),.ff1_sel(one_ff1_sel),.t_ff5_sel(one_t_ff5_sel),.t_this_two_ff2_sel(one_t_this_two_ff2_sel));

hier_one two (.ina(b), .inb(a), .out(out_two),.ff1_sel(two_ff1_sel),.yo_ff2_sel(two_yo_ff2_sel),.t_ff5_sel(two_t_ff5_sel),.t_this_two_ff2_sel(two_t_this_two_ff2_sel),.ff1_sel(two_ff1_sel),.yo_ff2_sel(two_yo_ff2_sel),.t_ff5_sel(two_t_ff5_sel),.t_this_two_ff2_sel(two_t_this_two_ff2_sel),.ff1_sel(two_ff1_sel),.yo_ff2_sel(two_yo_ff2_sel),.t_ff5_sel(two_t_ff5_sel),.t_this_two_ff2_sel(two_t_this_two_ff2_sel));

hier_three three (.a({a,a,a}), .b({b,b,b}), .out(out_three),.ff3_sel(three_ff3_sel),.ff4_sel(three_ff4_sel),.ff3_sel(three_ff3_sel),.ff4_sel(three_ff4_sel),.ff3_sel(three_ff3_sel),.ff4_sel(three_ff4_sel));

assign c = out_one + out_two;

endmodule

module hier_three (

input wire [2:0] a,
input wire [2:0] b,
output reg out,input wire [2:0] ff3_sel,input wire [2:0] ff4_sel,input wire [2:0] ff3_sel,input wire [2:0] ff4_sel,input wire [2:0] ff3_sel,input wire [2:0] ff4_sel);

wire [2:0] c;
wire [2:0] d;
wire [2:0] out_temp;

dff3 ff3 (.d(ff3_sel ^ a), .q(c));

dff3 ff4 (.d(ff4_sel ^ b), .q(d));

assign out_temp = c|a^b;
assign out = out_temp[0];

endmodule
