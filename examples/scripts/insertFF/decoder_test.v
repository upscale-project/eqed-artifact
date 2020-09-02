

// write up the state:

wire [1:0] cur_state;
reg [1:0] next_state;
input wire [n-1:0] decoder_input;
reg decoder_en;
wire [n-1:0] input_delay;
wire [m-1:0] decoder_out;
//reg [m-1:0] pre_output;

wire input_case;
/*
assign input_case = |decoder_input;

dff #(1) state_ff (.d(next_state), .q(cur_state), .clk(clk));

always @(*) begin
    casex({input_case, cur_state})
	3'b0xx: next_state = 2'b00;
	3'b100: next_state = 2'b01;
	3'b101: next_state = 2'b10;
	3'b110: next_state = 2'b10;
	//3'b00: next_state = 2'b00;
	//3'b01: next_state = ;
	//3'b10: next_state = ;
	//3'b11: next_state = cur_state;
	default: next_state = cur_state;
    endcase

    case(cur_state)
	2'b00: {decoder_en, pre_output} = {0, output_temp}; 
	2'b01: {decoder_en, pre_output} = {1, output_temp};
	2'b10: {decoder_en, pre_output} = {1, decoder_out};
	2'b11: {decoder_en, pre_output} = {0, decoder_out};
	default: {decoder_en, pre_output} = {0, decoder_out};
    endcase
end

dff input_ff (.d(decoder_input), .q(input_delay), .clk(clk));
assign output_temp = decoder_en? ( 1 << input_delay) : 0;

dff out_ff (.d(pre_output), .q(decoder_out), .clk(clk));

*/

assign input_case = |decoder_input;

dff #(1) state_ff (.d(next_state), .q(cur_state), .clk(clk));
dff #(n) input_ff (.d(decoder_input), .q(input_delay), .clk(clk));
assign decoder_out = decoder_en? (1 << input_delay) : 0;

always @(*) begin
    casex({input_case, cur_state})
	3'b000: next_state = 2'b00;
	3'b001: next_state = 2'b10;
	3'b010: next_state = 2'b10;
	3'b100: next_state = 2'b01;
	3'b101: next_state = 2'b10;
	3'b110: next_state = 2'b10;
	default: next_state = cur_state;
    endcase

    case(cur_state)
	2'b00: decoder_en = 0;
	2'b01: decoder_en = 1;
	2'b10: decoder_en = 0;
	2'b11: decoder_en = 0;
	default: decoder_en = 0;
    endcase
end





