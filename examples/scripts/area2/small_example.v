

module small_example;

reg [0:7] intFF;
reg [0:2] FFmisr;
wire FFin [0:7]
wire clk;
wire a;
wire b;
wire x;
wire y;
wire z;
wire inj_e[0:7];
wire m_rst;

reg inj_error;

integer i;

initial begin
   intFF = '0;
   FFmisr = 3'b001;
   inj_error = '0; 
end

assign x = intFF[5];
assign y = intFF[6];
assign z = intFF[7];

assign FFin[0] = (inj_e[0]) ? !a: a;
assign FFin[1] = (inj_e[1]) ? !b: b;
assign FFin[2] = (inj_e[2]) ? !intFF[0]: intFF[0];
assign FFin[3] = (inj_e[3]) ? !(intFF[0] && intFF[1]): (intFF[0] && intFF[1]);
assign FFin[4] = (inj_e[4]) ? !intFF[1]; intFF[1];
assign FFin[5] = (inj_e[5]) ? intFF[2]: !intFF[2];
assign FFin[6] = (inj_e[6]) ? !(intFF[2] || intFF[3]): (intFF[3] || intFF[4]);
assign FFin[7] = (inj_e[7]) ? !(intFF[3] || intFF[4]): (intFF[3] || intFF[4]);


always @ (posedge clk) begin
   for ( i=0; i < 8; i=i+1) begin
      intFF[i] <= FFin[i];
   end
   inj_error <= |inj_e;
end

always @ (posedge clk || m_rst) begin
   if (m_rst) begin
      FFmisr <= 3'b001;
   end
   FFmisr[2] <= FFmisr[2]^FFmisr[0]^x;
   FFmisr[1] <= FFmisr[2]^y;
   FFmisr[0] <= FFmisr[1]^z;
end




C_test : cover property (@ (posedge clk)
                         a == 1'b1 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b0 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b1 && b == 1'b1 && m_rst == 1 
                         ##1
                         a == 1'b1 && b == 1'b0 && m_rst == 0 
                         ##1
                         a == 1'b0 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b0 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b1 && b == 1'b1 && m_rst == 0 
                         ##1
                         FFmisr == 3'b011);

C_test2 : cover property (@ (posedge clk)
                         a == 1'b1 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b0 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b1 && b == 1'b1 && m_rst == 1 
                         ##1
                         a == 1'b1 && b == 1'b0 && m_rst == 0 
                         ##1
                         a == 1'b0 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b0 && b == 1'b1 && m_rst == 0 
                         ##1
                         a == 1'b1 && b == 1'b1 && m_rst == 0
                         ##1
                         FFmisr == 3'b100);


A_test : assume property (inj_error == 0);

endmodule
