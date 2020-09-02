

module hier_one (input wire ina,input wire inb,output wire out);

wire a;
reg b;
wire c;

hier_two yo (.a(ina),
	 .b(inb),
	 .out(a));
one_two t (.in(b), .out(d));

always @(*) begin
if (b != a) begin
b = a + a;
end
end

wire d;


dff ff1 (
         .d(a),
         .q(c));

assign out = c^ina;

endmodule
