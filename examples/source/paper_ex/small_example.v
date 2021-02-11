


module paper_ex (
  clk,
  rst);

  input clk;
  input rst;

  reg [0:5] IN_misr;
  reg [0:5] OUT_misr_1;
  reg [0:5] OUT_misr_2;


  wire FFin [0:7];

  wire a;
  wire b;
  wire x;
  wire y;
  wire z;
  wire u;
  wire v;
  wire w;

  wire [3:0] binary_in;
  wire enable;
  reg [7:0] decoder_out;

  assign enable = !inj_error;

  always @ (enable or binary_in)
  begin
    decoder_out = 0;
    if (enable) begin
      case (binary_in)
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

  generate
    for (genvar j=0; j<8; j=j+1) begin
      assign inj_e[j] = decoder_out[j];
    end
  endgenerate


  always @(posedge clk) begin
    if(rst) begin
      IN_misr <= 5'b00001;
    else begin
      IN_misr[0] <= IN_misr[4]^IN_misr[5]^a;
      IN_misr[1] <= IN_misr[0];
      IN_misr[2] <= IN_misr[1]^b;
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
    else begin
      OUT_misr_1[0] <= OUT_misr_1[4]^OUT_misr_1[5]^x;
      OUT_misr_1[1] <= OUT_misr_1[0];
      OUT_misr_1[2] <= OUT_misr_1[1]^y;
      OUT_misr_1[3] <= OUT_misr_1[2];
      OUT_misr_1[4] <= OUT_misr_1[3]^z;
      OUT_misr_1[5] <= OUT_misr_1[4];
    end
  end


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



  always @(posedge clk) begin
    if(rst) begin
      OUT_misr_2 <= 5'b00001;
    else begin
      OUT_misr_2[0] <= OUT_misr_2[4]^OUT_misr_2[5]^u;
      OUT_misr_2[1] <= OUT_misr_2[0];
      OUT_misr_2[2] <= OUT_misr_2[1]^v;
      OUT_misr_2[3] <= OUT_misr_2[2];
      OUT_misr_2[4] <= OUT_misr_2[3]^w;
      OUT_misr_2[5] <= OUT_misr_2[4];
    end
  end



assign all_e = inj_e[0] || inj_e[1] || inj_e[2] || inj_e[3] || inj_e[4] || inj_e[5] || inj_e[6] || inj_e[7];


always @ (posedge clk) begin
   for ( i=0; i < 8; i=i+1) begin
      intFF[i] <= FFin[i];
   end
   inj_error <= inj_error || all_e;
end


C_orig_seq : cover property (@ (posedge clk)
                         IN_misr == 6'b000001 &&
                         OUT_misr_1 == 6'b000001 &&
                         OUT_misr_2 == 6'b000001
                         ##5
                         IN_misr == 6'b111010 &&
                         OUT_misr_1 == 6'b110010 &&
                         OUT_misr_2 == 6'b100010
                         );

C_full_seq : cover property (@ (posedge clk)
                         IN_misr == 6'b000001 &&
                         OUT_misr_1 == 6'b000001 &&
                         OUT_misr_2 == 6'b000001 &&
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
                         //OUT_misr_2 == 6'b100010                     
                         );

C_test_c33_1misr : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && inj_e[7] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[5] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001                       
                         );


C_test_c82 : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001 && FFmisr2 == 3'b100                       
                         );

C_test_c82_1misr : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001                       
                         );


C_test_c12 : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[7] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001 && FFmisr2 == 3'b100                       
                         );

C_test_c12_1misr : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[7] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001                       
                         );


C_test_c63 : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && inj_e[7] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001 && FFmisr2 == 3'b100                      
                         );

C_test_c63_1misr : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && inj_e[7] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001                      
                         );

C_test_c32 : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 &&
                         inj_e[0] != 1'b1 && inj_e[7] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] != 1'b1 
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001 && FFmisr2 == 3'b100                      
                         );


C_test_none : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && inj_e[7] != 1'b1 && FFmisr2 == 3'b100 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001 && FFmisr2 == 3'b100                       
                         );

C_test : cover property (@ (posedge clk)
                         a == 1'b1 && b == 1'b1 && FFmisr == 3'b100 && FFmisr2 == 3'b100
                         ##1
                         a == 1'b0 && b == 1'b1 
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##1
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && inj_e[7] != 1'b1 && 
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] != 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         inj_error == '0// && FFmisr2 == 3'b100   FFmisr == 3'b110  &&                     
                         );

C_test_fault : cover property (@ (posedge clk)
                         a == 1'b1 && b == 1'b1 && FFmisr == 3'b100 && FFmisr2 == 3'b100
                         ##1
                         a == 1'b0 && b == 1'b1 
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##1
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         inj_error == '0 && inj_e[2] != 1'b1 &&
                         inj_e[0] != 1'b1 && inj_e[7] != 1'b1 && 
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1 && inj_e[2] != 1'b1 && inj_e[5] == 1'b1
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##2
                         FFmisr == 3'b001                     
                         );

*/

A_test : assume property (@ (posedge clk)
                         rst == 0);

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

  input clk,
  input rst,
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
    .d(c)
    .q(e)
  );

  dff f2(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b1),
    .d(d)
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
    .d(f),
    .q(i)
  );

  dff f5(
    .clk(clk),
    .rst(rst),
    .rst_val(1'b0),
    .d(g),
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




