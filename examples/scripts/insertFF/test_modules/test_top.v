/* Test module for hierarchy perl script: Top Module
   name: test_top.v
   One module per file
   -------------------------------------------------
   Simple test module with 2 level of hierarchy
*/

module test_top (
input wire a,
input wire b,
input wire c,
output wire result   
);

wire add_out;
wire sub_out;

// one sub module here
add first_add (.d(c),.b_add(b),.out_add(add_out));
// another sub module here
sub first_sub (.a_sub(b), .b_sub(c), .out_sub(sub_out));

assign result = add_out + sub_out;

endmodule
