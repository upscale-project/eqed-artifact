module sub (
   a_sub,
   b_sub,
   out_sub);

   input a_sub;
   input b_sub;
   wire c_sub;
   wire d_sub;
   output out_sub;

   sub_and asub (.d(c_sub), .b(b_sub), .out(d_sub));

   assign c_sub = a_sub-b_sub;

   assign out_sub = d_sub-c_sub;

endmodule
