


module paper_ex (
  clk,
  rst);

  input clk;
  input rst;

  wire a;
  wire b;
  wire x;
  wire y;
  wire z;
  wire u;
  wire v;
  wire w;

  design_module dm(
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .x(x),
    .y(y),
    .z(z)
  );

  neighboring_module nm(
    .clk(clk),
    .rst(rst),
    .x(x),
    .y(y),
    .z(z),
    .u(u),
    .v(v),
    .w(w)
  );


endmodule

//Paper design module
module design_module (
  clk,
  rst,
  a,
  b,
  x,
  y,
  z);

  input clk;
  input rst;
  input a;
  input b;
  output x;
  output y;
  output z;

  wire c,d,e,f,g,h,i,j,k,l,m;

//EQED select wires
  wire eqed_sel[0:7];

//EQED mux addition wires
  wire eqed_c;
  wire eqed_d;
  wire eqed_e;
  wire eqed_g;
  wire eqed_f;
  wire eqed_k;
  wire eqed_l;
  wire eqed_m; 

  inv11 inv_a(
    .a(a),
    .o(c)
  );

  xor21 xor_ab(
    .a(a),
    .b(b),
    .o(d)
  );

//EQED mux 
  eqed_mux mux_1(
    .in(c),
    .sel(eqed_sel[0]),
    .out(eqed_c)
  );

  dff f1(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(eqed_c),
    .q(e)
  );

  eqed_mux mux_2(
    .in(d),
    .sel(eqed_sel[1]),
    .out(eqed_d)
  );

  dff f2(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(eqed_d),
    .q(f)
  );

  and21 and_ef(
    .a(e),
    .b(f),
    .o(g)
  );

  eqed_mux mux_3(
    .in(e),
    .sel(eqed_sel[2]),
    .out(eqed_e)
  );

  dff f3(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(eqed_e),
    .q(h)
  );

  eqed_mux mux_4(
    .in(g),
    .sel(eqed_sel[3]),
    .out(eqed_g)
  );

  dff f4(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(eqed_g),
    .q(i)
  );

  eqed_mux mux_5(
    .in(f),
    .sel(eqed_sel[4]),
    .out(eqed_f)
  );

  dff f5(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(eqed_f),
    .q(j)
  );

  inv11 inv_h(
    .a(h),
    .o(k)
  );

  or21 or_hi(
    .a(h),
    .b(i),
    .o(l)
  );

  or21 or_ij(
    .a(i),
    .b(j),
    .o(m)
  );

  eqed_mux mux_6(
    .in(k),
    .sel(eqed_sel[5]),
    .out(eqed_k)
  );

  dff f6(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(eqed_k),
    .q(x)
  );

  eqed_mux mux_7(
    .in(l),
    .sel(eqed_sel[6]),
    .out(eqed_l)
  );

  dff f7(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(eqed_l),
    .q(y)
  );

  eqed_mux mux_8(
    .in(m),
    .sel(eqed_sel[7]),
    .out(eqed_m)
  );

  dff f8(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(eqed_m),
    .q(z)
  );



endmodule

// Neighboring module from the paper example
module neighboring_module (
  clk,
  rst,
  x,
  y,
  z,
  u,
  v,
  w);

  input clk;
  input rst;
  input x;
  input y;
  input z;

  output u;
  output v;
  output w;

  wire n,o,p;

  xor21 xor_xy(
    .a(x),
    .b(y),
    .o(n)
  );

  or21 or_xz(
    .a(x),
    .b(z),
    .o(o)
  );

  and21 and_yz(
    .a(y),
    .b(z),
    .o(p)
  );

  dff f9(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(n),
    .q(u)
  );

  dff f10(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(o),
    .q(v)
  );

  dff f2(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(p),
    .q(w)
  );


endmodule


//Two input XOR gate
module xor21 (
  a,
  b,
  o);

  input a;
  input b;
  output o;

  assign o = a^b;

endmodule

//Two input OR gate
module or21 (
  a,
  b,
  o);

  input a;
  input b;
  output o;

  assign o = a|b;

endmodule


//Two input AND gate
module and21 (
  a, 
  b,
  o);

  input a;
  input b;
  output o;

  assign o = a&b;

endmodule


//Single input inverter
module inv11 (
  a,
  o);

  input a;
  output o;

  assign o = !a;

endmodule


//Synchronous reset D-FF with selective reset value
module dff (
  clk,
  rst,
  rst_val,
  d,
  q);

  input clk;
  input rst;
  input rst_val;
  input d;
  output reg q;


  always @(posedge clk) begin
    if (rst) begin
      q <= rst_val;
    end else begin
      q <= d;
    end
  end

endmodule


//Single input inverting MUX
//  Inverts for sel=1
module eqed_mux (
  in,
  sel,
  out);

  input in;
  input sel;
  output out;

  assign out = (sel) ? !in : in;

endmodule
