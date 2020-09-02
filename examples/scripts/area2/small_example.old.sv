

module small_example;

reg [0:4] input_FF;
reg [0:4] output_FF;
wire clk;
wire [0:4] in;
wire [0:4] out;
integer i;

initial begin
   input_FF = '0;
   output_FF = '0;
end

always @ (posedge clk) begin
   input_FF[0] <= in[0] ^ input_FF[4];
   output_FF[0] <= !input_FF[0] ^ output_FF[4];

   input_FF[1] <= in[1] ^ input_FF[0] ^ input_FF[4];
   output_FF[1] <= !input_FF[1] ^ output_FF[0] ^ output_FF[4];

   input_FF[2] <= in[2] ^ input_FF[1];
   output_FF[2] <= !input_FF[2] ^ output_FF[1];

   input_FF[3] <= in[3] ^ input_FF[2];
   output_FF[3] <= !input_FF[3] ^ output_FF[2];

   input_FF[4] <= in[4] ^ input_FF[3];
   output_FF[4] <= !input_FF[4] ^ output_FF[3];

end

assign out = output_FF;

C_test : cover property (@ (posedge clk) 
                         input_FF == 5'b00000 && output_FF == 5'b00000
                         ##10
                         input_FF == 5'b11001 && output_FF == 5'b01001);

C_test2 : cover property (@ (posedge clk) 
                         input_FF == 5'b00000 && output_FF == 5'b00000 && in != 5'b00000
                         ##1
                         in != 5'b00001
                         ##1
                         in != 5'b00010
                         ##1
                         in != 5'b00011
                         ##1
                         in != 5'b00100
                         ##1
                         in != 5'b00101
                         ##1
                         in != 5'b00110
                         ##1
                         in != 5'b00111
                         ##1
                         in != 5'b01000
                         ##1
                         in != 5'b01001
                         ##1
                         input_FF == 5'b11001 && output_FF == 5'b01001);

C_test3 : cover property (@ (posedge clk) 
                         input_FF == 5'b00000 && output_FF == 5'b00000 && in == 5'b00000
                         ##1
                         in == 5'b00001
                         ##1
                         in == 5'b00010
                         ##1
                         in == 5'b00011
                         ##1
                         in == 5'b00100
                         ##1
                         in == 5'b00101
                         ##1
                         in == 5'b00110
                         ##1
                         in == 5'b00111
                         ##1
                         in == 5'b01000
                         ##1
                         in == 5'b01001
                         ##1
                         input_FF == 5'b11001 && output_FF == 5'b01001);

                         


endmodule
