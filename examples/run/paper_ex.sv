
// E-QED setup and RTL for the example from the CAV'17 paper
//
//


// Top level wrapper module
module paper_ex (
  clk,
  rst);

  input clk;
  input rst;

  reg [0:5] IN_misr;
  reg [0:5] OUT_misr_1;
  reg [0:7] decoder_out;
  wire [0:3] binary_sel; 
  wire enable;
  reg error_injected;
  reg [0:9] cycle_count;

  wire a;
  wire b;
  wire x;
  wire y;
  wire z;

// Single-cycle FF error injection is enabled if no error has been injected
  assign enable = !error_injected;

// One-hot decoder to select FF to inject bit-flip
  always @ (enable or binary_sel) begin
    decoder_out = 0;
    if (enable) begin
      case (binary_sel)
        4'h0 : decoder_out = 8'h01;
        4'h1 : decoder_out = 8'h02;
        4'h2 : decoder_out = 8'h04;
        4'h3 : decoder_out = 8'h08;
        4'h4 : decoder_out = 8'h10;
        4'h5 : decoder_out = 8'h20;
        4'h6 : decoder_out = 8'h40;
        4'h7 : decoder_out = 8'h80;
        4'h8 : decoder_out = 8'h00;
      endcase
    end
  end


// Track if an error has been inject and the current cycle count
  always @ (posedge clk) begin
    if (rst) begin
      error_injected <= 1'b0;
      cycle_count <= 'b1;
    end else begin
      error_injected <= (|decoder_out) || (error_injected);
      cycle_count <= cycle_count + 1'b1;
    end
  end

// Input MISR to dm
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

// Design module from paper example
  design_module dm(
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .x(x),
    .y(y),
    .z(z)
  );

// Output MISR for dm, Input to nm
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


// Connect decoder to FF mux sel inputs
  for (genvar i = 0; i < 8; i++) begin
    assign dm.eqed_sel[i] = decoder_out[i];
  end

// E-QED check property for dm
// Final Input  MISR value: 6'b111010
// Final Output MISR value: 6'b110010
// Capture Window: 5 cycles
C_check_dm_with_ff : cover property (@ (posedge clk)
                         $fell(rst) &&
                         IN_misr == 6'b000001 &&
                         OUT_misr_1 == 6'b000001
                         ##5
                         IN_misr == 6'b111010 &&
                         OUT_misr_1 == 6'b110010
                         );

//FF Candidates 
//Ignore candidate 1 - Trace 1
A_candidate_1 : assume property (@ (posedge clk)
                         (cycle_count == 4) |-> (dm.mux_6.sel == 0));

//Ignore candidate 2 - Trace 2
A_candidate_2 : assume property (@ (posedge clk)
                         (cycle_count == 2) |-> (dm.mux_7.sel == 0));

//Ignore candidate 3 - Trace 1
A_candidate_3 : assume property (@ (posedge clk)
                         (cycle_count == 3) |-> (dm.mux_3.sel == 0));

//Ignore candidate 4 - Trace 2
A_candidate_4 : assume property (@ (posedge clk)
                         (cycle_count == 1) |-> (dm.mux_4.sel == 0));

//Ignore candidate 5 - Trace 2
A_candidate_5 : assume property (@ (posedge clk)
                         (cycle_count == 1) |-> (dm.mux_3.sel == 0));



endmodule




//
//Submodule RTL
//

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
