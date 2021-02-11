


module paper_ex (
  input clk,
  input rst);

reg [0:7] intFF;
reg [0:2] FFmisr;
reg [0:2] FFmisr2;
wire FFin [0:7];
wire clk;
wire a;
wire b;
wire x;
wire y;
wire z;
wire l;
wire m;
wire n;
wire inj_e[0:7];
wire m_rst;
wire all_e;

reg inj_error;

integer i;

initial begin
   intFF[0] = 1'b1;
   intFF[1] = 1'b1;
   intFF[2] = 1'b0;
   intFF[3] = 1'b0;
   intFF[4] = 1'b1;
   intFF[5] = 1'b0;
   intFF[6] = 1'b1;
   intFF[7] = 1'b1;
   FFmisr = 3'b100;
   FFmisr2 = 3'b100;
   inj_error = '0; 
end

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

assign x = intFF[5];
assign y = intFF[6];
assign z = intFF[7];

assign all_e = inj_e[0] || inj_e[1] || inj_e[2] || inj_e[3] || inj_e[4] || inj_e[5] || inj_e[6] || inj_e[7];

assign FFin[0] = (inj_e[0]) ? !a: a;
assign FFin[1] = (inj_e[1]) ? !b: b;
assign FFin[2] = (inj_e[2]) ? !intFF[0]: intFF[0];
assign FFin[3] = (inj_e[3]) ? !(intFF[0] && intFF[1]): (intFF[0] && intFF[1]);
assign FFin[4] = (inj_e[4]) ? !intFF[1]: intFF[1];
assign FFin[5] = (inj_e[5]) ? intFF[2]: !intFF[2];
assign FFin[6] = (inj_e[6]) ? !(intFF[2] || intFF[3]): (intFF[2] || intFF[3]);
assign FFin[7] = (inj_e[7]) ? !(intFF[3] || intFF[4]): (intFF[3] || intFF[4]);


always @ (posedge clk) begin
   for ( i=0; i < 8; i=i+1) begin
      intFF[i] <= FFin[i];
   end
   inj_error <= inj_error || all_e;
end

always @ (posedge clk) begin
   if (m_rst == 1'b1) begin
      FFmisr[2] <= 1'b0;
      FFmisr[1] <= 1'b0;
      FFmisr[0] <= 1'b1; 
   end else begin
      FFmisr[2] <= FFmisr[2]^FFmisr[0]^x;
      FFmisr[1] <= FFmisr[2]^y;
      FFmisr[0] <= FFmisr[1]^z;
   end
end

/* Final Signature 3'b110
assign l = !(x || y);
assign m = x && y && z;
assign n = y^z;
Removes FF8 on Cycle 2 */ 

assign l = x^y;
assign m = x + y + z;
assign n = y && z;

always @ (posedge clk) begin
   if (m_rst == 1'b1) begin
      FFmisr2[2] <= 1'b0;
      FFmisr2[1] <= 1'b0;
      FFmisr2[0] <= 1'b1; 
   end else begin
      FFmisr2[2] <= FFmisr2[2]^FFmisr2[0]^l;
      FFmisr2[1] <= FFmisr2[2]^m;
      FFmisr2[0] <= FFmisr2[1]^n;
   end
end



C_test3 : cover property (@ (posedge clk)
                         intFF[0] == 1'b1 && intFF[1] == 1'b1 && 
                         intFF[2] == 1'b0 && intFF[3] == 1'b0 && intFF[4] == 1'b1 && 
                         intFF[5] == 1'b0 && intFF[6] == 1'b1 && intFF[7] == 1'b1 && 
                         FFmisr == 3'b100 && inj_error == '0 &&
                         a == 1'b1 && b == 1'b0 
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b0 && b == 1'b1  
                         ##1
                         a == 1'b1 && b == 1'b1 
                         ##1
                         a == 1'b0 && b == 1'b0
                         );

C_test_c33 : cover property (@ (posedge clk)
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
                         FFmisr == 3'b001 && FFmisr2 == 3'b100                       
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



A_test : assume property (@ (posedge clk)
                         m_rst == 0);

endmodule
