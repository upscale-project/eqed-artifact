module decoder_assign_1024 (
binary_in   , //  10 bit binary input
decoder_out , //  1024-bit output
enable      , //  Enable for the decoder
reset             //  Reset for the decoder memory
);
input [10:0] binary_in  ;
input  enable ;
output [1024:0] decoder_out ;

wire [10:0] decoder_out ;
reg  control;

always @ (enable or binary_in or reset)
begin
        assign control = (!reset) && (enable) && (|binary_in)
        assign decoder_out = (control) ? (1 << binary_in) : 1024'b0 ;
end
endmodule

