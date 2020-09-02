

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
   for ( i=0; i < 5; i=i+1) begin
      input_FF[i] <= in[i];
      output_FF[i] <= !input_FF[i];
   end
end

assign out = output_FF;

C_test : cover property (input_FF == 5'b00000 && output_FF == 5'b00000 
                         ##10
                         input_FF == 5'b10101 && output_FF == 5'b11100);

endmodule
