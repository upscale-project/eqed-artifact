// just a made up dffre module - not the real dffre module used (just for testing)

module dffre (
input wire d,
input wire clk,
input wire en,
input wire r,
output wire q);

assign q = d& ~r;

endmodule
