


module paper_ex (
  clk,
  rst);

  input clk;
  input rst;

  reg [0:5] IN_misr;
  reg [0:5] OUT_misr_1;
  reg [0:5] OUT_misr_2;


  wire a;
  wire b;
  wire x;
  wire y;
  wire z;

  always @(posedge clk) begin
    if(rst) begin
      IN_misr <= 5'b00001;
    end else begin
      IN_misr[0] <= IN_misr[4]^IN_misr[5]^b;
      IN_misr[1] <= IN_misr[0];
      IN_misr[2] <= IN_misr[1]^a;
      IN_misr[3] <= IN_misr[2];
      IN_misr[4] <= IN_misr[3];
      IN_misr[5] <= IN_misr[4];
    end
  end

  design_module dm(
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .x(x),
    .y(y),
    .z(z)
  );

  always @(posedge clk) begin
    if(rst) begin
      OUT_misr_1 <= 5'b00001;
    end else begin
      OUT_misr_1[0] <= OUT_misr_1[4]^OUT_misr_1[5]^z;
      OUT_misr_1[1] <= OUT_misr_1[0];
      OUT_misr_1[2] <= OUT_misr_1[1]^y;
      OUT_misr_1[3] <= OUT_misr_1[2];
      OUT_misr_1[4] <= OUT_misr_1[3]^x;
      OUT_misr_1[5] <= OUT_misr_1[4];
    end
  end

C_check_dm : cover property (@ (posedge clk)
                         $fell(rst) &&
                         IN_misr == 6'b000001 &&
                         OUT_misr_1 == 6'b000001 
                         ##5
                         IN_misr == 6'b111010 &&
                         OUT_misr_1 == 6'b110010
                         );
/*
C_full_seq : cover property (@ (posedge clk)
                         $fell(rst) &&
                         IN_misr == 6'b000001 &&
                         OUT_misr_1 == 6'b000001 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 
                         ##1
                         a == 1'b0 && b == 1'b0  
                         ##1
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b1 && b == 1'b0
                         ##1
                         a == 1'b0 && b == 1'b1
                         //IN_misr == 6'b111010 &&
                         //OUT_misr_1 == 6'b110010 &&
                         );
*/
A_no_reset : assume property (@ (posedge clk)
                         rst == 0);

endmodule

//Paper design module example
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

  inv11 inv_a(
    .a(a),
    .o(c)
  );

  xor21 xor_ab(
    .a(a),
    .b(b),
    .o(d)
  );

  dff f1(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(c),
    .q(e)
  );

  dff f2(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(d),
    .q(f)
  );

  and21 and_ef(
    .a(e),
    .b(f),
    .o(g)
  );

  dff f3(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(e),
    .q(h)
  );

  dff f4(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(g),
    .q(i)
  );

  dff f5(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(f),
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

  dff f6(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(k),
    .q(x)
  );

  dff f7(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(l),
    .q(y)
  );

  dff f8(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(m),
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




