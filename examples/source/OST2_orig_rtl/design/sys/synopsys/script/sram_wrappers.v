//////////////////////////////////////////
////// n2_irf_mp_128x72_cust
//////////////////////////////////////////

`ifndef FPGA

module exu_irf_array (
  clk, 
  tcu_array_wr_inhibit, 
  a_rd_en_p0, 
  a_rd_en_p1, 
  a_rd_en_p2, 
  a_rd_tid, 
  a_rd_addr_p0, 
  a_rd_addr_p1, 
  a_rd_addr_p2, 
  a_wr_en_p0, 
  a_wr_tid_p0, 
  a_wr_addr_p0, 
  a_wr_data_p0, 
  a_wr_en_p1, 
  a_wr_tid_p1, 
  a_wr_addr_p1, 
  a_wr_data_p1, 
  a_save_tid, 
  a_save_global_tid, 
  a_save_global_addr, 
  a_save_even_addr, 
  a_save_local_addr, 
  a_save_odd_addr, 
  a_save_global_en, 
  a_save_even_en, 
  a_save_local_en, 
  a_save_odd_en, 
  a_restore_tid, 
  a_restore_global_tid, 
  a_restore_global_addr, 
  a_restore_even_addr, 
  a_restore_odd_addr, 
  a_restore_local_addr, 
  a_restore_global_en, 
  a_restore_even_en, 
  a_restore_local_en, 
  a_restore_odd_en, 
  a_rd_data_p0, 
  a_rd_data_p1, 
  a_rd_data_p2);
wire [6:0] thr_rs1;
wire [6:0] thr_rs2;
wire [6:0] thr_rs3;
wire [6:0] thr_rd_w;
wire [6:0] thr_rd_w2;
wire rd_en_p0;
wire rd_en_p1;
wire rd_en_p2;
wire wr_en_p0;
wire wr_en_p1;
wire p0_rd_eq_wr;
wire p1_rd_eq_wr;
wire p2_rd_eq_wr;


input		clk;

input		tcu_array_wr_inhibit;

input		a_rd_en_p0;
input		a_rd_en_p1;
input		a_rd_en_p2;
input  [1:0]	a_rd_tid;
input  [4:0]	a_rd_addr_p0;
input  [4:0]	a_rd_addr_p1;
input  [4:0]	a_rd_addr_p2;

input		a_wr_en_p0;
input  [1:0]	a_wr_tid_p0;
input  [4:0]	a_wr_addr_p0;
input  [71:0]	a_wr_data_p0;

input		a_wr_en_p1;
input  [1:0]	a_wr_tid_p1;
input  [4:0]	a_wr_addr_p1;
input  [71:0]	a_wr_data_p1;


input  [1:0]	a_save_tid;
input  [1:0]	a_save_global_tid;
input  [1:0]	a_save_global_addr;
input  [2:1]	a_save_even_addr;
input  [2:0]	a_save_local_addr;
input  [2:1]	a_save_odd_addr;
input		a_save_global_en;
input		a_save_even_en;
input		a_save_local_en;
input		a_save_odd_en;

input  [1:0]	a_restore_tid;
input  [1:0]	a_restore_global_tid;
input  [1:0]	a_restore_global_addr;
input  [2:1]	a_restore_even_addr;
input  [2:1]	a_restore_odd_addr;
input  [2:0]	a_restore_local_addr;
input		a_restore_global_en;
input		a_restore_even_en;
input		a_restore_local_en;
input		a_restore_odd_en;


output [71:0]	a_rd_data_p0;
output [71:0]	a_rd_data_p1;
output [71:0]	a_rd_data_p2;




   reg [71:0]	active_window[127:0];		// Physical active array : 4(thread) x 32(reg) x 72 bit registers

   reg [71:0]	locals[255:0];			// Physical shadow array : 4(thread) x  8(reg) x 8(shadow)
   reg [71:0]	evens[127:0];			// Physical shadow array : 4(thread) x  8(reg) x 4(shadow)
   reg [71:0]	odds[127:0];			// Physical shadow array : 4(thread) x  8(reg) x 4(shadow)
   reg [71:0]	globals[127:0];			// Physical shadow array : 4(thread) x  8(reg) x 4(shadow)


   integer 	i;				// *** Temporary array      index (no physical flops involved) ***

   reg [71:0]	rd_data_p0;			// *** Temporary array read regs  (no physical flops involved) ***
   reg [71:0]	rd_data_p1;			// *** Temporary array read regs  (no physical flops involved) ***
   reg [71:0]	rd_data_p2;			// *** Temporary array read regs  (no physical flops involved) ***


// For Axis, make synthesizable by making all writes to active_window occur at negedge (normal write and restore)
// Reads of active occur at both edges (read and save)





   // -----------------------------------------------------------------------
   // *** initialization section ***
   // -----------------------------------------------------------------------

   initial begin
       active_window[0]  = {72{1'b0}};		// TID=0 G0 location is always ZERO - location is tied to ground, no memory cell at this address
       active_window[32] = {72{1'b0}};		// TID=1 G0 location is always ZERO - location is tied to ground, no memory cell at this address
       active_window[64] = {72{1'b0}};		// TID=2 G0 location is always ZERO - location is tied to ground, no memory cell at this address
       active_window[96] = {72{1'b0}};		// TID=3 G0 location is always ZERO - location is tied to ground, no memory cell at this address
   end


`ifndef NOINITMEM
   initial begin
     for (i=0; i<128; i=i+1) begin
       active_window[i] = {72{1'b0}};
       evens[i]         = {72{1'b0}};
       odds[i]          = {72{1'b0}};
       globals[i]       = {72{1'b0}};
       locals[i]        = {72{1'b0}};
       locals[i+128]    = {72{1'b0}};
     end
   end
`endif



 
// Concatenate the thread and index bits together

assign thr_rs1[6:0]	= {a_rd_tid[1:0]   , a_rd_addr_p0[4:0] };
assign thr_rs2[6:0]	= {a_rd_tid[1:0]   , a_rd_addr_p1[4:0] };
assign thr_rs3[6:0]	= {a_rd_tid[1:0]   , a_rd_addr_p2[4:0] };
assign thr_rd_w[6:0]	= {a_wr_tid_p0[1:0], a_wr_addr_p0[4:0] };
assign thr_rd_w2[6:0]	= {a_wr_tid_p1[1:0], a_wr_addr_p1[4:0] };


// Clear read enables if reading G0; clear write enables if writing G0;

assign rd_en_p0		= a_rd_en_p0 & (thr_rs1[4:0]   != 5'b00000) & ~tcu_array_wr_inhibit;
assign rd_en_p1		= a_rd_en_p1 & (thr_rs2[4:0]   != 5'b00000) & ~tcu_array_wr_inhibit;
assign rd_en_p2		= a_rd_en_p2 & (thr_rs3[4:0]   != 5'b00000) & ~tcu_array_wr_inhibit;

assign wr_en_p0		= a_wr_en_p0 & (thr_rd_w[4:0]  != 5'b00000) & ~tcu_array_wr_inhibit;
assign wr_en_p1		= a_wr_en_p1 & (thr_rd_w2[4:0] != 5'b00000) & ~tcu_array_wr_inhibit;

assign p0_rd_eq_wr	= (wr_en_p0 & (thr_rs1[6:0] == thr_rd_w[6:0])) | (wr_en_p1 & (thr_rs1[6:0] == thr_rd_w2[6:0]));
assign p1_rd_eq_wr	= (wr_en_p0 & (thr_rs2[6:0] == thr_rd_w[6:0])) | (wr_en_p1 & (thr_rs2[6:0] == thr_rd_w2[6:0]));
assign p2_rd_eq_wr	= (wr_en_p0 & (thr_rs3[6:0] == thr_rd_w[6:0])) | (wr_en_p1 & (thr_rs3[6:0] == thr_rd_w2[6:0]));



   always @ (clk or rd_en_p0 or rd_en_p1 or rd_en_p2 or thr_rs1 or thr_rs2 or thr_rs3 or p0_rd_eq_wr or p1_rd_eq_wr or p2_rd_eq_wr)

      begin

	if (clk)
	  begin 
	    if (rd_en_p0)
	      begin
	        if (p0_rd_eq_wr)	rd_data_p0[71:0] 	<= {72{1'bx}};
	        else			rd_data_p0[71:0]	<= active_window[thr_rs1[6:0]];
	      end
	    else			rd_data_p0[71:0] 	<= {72{1'b0}};


	    if (rd_en_p1)
	      begin
	        if (p1_rd_eq_wr)	rd_data_p1[71:0] 	<= {72{1'bx}};
	        else			rd_data_p1[71:0]	<= active_window[thr_rs2[6:0]];
	      end
	    else			rd_data_p1[71:0] 	<= {72{1'b0}};


	    if (rd_en_p2)
	      begin
	        if (p2_rd_eq_wr)	rd_data_p2[71:0] 	<= {72{1'bx}};
	        else			rd_data_p2[71:0]	<= active_window[thr_rs3[6:0]];
	      end
	    else			rd_data_p2[71:0] 	<= {72{1'b0}};

        end

      end		// ALWAYS CLK ...




   always @ (negedge clk)

      begin

	if (wr_en_p0)	active_window[thr_rd_w[6:0]]	<= a_wr_data_p0[71:0];

	if (wr_en_p1)	active_window[thr_rd_w2[6:0]]	<= a_wr_data_p1[71:0];























      end		// NEGEDGE ALWAYS



 
   /////////////////////////////////////////////
   // Globals
   //-----------------------------------
   // rml inputs are latched on rising edge
   // 1st cycle used for decode
   // 2nd cycle stores active window in phase 1
   // 3rd cycle loads new globals in phase 1
   /////////////////////////////////////////////

   ////////////////////////////
   // locals, ins and outs
   //-------------------------
   // E - set up inputs to flop
   // M - Decode
   // W  (phase 1) - Save
   // W  (phase 2) - write is allowed for save because restore will get killed
   // W2 (phase 1) - Restore
   // W2 (phase 2) - write is allowed
   //
   // actions that occur in phase one are modelled as occurring on the
   // rising edge
   //
   // swaps to the same thread in consecutive cycles not allowed
   /////////////////////////////


   // For synthesis, flop inputs again, then do write of active window on negedge...
   always @ (posedge clk) begin






       // *** *** *** *** *** *** *** *** *** SAVE *** *** *** *** *** *** *** *** ***


       if (a_save_global_en & ~tcu_array_wr_inhibit) begin		// save the globals (0-7 in active window)

          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b000}]	<= active_window[{a_save_global_tid[1:0], 5'b00000}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b001}]	<= active_window[{a_save_global_tid[1:0], 5'b00001}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b010}]	<= active_window[{a_save_global_tid[1:0], 5'b00010}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b011}]	<= active_window[{a_save_global_tid[1:0], 5'b00011}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b100}]	<= active_window[{a_save_global_tid[1:0], 5'b00100}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b101}]	<= active_window[{a_save_global_tid[1:0], 5'b00101}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b110}]	<= active_window[{a_save_global_tid[1:0], 5'b00110}];
          globals[{a_save_global_tid[1:0], a_save_global_addr[1:0], 3'b111}]	<= active_window[{a_save_global_tid[1:0], 5'b00111}];

       end


       if (a_save_odd_en & ~tcu_array_wr_inhibit) begin			// save the ins in odd window (8-15 in active window)

          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b000}]			<= active_window[{a_save_tid[1:0], 5'b01000}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b001}]			<= active_window[{a_save_tid[1:0], 5'b01001}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b010}]			<= active_window[{a_save_tid[1:0], 5'b01010}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b011}]			<= active_window[{a_save_tid[1:0], 5'b01011}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b100}]			<= active_window[{a_save_tid[1:0], 5'b01100}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b101}]			<= active_window[{a_save_tid[1:0], 5'b01101}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b110}]			<= active_window[{a_save_tid[1:0], 5'b01110}];
          odds[{a_save_tid[1:0], a_save_odd_addr[2:1], 3'b111}]			<= active_window[{a_save_tid[1:0], 5'b01111}];

       end


       if (a_save_local_en & ~tcu_array_wr_inhibit) begin			// save the locals (16-23 in active window)

          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b000}]		<= active_window[{a_save_tid[1:0], 5'b10000}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b001}]		<= active_window[{a_save_tid[1:0], 5'b10001}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b010}]		<= active_window[{a_save_tid[1:0], 5'b10010}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b011}]		<= active_window[{a_save_tid[1:0], 5'b10011}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b100}]		<= active_window[{a_save_tid[1:0], 5'b10100}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b101}]		<= active_window[{a_save_tid[1:0], 5'b10101}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b110}]		<= active_window[{a_save_tid[1:0], 5'b10110}];
          locals[{a_save_tid[1:0], a_save_local_addr[2:0], 3'b111}]		<= active_window[{a_save_tid[1:0], 5'b10111}];

       end


       if (a_save_even_en & ~tcu_array_wr_inhibit) begin			// save the ins in even window (24-31 in active window)

          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b000}]		<= active_window[{a_save_tid[1:0], 5'b11000}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b001}]		<= active_window[{a_save_tid[1:0], 5'b11001}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b010}]		<= active_window[{a_save_tid[1:0], 5'b11010}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b011}]		<= active_window[{a_save_tid[1:0], 5'b11011}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b100}]		<= active_window[{a_save_tid[1:0], 5'b11100}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b101}]		<= active_window[{a_save_tid[1:0], 5'b11101}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b110}]		<= active_window[{a_save_tid[1:0], 5'b11110}];
          evens[{a_save_tid[1:0], a_save_even_addr[2:1], 3'b111}]		<= active_window[{a_save_tid[1:0], 5'b11111}];

       end




       // *** *** *** *** *** *** *** *** *** RESTORE *** *** *** *** *** *** *** *** ***


       if (a_restore_global_en & ~tcu_array_wr_inhibit) begin		// restore the globals (0-7 in active window)

          active_window[{a_restore_global_tid[1:0], 5'b00000}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b000}];
          active_window[{a_restore_global_tid[1:0], 5'b00001}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b001}];
          active_window[{a_restore_global_tid[1:0], 5'b00010}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b010}];
          active_window[{a_restore_global_tid[1:0], 5'b00011}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b011}];
          active_window[{a_restore_global_tid[1:0], 5'b00100}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b100}];
          active_window[{a_restore_global_tid[1:0], 5'b00101}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b101}];
          active_window[{a_restore_global_tid[1:0], 5'b00110}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b110}];
          active_window[{a_restore_global_tid[1:0], 5'b00111}]			<= globals[{a_restore_global_tid[1:0], a_restore_global_addr[1:0], 3'b111}];

       end


       if (a_restore_odd_en & ~tcu_array_wr_inhibit) begin			// restore the ins in odd window (8-15 in active window)

         active_window[{a_restore_tid[1:0], 5'b01000}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b000}];
         active_window[{a_restore_tid[1:0], 5'b01001}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b001}];
         active_window[{a_restore_tid[1:0], 5'b01010}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b010}];
         active_window[{a_restore_tid[1:0], 5'b01011}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b011}];
         active_window[{a_restore_tid[1:0], 5'b01100}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b100}];
         active_window[{a_restore_tid[1:0], 5'b01101}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b101}];
         active_window[{a_restore_tid[1:0], 5'b01110}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b110}];
         active_window[{a_restore_tid[1:0], 5'b01111}]				<= odds[{a_restore_tid[1:0], a_restore_odd_addr[2:1], 3'b111}];

       end


       if (a_restore_local_en & ~tcu_array_wr_inhibit) begin			// restore the locals (16-23 in active window)

         active_window[{a_restore_tid[1:0], 5'b10000}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b000}];
         active_window[{a_restore_tid[1:0], 5'b10001}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b001}];
         active_window[{a_restore_tid[1:0], 5'b10010}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b010}];
         active_window[{a_restore_tid[1:0], 5'b10011}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b011}];
         active_window[{a_restore_tid[1:0], 5'b10100}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b100}];
         active_window[{a_restore_tid[1:0], 5'b10101}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b101}];
         active_window[{a_restore_tid[1:0], 5'b10110}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b110}];
         active_window[{a_restore_tid[1:0], 5'b10111}]				<= locals[{a_restore_tid[1:0], a_restore_local_addr[2:0], 3'b111}];

       end


       if (a_restore_even_en & ~tcu_array_wr_inhibit) begin			// restore the ins in even window (24-31 in active window)

         active_window[{a_restore_tid[1:0], 5'b11000}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b000}];
         active_window[{a_restore_tid[1:0], 5'b11001}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b001}];
         active_window[{a_restore_tid[1:0], 5'b11010}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b010}];
         active_window[{a_restore_tid[1:0], 5'b11011}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b011}];
         active_window[{a_restore_tid[1:0], 5'b11100}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b100}];
         active_window[{a_restore_tid[1:0], 5'b11101}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b101}];
         active_window[{a_restore_tid[1:0], 5'b11110}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b110}];
         active_window[{a_restore_tid[1:0], 5'b11111}]				<= evens[{a_restore_tid[1:0], a_restore_even_addr[2:1], 3'b111}];

       end


    end		// POSEDGE ALWAYS


assign a_rd_data_p0[71:0]	= rd_data_p0[71:0];
assign a_rd_data_p1[71:0]	= rd_data_p1[71:0];
assign a_rd_data_p2[71:0]	= rd_data_p2[71:0];


supply0 vss;
supply1 vdd;

endmodule
`endif // `ifndef FPGA


//////////////////////////////////////////
////// n2_frf_mp_256x78_cust
//////////////////////////////////////////


`ifndef FPGA
module fgu_frf_array (
  clk, 
  tcu_array_wr_inhibit, 
  r1_valid, 
  r1_addr, 
  r2_valid, 
  r2_addr, 
  w1_valid, 
  w1_addr, 
  w2_valid, 
  w2_addr, 
  w1_data, 
  w2_data, 
  r1_data, 
  r2_data);
wire masked_r1_valid;
wire masked_r2_valid;


   input          clk;

   input          tcu_array_wr_inhibit;

   // -----------------------------------------------------------------------
   // Reading controls
   // -----------------------------------------------------------------------
   input          r1_valid;
   input    [7:0] r1_addr;
   input          r2_valid;
   input    [7:0] r2_addr;
 
   // -----------------------------------------------------------------------
   // Writing controls 
   // -----------------------------------------------------------------------
   input          w1_valid;
   input    [7:0] w1_addr;
   input          w2_valid;
   input    [7:0] w2_addr;

   // -----------------------------------------------------------------------
   // Write data ports
   // -----------------------------------------------------------------------
   input   [38:0] w1_data;
   input   [38:0] w2_data;


   // -----------------------------------------------------------------------
   // Read output ports
   // -----------------------------------------------------------------------
   output  [38:0] r1_data;
   output  [38:0] r2_data;

   reg [38:0]    r1_data;            // *** Temporary array read regs (no physical flops involved) ***
   reg [38:0]    r2_data;            // *** Temporary array read regs (no physical flops involved) ***

   assign masked_r1_valid = r1_valid & ~(w1_valid & (r1_addr[7:0] == w1_addr[7:0]))
                                     & ~(w2_valid & (r1_addr[7:0] == w2_addr[7:0]));

   assign masked_r2_valid = r2_valid & ~(w1_valid & (r2_addr[7:0] == w1_addr[7:0]))
                                     & ~(w2_valid & (r2_addr[7:0] == w2_addr[7:0]));













   reg [38:0]    data_array[255:0];

   // *** Initialize section ***
`ifndef NOINITMEM
   integer i;
   initial begin
     for (i=0; i<=255; i=i+1) begin
     	 data_array[i] = {39{1'b0}};
     end
   end
`endif




















   always @ (posedge clk) begin

            r1_data[38:0] <= {39{1'b0}};
            r2_data[38:0] <= {39{1'b0}};

   end // posedge always


   always @ (negedge clk) begin


   // -----------------------------------------------------------------------
   // *** Read Section *** 
   // -----------------------------------------------------------------------

      if (masked_r1_valid) begin
            r1_data[38:0] <= data_array[r1_addr[7:0]];
      end


      if (masked_r2_valid) begin
            r2_data[38:0] <= data_array[r2_addr[7:0]];
      end


   // -----------------------------------------------------------------------
   // *** Write Section *** 
   // -----------------------------------------------------------------------


   // 0in assert -active (w1_valid & w2_valid)  -var (w1_addr[7:0] != w2_addr[7:0]) -message "FGU FRF Multiple Write"


      if (w1_valid & ~tcu_array_wr_inhibit) begin
         data_array[w1_addr[7:0]] <= w1_data[38:0];
      end


      if (w2_valid & ~tcu_array_wr_inhibit) begin 
         data_array[w2_addr[7:0]] <= w2_data[38:0];
      end 



     
     



   end // negedge always


supply0 vss;
supply1 vdd;

endmodule  // fgu_frf_array

`endif

//////////////////////////////////////////
////// n2_icd_sp_16p5kb_cust
//////////////////////////////////////////


`ifndef FPGA

module n2_icd_lft_sb_array (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  rd_worden_ac_l, 
  l1clk, 
  reg_d_lft, 
  reg_en_lft, 
  vnw_ary, 
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc);
wire [135:0] word_write_en;
wire [135:0] way_write_en;
wire [135:0] data_in;
wire rd_worden_ac_l_unused;
wire [5:0] adr_ac_l_unused;


input [5:0] 	adr_ac_h ;
input [5:0] 	adr_ac_l ;
input       	rd_en_a_l ;
input       	quaden_f_l ;
input [1:0] 	wr_word_en_ac_l ;
input [3:0] 	wr_waysel0_ac_l ;
input [3:0] 	wr_waysel1_ac_l ;
input [16:0] 	din0_a ;
input [16:0] 	din1_a ;
input [1:0]  	rd_worden_ac_l ;
input        	l1clk ;

input [4:0]     reg_d_lft;
input [1:0]     reg_en_lft;

input		vnw_ary;

output [16:0] 	dout_wy0_bc ;
output [16:0] 	dout_wy1_bc ;
output [16:0] 	dout_wy2_bc ;
output [16:0] 	dout_wy3_bc ;


reg     [143:0]   mem[63:0] ;


reg     [143:0]      local_dout;
reg     [135:0]      old_data;
reg     [143:0]      wr_data;
reg     [135:0]      dout;
wire    [143:0]      temp;
wire    [135:0]      din;

 reg    [16:0]  dout_wy0_bc ;
 reg    [16:0]  dout_wy1_bc ;
 reg    [16:0]  dout_wy2_bc ;
 reg    [16:0]  dout_wy3_bc ;

 reg    [16:0]  way3_word0 ;
 reg    [16:0]  way3_word1 ;
 reg    [16:0]  way2_word0 ;
 reg    [16:0]  way2_word1 ;
 reg    [16:0]  way1_word0 ;
 reg    [16:0]  way1_word1 ;
 reg    [16:0]  way0_word0 ;
 reg    [16:0]  way0_word1 ;
 reg    [31:0] 	n_reg1;
 reg    [31:0] 	n_reg2;
 reg    [31:0] 	n_reg3;
 reg            word_0_read;
integer n;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<64; i=i+1) begin
   mem [i] = {144{1'b0}};
  end
  local_dout = {144{1'b0}};
end
`endif



// assign word_0_read    = ~rd_worden_ac_l[0] & ~rd_en_a_l ;
// assign red_value[4:0] = reg_d_lft[4:0] & {5{reg_en_lft[1] & reg_en_lft[0]}};
assign temp[143:0] = mem[adr_ac_h[5:0]] ;

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
always @(reg_en_lft[1:0]  or reg_d_lft  or temp ) begin
	for (n = 0;  n < 136; n = n + 1 ) begin
		n_reg1 = n;
		if (reg_en_lft[1] & reg_en_lft[0] & ( reg_d_lft >= 5'b00000) & (reg_d_lft <= 5'b10000)) begin
     			if ( n_reg1[9:0] >= ((reg_d_lft + 5'h1) * 5'b01000))
				old_data[n] = temp[n+8] ;
		        else
				old_data[n] = temp[n] ;
		end else
			old_data[n] = temp[n+8] ;
	end 
end 

assign word_write_en[135:0] =  {68{~wr_word_en_ac_l[0], ~wr_word_en_ac_l[1]}} ;   
assign way_write_en[135:0]  =  {17{~wr_waysel0_ac_l[3] , ~wr_waysel1_ac_l[3] ,~wr_waysel0_ac_l[2] , ~wr_waysel1_ac_l[2],
                                   ~wr_waysel0_ac_l[1] , ~wr_waysel1_ac_l[1] ,~wr_waysel0_ac_l[0] , ~wr_waysel1_ac_l[0] }} ;

assign data_in[135:0] = {din0_a[16],din1_a[16] , din0_a[16],din1_a[16] ,  din0_a[16],din1_a[16] , din0_a[16],din1_a[16], // 135:128 
                         din0_a[15],din1_a[15] , din0_a[15],din1_a[15] ,  din0_a[15],din1_a[15] , din0_a[15],din1_a[15], // 127:120 
                         din0_a[14],din1_a[14] , din0_a[14],din1_a[14] ,  din0_a[14],din1_a[14] , din0_a[14],din1_a[14], // 119:112 
                         din0_a[13],din1_a[13] , din0_a[13],din1_a[13] ,  din0_a[13],din1_a[13] , din0_a[13],din1_a[13], // 111:104 
                         din0_a[12],din1_a[12] , din0_a[12],din1_a[12] ,  din0_a[12],din1_a[12] , din0_a[12],din1_a[12], // 103:096 
                         din0_a[11],din1_a[11] , din0_a[11],din1_a[11] ,  din0_a[11],din1_a[11] , din0_a[11],din1_a[11], // 095:088 
                         din0_a[10],din1_a[10] , din0_a[10],din1_a[10] ,  din0_a[10],din1_a[10] , din0_a[10],din1_a[10], // 087:080 
                         din0_a[9],din1_a[9] , din0_a[9],din1_a[9] ,  din0_a[9],din1_a[9] , din0_a[9],din1_a[9], // 079:072 
                         din0_a[8],din1_a[8] , din0_a[8],din1_a[8] ,  din0_a[8],din1_a[8] , din0_a[8],din1_a[8], // 071:064 
                         din0_a[7],din1_a[7] , din0_a[7],din1_a[7] ,  din0_a[7],din1_a[7] , din0_a[7],din1_a[7], // 063:056 
                         din0_a[6],din1_a[6] , din0_a[6],din1_a[6] ,  din0_a[6],din1_a[6] , din0_a[6],din1_a[6], // 055:048 
                         din0_a[5],din1_a[5] , din0_a[5],din1_a[5] ,  din0_a[5],din1_a[5] , din0_a[5],din1_a[5], // 047:040 
                         din0_a[4],din1_a[4] , din0_a[4],din1_a[4] ,  din0_a[4],din1_a[4] , din0_a[4],din1_a[4], // 039:032 
                         din0_a[3],din1_a[3] , din0_a[3],din1_a[3] ,  din0_a[3],din1_a[3] , din0_a[3],din1_a[3], // 031:024 
                         din0_a[2],din1_a[2] , din0_a[2],din1_a[2] ,  din0_a[2],din1_a[2] , din0_a[2],din1_a[2], // 023:016 
                         din0_a[1],din1_a[1] , din0_a[1],din1_a[1] ,  din0_a[1],din1_a[1] , din0_a[1],din1_a[1], // 015:008 
                         din0_a[0],din1_a[0] , din0_a[0],din1_a[0] ,  din0_a[0],din1_a[0] , din0_a[0],din1_a[0]};// 007:000


assign din[135:0] =  (   way_write_en[135:0] & word_write_en[135:0]  & data_in[135:0]  ) |
                     ( ~(way_write_en[135:0] & word_write_en[135:0]) & old_data[135:0] ) ;


////////////////////////////////
// Redunduncy write shifter
////////////////////////////////

always @(reg_en_lft[1:0] or reg_d_lft  or din ) begin
	for (n = 0;  n < 144; n = n + 1 ) begin
		n_reg2 = n;
		if (reg_en_lft[1] & reg_en_lft[0] & ( reg_d_lft >= 5'b00000) & (reg_d_lft <= 5'b10000)) begin
			if ( n_reg2[9:0] <  ((reg_d_lft + 5'h1) * 5'b01000 ))
				wr_data[n] = din[n] ;
			else begin
				if ( n_reg2[9:0] <  ((reg_d_lft + 5'h2)  * 5'b01000 ))
					wr_data[n] = 1'bx ; 
				else
					wr_data[n] = din[n-8] ;
			end
		end else begin
			if (n < 8 ) 
				wr_data[n] = 1'bx ;
			else  
				wr_data[n] = din[n-8] ;
		end
	end
end 

//////////////////////
// Read/write array
//////////////////////

always @ (l1clk or wr_data[143:0] or wr_word_en_ac_l[1:0] or adr_ac_h[5:0] or quaden_f_l or vnw_ary) begin
    if (l1clk & ~quaden_f_l & (~wr_word_en_ac_l[1] | ~wr_word_en_ac_l[0]) & vnw_ary) begin
        mem[adr_ac_h] <= wr_data[143:0] ;
        
        
    end // end if
end // end always



 always @(l1clk or rd_en_a_l or reg_en_lft[1:0] or  reg_d_lft or adr_ac_h[5:0] or rd_worden_ac_l[0] or vnw_ary) begin
    if (l1clk | rd_en_a_l) begin
     dout_wy0_bc[16:0] <= 17'h0;
     dout_wy1_bc[16:0] <= 17'h0;
     dout_wy2_bc[16:0] <= 17'h0;
     dout_wy3_bc[16:0] <= 17'h0;
     word_0_read       <= ~rd_worden_ac_l[0];
     local_dout[143:0] <=  rd_en_a_l ? 144'h0 : mem[adr_ac_h[5:0]];
    end
    if (~l1clk & ~rd_en_a_l & vnw_ary) begin


 
 

     		////////////////////////////////
     		// Redunduncy Read shifter
     		////////////////////////////////

		for (n = 0;  n < 136; n = n + 1 ) begin
			n_reg3 = n;
			if (reg_en_lft[1] & reg_en_lft[0] & ( reg_d_lft >= 5'b00000) & (reg_d_lft <= 5'b10000)) begin
     				if ( n_reg3[9:0] >= ((reg_d_lft + 5'h1) * 5'b01000))
					dout[n] = local_dout[n+8] ;
		       	 else
					dout[n] = local_dout[n] ;
			end else
				dout[n] = local_dout[n+8] ;
		end 
     		/////////////end redundacy shifter ///////////////////

     		way3_word0[16:0]  = {dout[135], dout[127], dout[119] , dout[111], 
	         		             dout[103], dout[95], dout[87] , dout[79],
                          	     dout[71], dout[63], dout[55] , dout[47],
                          	     dout[39], dout[31], dout[23] , dout[15],
                          	     dout[7] } ;

     		way3_word1[16:0]  = {dout[134], dout[126], dout[118] , dout[110], 
                          	     dout[102], dout[94], dout[86] , dout[78],
                          	     dout[70], dout[62], dout[54] , dout[46],
                          	     dout[38], dout[30], dout[22] , dout[14],
                          	     dout[6] } ;

     		way2_word0[16:0]  = {dout[133], dout[125], dout[117] , dout[109], 
                          	     dout[101], dout[93], dout[85] , dout[77],
                          	     dout[69], dout[61], dout[53] , dout[45],
                          	     dout[37], dout[29], dout[21] , dout[13],
                          	     dout[5] } ;

     		way2_word1[16:0]  = {dout[132], dout[124], dout[116] , dout[108], 
                          	     dout[100], dout[92], dout[84] , dout[76],
                          	     dout[68], dout[60], dout[52] , dout[44],
                          	     dout[36], dout[28], dout[20] , dout[12],
                          	     dout[4] } ;

     		way1_word0[16:0]  = {dout[131], dout[123], dout[115] , dout[107], 
                          	     dout[99], dout[91], dout[83] , dout[75],
                          	     dout[67], dout[59], dout[51] , dout[43],
                          	     dout[35], dout[27], dout[19] , dout[11],
                          	     dout[3] } ;

     		way1_word1[16:0]  = {dout[130], dout[122], dout[114] , dout[106], 
                          	     dout[98], dout[90], dout[82] , dout[74],
                          	     dout[66], dout[58], dout[50] , dout[42],
                          	     dout[34], dout[26], dout[18] , dout[10],
                          	     dout[2] } ;

		way0_word0[16:0]  = {dout[129], dout[121], dout[113] , dout[105], 
                          	     dout[97], dout[89], dout[81] , dout[73],
                          	     dout[65], dout[57], dout[49] , dout[41],
                          	     dout[33], dout[25], dout[17] , dout[9],
                          	     dout[1] } ;

		way0_word1[16:0]  = {dout[128], dout[120], dout[112] , dout[104], 
                          	     dout[96], dout[88], dout[80] , dout[72],
                          	     dout[64], dout[56], dout[48] , dout[40],
                          	     dout[32], dout[24], dout[16] , dout[8],
                          	     dout[0] } ;

		///////////////////////
		// rd_data column mux
		///////////////////////
       		dout_wy0_bc[16:0] <=  word_0_read ? way0_word0[16:0] : way0_word1[16:0] ;
       		dout_wy1_bc[16:0] <=  word_0_read ? way1_word0[16:0] : way1_word1[16:0] ;
       		dout_wy2_bc[16:0] <=  word_0_read ? way2_word0[16:0] : way2_word1[16:0] ;
       		dout_wy3_bc[16:0] <=  word_0_read ? way3_word0[16:0] : way3_word1[16:0] ;

    end // if (~rd_en_a_l) 
end // always

// Precharge
// always @ (posedge l1clk) begin
//      // local_dout[143:0] = 144'h0;
//      dout_wy0_bc[16:0] <= 17'h0;
//      dout_wy1_bc[16:0] <= 17'h0;
//      dout_wy2_bc[16:0] <= 17'h0;
//      dout_wy3_bc[16:0] <= 17'h0;
// end

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
// always @(red_value or local_dout ) begin
//   for (n = 0;  n < 144; n = n + 1 ) begin
//      if ( n >= (red_value * 8 ))
//        dout[n] = local_dout[n+8] ;
//      else
//        dout[n] = local_dout[n] ;
//   end
// end 

assign rd_worden_ac_l_unused = rd_worden_ac_l[1] ;
assign adr_ac_l_unused[5:0]  = adr_ac_l[5:0] ;


supply0 vss;
supply1 vdd;
endmodule
`endif 	// `ifndef FPGA


`ifndef FPGA
module n2_icd_rgt_sb_array (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  rd_worden_ac_l, 
  l1clk, 
  vnw_ary, 
  reg_d_rgt, 
  reg_en_rgt, 
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc);
wire [127:0] word_write_en;
wire [127:0] way_write_en;
wire [127:0] data_in;
wire rd_worden_ac_l_unused;
wire [5:0] adr_ac_l_unused;


input [5:0] 	adr_ac_h ;
input [5:0] 	adr_ac_l ;
input       	rd_en_a_l ;
input       	quaden_f_l ;
input [1:0] 	wr_word_en_ac_l ;
input [3:0] 	wr_waysel0_ac_l ;
input [3:0] 	wr_waysel1_ac_l ;
input [32:17] 	din0_a ;
input [32:17] 	din1_a ;
input [1:0]  	rd_worden_ac_l ;
input        	l1clk ;

input		vnw_ary;

input [4:0]     reg_d_rgt;
input [1:0]     reg_en_rgt;

output [15:0] 	dout_wy0_bc ;
output [15:0] 	dout_wy1_bc ;
output [15:0] 	dout_wy2_bc ;
output [15:0] 	dout_wy3_bc ;




reg     [135:0]   mem[63:0] ;


reg     [135:0]      local_dout;
reg     [127:0]      old_data;
reg     [135:0]      wr_data;
reg     [127:0]      dout;
wire    [135:0]      temp;
wire    [127:0]      din;

 reg    [15:0]  dout_wy0_bc ;
 reg    [15:0]  dout_wy1_bc ;
 reg    [15:0]  dout_wy2_bc ;
 reg    [15:0]  dout_wy3_bc ;

 reg    [15:0]  way3_word0 ;
 reg    [15:0]  way3_word1 ;
 reg    [15:0]  way2_word0 ;
 reg    [15:0]  way2_word1 ;
 reg    [15:0]  way1_word0 ;
 reg    [15:0]  way1_word1 ;
 reg    [15:0]  way0_word0 ;
 reg    [15:0]  way0_word1 ;
 reg    [31:0] 	n_reg1;
 reg    [31:0] 	n_reg2;
 reg    [31:0] 	n_reg3;
 reg            word_0_read ;

integer n;


`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<64; i=i+1) begin
   mem [i] = {136{1'b0}};
  end
  local_dout = {136{1'b0}};
end
`endif


// assign word_0_read = ~rd_worden_ac_l[0] & ~rd_en_a_l ;
// assign red_value[4:0] = reg_d_rgt[4:0] & {5{reg_en_rgt[1] & reg_en_rgt[0]}};
assign temp[135:0] = mem[adr_ac_h[5:0]] ;

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
always @(reg_en_rgt[1:0]  or reg_d_rgt  or temp ) begin
        for (n = 0;  n < 128; n = n + 1 ) begin
		n_reg1 = n;
                if (reg_en_rgt[1] & reg_en_rgt[0] & ( reg_d_rgt >= 5'b00000) & (reg_d_rgt <= 5'b01111)) begin
                        if ( n_reg1[9:0] >= ((reg_d_rgt + 5'h1) * 5'b01000))
                                old_data[n] = temp[n+8] ;
                        else
                                old_data[n] = temp[n] ;
                end else
                        old_data[n] = temp[n+8] ;
        end
end

assign word_write_en[127:0] =  {64{~wr_word_en_ac_l[0], ~wr_word_en_ac_l[1]}} ;   
assign way_write_en[127:0]  =  {16{~wr_waysel0_ac_l[0] , ~wr_waysel1_ac_l[0] ,~wr_waysel0_ac_l[1] , ~wr_waysel1_ac_l[1],
                                   ~wr_waysel0_ac_l[2] , ~wr_waysel1_ac_l[2] ,~wr_waysel0_ac_l[3] , ~wr_waysel1_ac_l[3] }} ;

assign data_in[127:0] = {din0_a[32],din1_a[32] , din0_a[32],din1_a[32] ,  din0_a[32],din1_a[32] , din0_a[32],din1_a[32], // 127:120 
                         din0_a[31],din1_a[31] , din0_a[31],din1_a[31] ,  din0_a[31],din1_a[31] , din0_a[31],din1_a[31], // 119:112 
                         din0_a[30],din1_a[30] , din0_a[30],din1_a[30] ,  din0_a[30],din1_a[30] , din0_a[30],din1_a[30], // 111:104 
                         din0_a[29],din1_a[29] , din0_a[29],din1_a[29] ,  din0_a[29],din1_a[29] , din0_a[29],din1_a[29], // 103:096 
                         din0_a[28],din1_a[28] , din0_a[28],din1_a[28] ,  din0_a[28],din1_a[28] , din0_a[28],din1_a[28], // 095:088 
                         din0_a[27],din1_a[27] , din0_a[27],din1_a[27] ,  din0_a[27],din1_a[27] , din0_a[27],din1_a[27], // 087:080 
                         din0_a[26],din1_a[26] , din0_a[26],din1_a[26] ,  din0_a[26],din1_a[26] , din0_a[26],din1_a[26], // 079:072 
                         din0_a[25],din1_a[25] , din0_a[25],din1_a[25] ,  din0_a[25],din1_a[25] , din0_a[25],din1_a[25], // 071:064 
                         din0_a[24],din1_a[24] , din0_a[24],din1_a[24] ,  din0_a[24],din1_a[24] , din0_a[24],din1_a[24], // 063:056 
                         din0_a[23],din1_a[23] , din0_a[23],din1_a[23] ,  din0_a[23],din1_a[23] , din0_a[23],din1_a[23], // 055:048 
                         din0_a[22],din1_a[22] , din0_a[22],din1_a[22] ,  din0_a[22],din1_a[22] , din0_a[22],din1_a[22], // 047:040 
                         din0_a[21],din1_a[21] , din0_a[21],din1_a[21] ,  din0_a[21],din1_a[21] , din0_a[21],din1_a[21], // 039:032 
                         din0_a[20],din1_a[20] , din0_a[20],din1_a[20] ,  din0_a[20],din1_a[20] , din0_a[20],din1_a[20], // 031:024
                         din0_a[19],din1_a[19] , din0_a[19],din1_a[19] ,  din0_a[19],din1_a[19] , din0_a[19],din1_a[19], // 023:016 
                         din0_a[18],din1_a[18] , din0_a[18],din1_a[18] ,  din0_a[18],din1_a[18] , din0_a[18],din1_a[18], // 015:008 
                         din0_a[17],din1_a[17] , din0_a[17],din1_a[17] ,  din0_a[17],din1_a[17] , din0_a[17],din1_a[17]};// 007:000 


assign din[127:0] =  (   way_write_en[127:0] & word_write_en[127:0]  & data_in[127:0]  ) |
                     ( ~(way_write_en[127:0] & word_write_en[127:0]) & old_data[127:0] ) ;

////////////////////////////////
// Redunduncy write shifter
////////////////////////////////
always @(reg_en_rgt[1:0] or reg_d_rgt  or din ) begin
        for (n = 0;  n < 136; n = n + 1 ) begin
		n_reg2 = n;
                if (reg_en_rgt[1] & reg_en_rgt[0] & ( reg_d_rgt >= 5'b00000) & (reg_d_rgt <= 5'b01111)) begin
                        if ( n_reg2[9:0] <  ((reg_d_rgt + 5'h1) * 5'b01000 ))
                                wr_data[n] = din[n] ;
                        else begin
                                if ( n_reg2[9:0] <  ((reg_d_rgt + 5'h2)  * 5'b01000 ))
                                        wr_data[n] = 1'bx ;
                                else
                                        wr_data[n] = din[n-8] ;
                        end
                end else begin
			if (n < 8) 
				wr_data[n] = 1'bx ;
			else
				wr_data[n] = din[n-8] ;
		end
        end
end

//////////////////////
// Read/write array
//////////////////////


always @ (l1clk or wr_data[135:0] or wr_word_en_ac_l[1:0] or adr_ac_h[5:0] or quaden_f_l or vnw_ary) begin
    if (l1clk  & ~quaden_f_l & (~wr_word_en_ac_l[1] | ~wr_word_en_ac_l[0]) & vnw_ary) begin
        mem[adr_ac_h] <= wr_data[135:0] ;
        
        
    end // end if
end // end always




 always @(l1clk or rd_en_a_l or reg_en_rgt[1:0] or  reg_d_rgt or adr_ac_h[5:0] or rd_worden_ac_l[0] or vnw_ary) begin
    if (l1clk | rd_en_a_l) begin
     dout_wy0_bc[15:0] <= 16'h0;
     dout_wy1_bc[15:0] <= 16'h0;
     dout_wy2_bc[15:0] <= 16'h0;
     dout_wy3_bc[15:0] <= 16'h0;
     word_0_read       <= ~rd_worden_ac_l[0];
     local_dout[135:0] <=  rd_en_a_l ? 136'h0 : mem[adr_ac_h[5:0]];
    end
    if (~l1clk & ~rd_en_a_l & vnw_ary) begin


 
 


    		////////////////////////////////
    		// Redunduncy Read shifter
    		////////////////////////////////
        	for (n = 0;  n < 128; n = n + 1 ) begin
			n_reg3 = n;
			if (reg_en_rgt[1] & reg_en_rgt[0] & ( reg_d_rgt >= 5'b00000) & (reg_d_rgt <= 5'b01111)) begin
				if ( n_reg3[9:0] >= ((reg_d_rgt + 5'h1) * 5'b01000))
                                	dout[n] = local_dout[n+8] ;
                        	else
                                	dout[n] = local_dout[n] ;
                	end else
                        	dout[n] = local_dout[n+8] ;
        	end
    		///////////////////////
    		// rd_data column mux
    		///////////////////////

    		way0_word0[15:0]  = {dout[127], dout[119] , dout[111], dout[103], 
       		                     dout[95], dout[87] , dout[79], dout[71], 
       		                     dout[63], dout[55] , dout[47], dout[39], 
       		                     dout[31], dout[23] , dout[15], dout[7] } ;

    		way0_word1[15:0]  = {dout[126], dout[118] , dout[110], dout[102], 
       		                     dout[94], dout[86] , dout[78], dout[70], 
       		                     dout[62], dout[54] , dout[46], dout[38], 
       		                     dout[30], dout[22] , dout[14], dout[6] } ;

    		way1_word0[15:0]  = {dout[125], dout[117] , dout[109], dout[101], 
       		                     dout[93], dout[85] , dout[77], dout[69], 
       		                     dout[61], dout[53] , dout[45], dout[37], 
       		                     dout[29], dout[21] , dout[13], dout[5] } ;

    		way1_word1[15:0]  = {dout[124], dout[116] , dout[108], dout[100], 
       		                     dout[92], dout[84] , dout[76], dout[68], 
       		                     dout[60], dout[52] , dout[44], dout[36], 
       		                     dout[28], dout[20] , dout[12], dout[4] } ;

    		way2_word0[15:0]  = {dout[123], dout[115] , dout[107], dout[99], 
       		                     dout[91], dout[83] , dout[75], dout[67], 
       		                     dout[59], dout[51] , dout[43], dout[35], 
       		                     dout[27], dout[19] , dout[11], dout[3] } ;

    		way2_word1[15:0]  = {dout[122], dout[114] , dout[106], dout[98], 
       		                     dout[90], dout[82] , dout[74], dout[66], 
       		                     dout[58], dout[50] , dout[42], dout[34], 
       		                     dout[26], dout[18] , dout[10], dout[2] } ;

    		way3_word0[15:0]  = {dout[121], dout[113] , dout[105], dout[97], 
       		                     dout[89], dout[81] , dout[73], dout[65], 
       		                     dout[57], dout[49] , dout[41], dout[33], 
       		                     dout[25], dout[17] , dout[9], dout[1] } ;

    		way3_word1[15:0]  = {dout[120], dout[112] , dout[104], dout[96], 
       		                     dout[88], dout[80] , dout[72], dout[64], 
       		                     dout[56], dout[48] , dout[40], dout[32], 
       		                     dout[24], dout[16] , dout[8], dout[0] } ;

    		dout_wy0_bc[15:0] <=  word_0_read ? way0_word0[15:0] : way0_word1[15:0] ;  
    		dout_wy1_bc[15:0] <=  word_0_read ? way1_word0[15:0] : way1_word1[15:0] ;  
    		dout_wy2_bc[15:0] <=  word_0_read ? way2_word0[15:0] : way2_word1[15:0] ;  
    		dout_wy3_bc[15:0] <=  word_0_read ? way3_word0[15:0] : way3_word1[15:0] ;  

    end // if (~rd_en_a_l)
end // always

// Precharge
// always @ (posedge l1clk) begin
// local_dout[135:0] = 136'h0;
//	dout_wy0_bc[15:0] <= 16'b0;
//	dout_wy1_bc[15:0] <= 16'b0;
//	dout_wy2_bc[15:0] <= 16'b0;
//	dout_wy3_bc[15:0] <= 16'b0;
//end

////////////////////////////////
// Redunduncy Read shifter
////////////////////////////////
// always @(red_value or local_dout ) begin
//   for (n = 0;  n < 136; n = n + 1 ) begin
//      if ( n >= (red_value * 8 ))
//        dout[n] = local_dout[n+8] ;
//      else
//        dout[n] = local_dout[n] ;
//   end
// end

assign rd_worden_ac_l_unused = rd_worden_ac_l[1] ;
assign adr_ac_l_unused[5:0]  = adr_ac_l[5:0] ;


supply0 vss;
supply1 vdd;
endmodule
`endif	// `ifndef FPGA


//////////////////////////////////////////
////// n2_ict_sp_1920b_cust
//////////////////////////////////////////

module n2_ict_sp_1920b_array (
  clk, 
  rd_en_b, 
  wr_en_w_b, 
  rd_en_a, 
  wrreq_a, 
  addr, 
  wr_inhibit, 
  din, 
  dout);
wire rd_en_b_unused;




input			clk;
input	     		rd_en_b;	// comes on negedge
input	     		wr_en_w_b;	// comes on negedge (way specific)
input	     		rd_en_a;	// comes on posedge
input	     		wrreq_a;	// comes on posedge (not way specific)
input	[6-1:0]	addr;		// comes on negedge
input			wr_inhibit;	// async

input	[30-1:0]	din;		// comes on posedge
output	[30-1:0]	dout;








reg	[30-1:0]	mem[64-1:0];
reg	[30-1:0]	local_dout;

assign rd_en_b_unused = rd_en_b;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<64; i=i+1) begin
    mem[i] = {30{1'b0}}; 
  end
  local_dout = {30{1'b0}};
end
`endif

//////////////////////
// Read/write array
//////////////////////

always @(negedge clk) begin
    if (wr_en_w_b) begin
        mem[addr] <= din;



    end
end

// always @(clk or rd_en_a or wr_en_a or addr) begin
//    if (clk) begin
//      if (rd_en_a) begin
//          if (wr_en_a)
//              local_dout[30-1:0] = 30'hx;
//          else    
//              local_dout[30-1:0] = mem[addr] ;
//      end
//      else
//          local_dout[30-1:0] = 30'h0;
// end

 always @(posedge clk) begin
  if (rd_en_b)
     local_dout[30-1:0] <= mem[addr];
  else
     local_dout[30-1:0] <= 30'h0;
 end

assign dout[30-1:0] = local_dout[30-1:0] & {30{rd_en_a & ~wrreq_a & ~wr_inhibit}};

supply0 vss;
supply1 vdd;


endmodule


//////////////////////////////////////////
////// n2_dva_dp_32x32_cust
//////////////////////////////////////////

module n2_dva_dp_32x32_array (
  clk, 
  rd_addr, 
  wr_addr, 
  din, 
  bit_wen, 
  rd_en, 
  wr_en, 
  dout);
wire [31:0] temp;
wire [31:0] vbit_sa;
wire [31:0] wt_data;
wire [31:0] vbit;


input		clk;
input	[4:0]	rd_addr;
input	[4:0]	wr_addr;
input	[31:0]	din;
input	[31:0]	bit_wen;
input		rd_en;
input		wr_en;
   
output	[31:0]	dout;

reg	[31:0] mem [31:0];
reg	[31:0] 	dout ;

`ifndef NOINITMEM
// Initialize the arrays.
integer i;
initial begin
  for (i=0;i<32;i=i+1) begin
      mem[i] = 32'b0 ;
  end
end 
`endif

/////////////
// Write on negedge
/////////////

assign temp[31:0] = mem[wr_addr[4:0]];

always @(negedge clk) begin
  if (wr_en) begin
    mem[wr_addr[4:0]] <= (bit_wen[31:0] & din[31:0]) | (~bit_wen[31:0] & temp[31:0]);




  end
end

/////////////
// Read 
/////////////

assign vbit_sa[31:0] = mem[rd_addr[4:0]] & {32{rd_en}};

// Handle write-through case.
// Read result is the AND of the previous and new values.
// wt_data represents the precharged write bit line
// It is high when writing a '1' or when not writing.

assign wt_data[31:0]  = {32{rd_addr[4:0] != wr_addr[4:0]}} | ~bit_wen[31:0] | din[31:0] | {32{~wr_en}};

assign vbit[31:0] = vbit_sa[31:0] & wt_data[31:0];

always @(clk or vbit) begin
  if (clk)
    dout[31:0] <= vbit[31:0];
end


supply0 vss;
supply1 vdd;

endmodule

//////////////////////////////////////////
////// n2_dca_sp_9kb_cust
//////////////////////////////////////////

module n2_dca_sp_9kb_subbank (
  l1clk, 
  l1clk_wr, 
  rd_en_b, 
  rd_en_a, 
  wr_en_a, 
  wr_en_b, 
  wr_inh_b, 
  addr_b, 
  byte_wr_en_b, 
  wr_waysel_b, 
  wr_data_a, 
  red_data, 
  red_en, 
  vnw_ary, 
  w0_rdata_h, 
  w0_rdata_l, 
  w1_rdata_h, 
  w1_rdata_l);
wire red_shift_en;
wire [143:0] data_in;
wire [143:0] byte_mask;
wire w0_wcs;
wire w1_wcs;
wire [143:0] way_mask;
wire [143:0] local_dout;
wire rcs_l;
wire [35:0] w0_dout;
wire [35:0] w1_dout;
       


// way0 and way1 are interleaved physically across 2 subbanks
//        [288,277,..................,145,144] -- xdec -- [143,142,.............,1,0]
//          H   L   H   L       H   L   H   L  -- xdec --  L   H   L   H      L H L H      
// way1 = [288,287,284,283,...,151,150,147,146 -- xdec -- 141,140,137,136,...,5,4,1,0
// way0 = [286,285,282,281,...,149,148,145,144 -- xdec -- 143,142,139,138,...,7,6,3,2

input		l1clk;          // l1clk from l1clk_header
input		l1clk_wr;       // l1clk from l1clk_header
input		rd_en_b;        // e_cycle b_phase signal
input		rd_en_a;        // m_cycle a_phase signal
input		wr_en_a;        // m_cycle a_phase signal
input		wr_en_b;        // e_cycle b_phase signal
input		wr_inh_b;       // e_cycle b_phase signal
input   [10:3]	addr_b;         // e_cycle b_phase signal
input   [7:0]	byte_wr_en_b;   // e_cycle b_phase signal
input   [1:0]	wr_waysel_b;    // e_cycle b_phase signal

input   [71:0]	wr_data_a;   // m_cycle a_phase signal

input	[5:0]	red_data;
input	[1:0]	red_en;

input		vnw_ary;

output  [35:0]	w0_rdata_h;     // m_cycle b_phase clock-like signal    
output  [35:0]	w0_rdata_l;     // m_cycle b_phase clock-like signal    
output  [35:0]	w1_rdata_h;     // m_cycle b_phase clock-like signal    
output  [35:0]	w1_rdata_l;     // m_cycle b_phase clock-like signal    

// synopsys translate_off

reg     [147:0]	mem[128-1:0];
reg     [143:0]	dout;
reg	[35:0]	w0_sao_h;
reg	[35:0]	w0_sao_l;
reg	[35:0]	w1_sao_h;
reg	[35:0]	w1_sao_l;

wire	[147:0]	wr_data;
wire	[143:0]	din;
wire	[147:0]	temp;


assign red_shift_en = red_en[1] & red_en[0];

//////////////////////////////////
// Initialize to zeros
`ifndef NOINITMEM
integer i;
initial begin
  for (i=0;i<128;i=i+1) begin
  mem[i] =  148'd0;
  end
end
`endif

/////////////////////////////
// wrdata input mapping 
////////////////////////////

assign data_in[143:0] = {
	wr_data_a[71],wr_data_a[70],wr_data_a[71],wr_data_a[70],
	wr_data_a[69],wr_data_a[68],wr_data_a[69],wr_data_a[68],
	wr_data_a[67],wr_data_a[66],wr_data_a[67],wr_data_a[66],
	wr_data_a[65],wr_data_a[64],wr_data_a[65],wr_data_a[64],
	wr_data_a[63],wr_data_a[62],wr_data_a[63],wr_data_a[62],
	wr_data_a[61],wr_data_a[60],wr_data_a[61],wr_data_a[60],
	wr_data_a[59],wr_data_a[58],wr_data_a[59],wr_data_a[58],
	wr_data_a[57],wr_data_a[56],wr_data_a[57],wr_data_a[56],
	wr_data_a[55],wr_data_a[54],wr_data_a[55],wr_data_a[54],
	wr_data_a[53],wr_data_a[52],wr_data_a[53],wr_data_a[52],
	wr_data_a[51],wr_data_a[50],wr_data_a[51],wr_data_a[50],
	wr_data_a[49],wr_data_a[48],wr_data_a[49],wr_data_a[48],
	wr_data_a[47],wr_data_a[46],wr_data_a[47],wr_data_a[46],
	wr_data_a[45],wr_data_a[44],wr_data_a[45],wr_data_a[44],
	wr_data_a[43],wr_data_a[42],wr_data_a[43],wr_data_a[42],
	wr_data_a[41],wr_data_a[40],wr_data_a[41],wr_data_a[40],
	wr_data_a[39],wr_data_a[38],wr_data_a[39],wr_data_a[38],
	wr_data_a[37],wr_data_a[36],wr_data_a[37],wr_data_a[36],
	wr_data_a[35],wr_data_a[34],wr_data_a[35],wr_data_a[34],
	wr_data_a[33],wr_data_a[32],wr_data_a[33],wr_data_a[32],
	wr_data_a[31],wr_data_a[30],wr_data_a[31],wr_data_a[30],
	wr_data_a[29],wr_data_a[28],wr_data_a[29],wr_data_a[28],
	wr_data_a[27],wr_data_a[26],wr_data_a[27],wr_data_a[26],
	wr_data_a[25],wr_data_a[24],wr_data_a[25],wr_data_a[24],
	wr_data_a[23],wr_data_a[22],wr_data_a[23],wr_data_a[22],
	wr_data_a[21],wr_data_a[20],wr_data_a[21],wr_data_a[20],
	wr_data_a[19],wr_data_a[18],wr_data_a[19],wr_data_a[18],
	wr_data_a[17],wr_data_a[16],wr_data_a[17],wr_data_a[16],
	wr_data_a[15],wr_data_a[14],wr_data_a[15],wr_data_a[14],
	wr_data_a[13],wr_data_a[12],wr_data_a[13],wr_data_a[12],
	wr_data_a[11],wr_data_a[10],wr_data_a[11],wr_data_a[10],
	wr_data_a[9],wr_data_a[8],wr_data_a[9],wr_data_a[8],
	wr_data_a[7],wr_data_a[6],wr_data_a[7],wr_data_a[6],
	wr_data_a[5],wr_data_a[4],wr_data_a[5],wr_data_a[4],
	wr_data_a[3],wr_data_a[2],wr_data_a[3],wr_data_a[2],
	wr_data_a[1],wr_data_a[0],wr_data_a[1],wr_data_a[0]};

////////////////////////////////
// Encode mask for byte enables
////////////////////////////////
assign byte_mask[143:0] = {
	{9{byte_wr_en_b[7],byte_wr_en_b[6],byte_wr_en_b[7],byte_wr_en_b[6],
 	   byte_wr_en_b[5],byte_wr_en_b[4],byte_wr_en_b[5],byte_wr_en_b[4]}},
	{9{byte_wr_en_b[3],byte_wr_en_b[2],byte_wr_en_b[3],byte_wr_en_b[2],
	   byte_wr_en_b[1],byte_wr_en_b[0],byte_wr_en_b[1],byte_wr_en_b[0]}}};

////////////////////////////////
// Encode mask for way enables
////////////////////////////////
assign w0_wcs = wr_waysel_b[0] & wr_en_b & ~wr_inh_b & ~rd_en_b ;   // way0 write 
assign w1_wcs = wr_waysel_b[1] & wr_en_b & ~wr_inh_b & ~rd_en_b ;   // way1 write

assign way_mask[143:0] = { {36{ {2{w1_wcs}},{2{w0_wcs}} }} };


assign din[143:0] = ( (byte_mask[143:0] & way_mask[143:0]) & data_in[143:0]) |
                    (~(byte_mask[143:0] & way_mask[143:0]) & local_dout[143:0]);

//////////////////////////
// Redundancy write shifter
//////////////////////////

assign wr_data[  3:  0] = din[  3:  0];
assign wr_data[  7:  4] = (red_shift_en && (red_data >= 6'd0 )) ? din[  7:  4] : din[  3:  0];
assign wr_data[ 11:  8] = (red_shift_en && (red_data >= 6'd1 )) ? din[ 11:  8] : din[  7:  4];
assign wr_data[ 15: 12] = (red_shift_en && (red_data >= 6'd2 )) ? din[ 15: 12] : din[ 11:  8];
assign wr_data[ 19: 16] = (red_shift_en && (red_data >= 6'd3 )) ? din[ 19: 16] : din[ 15: 12];
assign wr_data[ 23: 20] = (red_shift_en && (red_data >= 6'd4 )) ? din[ 23: 20] : din[ 19: 16];
assign wr_data[ 27: 24] = (red_shift_en && (red_data >= 6'd5 )) ? din[ 27: 24] : din[ 23: 20];
assign wr_data[ 31: 28] = (red_shift_en && (red_data >= 6'd6 )) ? din[ 31: 28] : din[ 27: 24];
assign wr_data[ 35: 32] = (red_shift_en && (red_data >= 6'd7 )) ? din[ 35: 32] : din[ 31: 28];
assign wr_data[ 39: 36] = (red_shift_en && (red_data >= 6'd8 )) ? din[ 39: 36] : din[ 35: 32];
assign wr_data[ 43: 40] = (red_shift_en && (red_data >= 6'd9 )) ? din[ 43: 40] : din[ 39: 36];
assign wr_data[ 47: 44] = (red_shift_en && (red_data >= 6'd10)) ? din[ 47: 44] : din[ 43: 40];
assign wr_data[ 51: 48] = (red_shift_en && (red_data >= 6'd11)) ? din[ 51: 48] : din[ 47: 44];
assign wr_data[ 55: 52] = (red_shift_en && (red_data >= 6'd12)) ? din[ 55: 52] : din[ 51: 48];
assign wr_data[ 59: 56] = (red_shift_en && (red_data >= 6'd13)) ? din[ 59: 56] : din[ 55: 52];
assign wr_data[ 63: 60] = (red_shift_en && (red_data >= 6'd14)) ? din[ 63: 60] : din[ 59: 56];
assign wr_data[ 67: 64] = (red_shift_en && (red_data >= 6'd15)) ? din[ 67: 64] : din[ 63: 60];
assign wr_data[ 71: 68] = (red_shift_en && (red_data >= 6'd16)) ? din[ 71: 68] : din[ 67: 64];
assign wr_data[ 75: 72] = (red_shift_en && (red_data >= 6'd17)) ? din[ 75: 72] : din[ 71: 68];
assign wr_data[ 79: 76] = (red_shift_en && (red_data >= 6'd18)) ? din[ 79: 76] : din[ 75: 72];
assign wr_data[ 83: 80] = (red_shift_en && (red_data >= 6'd19)) ? din[ 83: 80] : din[ 79: 76];
assign wr_data[ 87: 84] = (red_shift_en && (red_data >= 6'd20)) ? din[ 87: 84] : din[ 83: 80];
assign wr_data[ 91: 88] = (red_shift_en && (red_data >= 6'd21)) ? din[ 91: 88] : din[ 87: 84];
assign wr_data[ 95: 92] = (red_shift_en && (red_data >= 6'd22)) ? din[ 95: 92] : din[ 91: 88];
assign wr_data[ 99: 96] = (red_shift_en && (red_data >= 6'd23)) ? din[ 99: 96] : din[ 95: 92];
assign wr_data[103:100] = (red_shift_en && (red_data >= 6'd24)) ? din[103:100] : din[ 99: 96];
assign wr_data[107:104] = (red_shift_en && (red_data >= 6'd25)) ? din[107:104] : din[103:100];
assign wr_data[111:108] = (red_shift_en && (red_data >= 6'd26)) ? din[111:108] : din[107:104];
assign wr_data[115:112] = (red_shift_en && (red_data >= 6'd27)) ? din[115:112] : din[111:108];
assign wr_data[119:116] = (red_shift_en && (red_data >= 6'd28)) ? din[119:116] : din[115:112];
assign wr_data[123:120] = (red_shift_en && (red_data >= 6'd29)) ? din[123:120] : din[119:116];
assign wr_data[127:124] = (red_shift_en && (red_data >= 6'd30)) ? din[127:124] : din[123:120];
assign wr_data[131:128] = (red_shift_en && (red_data >= 6'd31)) ? din[131:128] : din[127:124];
assign wr_data[135:132] = (red_shift_en && (red_data >= 6'd32)) ? din[135:132] : din[131:128];
assign wr_data[139:136] = (red_shift_en && (red_data >= 6'd33)) ? din[139:136] : din[135:132];
assign wr_data[143:140] = (red_shift_en && (red_data >= 6'd34)) ? din[143:140] : din[139:136];
assign wr_data[147:144] = (red_shift_en && (red_data >= 6'd35)) ? 4'bx         : din[143:140];

//////////////////////
// Write array       
//////////////////////
assign rcs_l = rd_en_b & ~wr_en_b;              // read for both way0 & way1

always @ (negedge l1clk_wr) begin
    if ((w0_wcs | w1_wcs) & ~rcs_l & vnw_ary) begin
        mem[addr_b[10:4]] <= wr_data;


    end
end

assign temp[147:0] = mem[addr_b[10:4]];

//////////////////////////
// Redundancy read shifter
//////////////////////////

assign local_dout[  3:  0] = (red_shift_en && (red_data >= 6'd0 )) ? temp[  3:  0] : temp[  7:  4];
assign local_dout[  7:  4] = (red_shift_en && (red_data >= 6'd1 )) ? temp[  7:  4] : temp[ 11:  8];
assign local_dout[ 11:  8] = (red_shift_en && (red_data >= 6'd2 )) ? temp[ 11:  8] : temp[ 15: 12];
assign local_dout[ 15: 12] = (red_shift_en && (red_data >= 6'd3 )) ? temp[ 15: 12] : temp[ 19: 16];
assign local_dout[ 19: 16] = (red_shift_en && (red_data >= 6'd4 )) ? temp[ 19: 16] : temp[ 23: 20];
assign local_dout[ 23: 20] = (red_shift_en && (red_data >= 6'd5 )) ? temp[ 23: 20] : temp[ 27: 24];
assign local_dout[ 27: 24] = (red_shift_en && (red_data >= 6'd6 )) ? temp[ 27: 24] : temp[ 31: 28];
assign local_dout[ 31: 28] = (red_shift_en && (red_data >= 6'd7 )) ? temp[ 31: 28] : temp[ 35: 32];
assign local_dout[ 35: 32] = (red_shift_en && (red_data >= 6'd8 )) ? temp[ 35: 32] : temp[ 39: 36];
assign local_dout[ 39: 36] = (red_shift_en && (red_data >= 6'd9 )) ? temp[ 39: 36] : temp[ 43: 40];
assign local_dout[ 43: 40] = (red_shift_en && (red_data >= 6'd10)) ? temp[ 43: 40] : temp[ 47: 44];
assign local_dout[ 47: 44] = (red_shift_en && (red_data >= 6'd11)) ? temp[ 47: 44] : temp[ 51: 48];
assign local_dout[ 51: 48] = (red_shift_en && (red_data >= 6'd12)) ? temp[ 51: 48] : temp[ 55: 52];
assign local_dout[ 55: 52] = (red_shift_en && (red_data >= 6'd13)) ? temp[ 55: 52] : temp[ 59: 56];
assign local_dout[ 59: 56] = (red_shift_en && (red_data >= 6'd14)) ? temp[ 59: 56] : temp[ 63: 60];
assign local_dout[ 63: 60] = (red_shift_en && (red_data >= 6'd15)) ? temp[ 63: 60] : temp[ 67: 64];
assign local_dout[ 67: 64] = (red_shift_en && (red_data >= 6'd16)) ? temp[ 67: 64] : temp[ 71: 68];
assign local_dout[ 71: 68] = (red_shift_en && (red_data >= 6'd17)) ? temp[ 71: 68] : temp[ 75: 72];
assign local_dout[ 75: 72] = (red_shift_en && (red_data >= 6'd18)) ? temp[ 75: 72] : temp[ 79: 76];
assign local_dout[ 79: 76] = (red_shift_en && (red_data >= 6'd19)) ? temp[ 79: 76] : temp[ 83: 80];
assign local_dout[ 83: 80] = (red_shift_en && (red_data >= 6'd20)) ? temp[ 83: 80] : temp[ 87: 84];
assign local_dout[ 87: 84] = (red_shift_en && (red_data >= 6'd21)) ? temp[ 87: 84] : temp[ 91: 88];
assign local_dout[ 91: 88] = (red_shift_en && (red_data >= 6'd22)) ? temp[ 91: 88] : temp[ 95: 92];
assign local_dout[ 95: 92] = (red_shift_en && (red_data >= 6'd23)) ? temp[ 95: 92] : temp[ 99: 96];
assign local_dout[ 99: 96] = (red_shift_en && (red_data >= 6'd24)) ? temp[ 99: 96] : temp[103:100];
assign local_dout[103:100] = (red_shift_en && (red_data >= 6'd25)) ? temp[103:100] : temp[107:104];
assign local_dout[107:104] = (red_shift_en && (red_data >= 6'd26)) ? temp[107:104] : temp[111:108];
assign local_dout[111:108] = (red_shift_en && (red_data >= 6'd27)) ? temp[111:108] : temp[115:112];
assign local_dout[115:112] = (red_shift_en && (red_data >= 6'd28)) ? temp[115:112] : temp[119:116];
assign local_dout[119:116] = (red_shift_en && (red_data >= 6'd29)) ? temp[119:116] : temp[123:120];
assign local_dout[123:120] = (red_shift_en && (red_data >= 6'd30)) ? temp[123:120] : temp[127:124];
assign local_dout[127:124] = (red_shift_en && (red_data >= 6'd31)) ? temp[127:124] : temp[131:128];
assign local_dout[131:128] = (red_shift_en && (red_data >= 6'd32)) ? temp[131:128] : temp[135:132];
assign local_dout[135:132] = (red_shift_en && (red_data >= 6'd33)) ? temp[135:132] : temp[139:136];
assign local_dout[139:136] = (red_shift_en && (red_data >= 6'd34)) ? temp[139:136] : temp[143:140];
assign local_dout[143:140] = (red_shift_en && (red_data >= 6'd35)) ? temp[143:140] : temp[147:144];

//////////////////////
// Read array
//////////////////////
always @(posedge l1clk) begin
    if (rcs_l & vnw_ary) begin
        if (w0_wcs | w1_wcs | wr_inh_b)
            dout[143:0] <= 144'hx;
        else
            dout[143:0] <= local_dout[143:0];
    end
end

// Precharge
always @(negedge l1clk) begin
            dout[143:0] <= 144'h0;
end

//////////////////////////
// rd_data column mux 
//////////////////////////
assign w0_dout[35:0] = addr_b[3] ? 
{	dout[140], dout[136], dout[132], dout[128], dout[124], dout[120],
	dout[116], dout[112], dout[108], dout[104], dout[100], dout[96],
	dout[92], dout[88], dout[84], dout[80], dout[76], dout[72],
	dout[68], dout[64], dout[60], dout[56], dout[52], dout[48],
	dout[44], dout[40], dout[36], dout[32], dout[28], dout[24],
	dout[20], dout[16], dout[12], dout[8], dout[4], dout[0]} :
{	dout[141], dout[137], dout[133], dout[129], dout[125], dout[121],
	dout[117], dout[113], dout[109], dout[105], dout[101], dout[97],
	dout[93], dout[89], dout[85], dout[81], dout[77], dout[73],
	dout[69], dout[65], dout[61], dout[57], dout[53], dout[49],
	dout[45], dout[41], dout[37], dout[33], dout[29], dout[25],
	dout[21], dout[17], dout[13], dout[9], dout[5], dout[1]} ;

assign w1_dout[35:0] = addr_b[3] ? 
{	dout[142], dout[138], dout[134], dout[130], dout[126], dout[122],
	dout[118], dout[114], dout[110], dout[106], dout[102], dout[98],
	dout[94], dout[90], dout[86], dout[82], dout[78], dout[74],
	dout[70], dout[66], dout[62], dout[58], dout[54], dout[50],
	dout[46], dout[42], dout[38], dout[34], dout[30], dout[26],
	dout[22], dout[18], dout[14], dout[10], dout[6], dout[2]} :
{	dout[143], dout[139], dout[135], dout[131], dout[127], dout[123],
	dout[119], dout[115], dout[111], dout[107], dout[103], dout[99],
	dout[95], dout[91], dout[87], dout[83], dout[79], dout[75],
	dout[71], dout[67], dout[63], dout[59], dout[55], dout[51],
	dout[47], dout[43], dout[39], dout[35], dout[31], dout[27],
	dout[23], dout[19], dout[15], dout[11], dout[7], dout[3]} ;

// Need dual-rail at the outputs
always @(negedge l1clk or posedge wr_inh_b) begin
    if (wr_inh_b) begin
	w0_sao_h[35:0] <= 36'hx;
	w0_sao_l[35:0] <= 36'hx;
	w1_sao_h[35:0] <= 36'hx;
	w1_sao_l[35:0] <= 36'hx;
    end
    else begin
	w0_sao_h[35:0] <=  w0_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
	w0_sao_l[35:0] <= ~w0_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
	w1_sao_h[35:0] <=  w1_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
	w1_sao_l[35:0] <= ~w1_dout[35:0] & {36{(rd_en_a & ~wr_en_a)}};
    end
end
always @(posedge l1clk or negedge rd_en_a) begin
	w0_sao_h[35:0] <= 36'h0;
	w0_sao_l[35:0] <= 36'h0;
	w1_sao_h[35:0] <= 36'h0;
	w1_sao_l[35:0] <= 36'h0;
end

//////////////////////////
// rd_data out mapping 
//////////////////////////
assign w0_rdata_h[35:0] = w0_sao_h[35:0] ;
assign w0_rdata_l[35:0] = w0_sao_l[35:0] ;
assign w1_rdata_h[35:0] = w1_sao_h[35:0] ;
assign w1_rdata_l[35:0] = w1_sao_l[35:0] ;


supply0 vss;
supply1 vdd;

// synopsys translate_on

endmodule

//////////////////////////////////////////
////// n2_com_dp_32x152_cust
//////////////////////////////////////////

module n2_com_dp_32x152_cust_n2_com_array_macro__rows_32__width_152__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[152-1:0]	din;
output	[152-1:0]	dout; 



reg	[152-1:0]	mem[32-1:0];
reg	[152-1:0]	local_dout;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
 for (i=0; i<32; i=i+1) begin
   mem[i] = 152'b0;
 end
 local_dout = 152'b0;
end
`endif
//////////////////////
// Read/write array
//////////////////////
always @(negedge wclk) begin
   if (wr_en) begin
       mem[wr_adr] <= din;


   end
end
always @(rclk or rd_en or wr_en or rd_adr or wr_adr) begin
   if (rclk) begin
     if (rd_en) begin
         if (wr_en & (wr_adr[4:0] == rd_adr[4:0]))
             local_dout[152-1:0] <= 152'hx;
         else
             local_dout[152-1:0] <= mem[rd_adr] ;
     end
     else
             local_dout[152-1:0] <= ~(152'h0);
  end
end
assign dout[152-1:0] = local_dout[152-1:0];
supply0 vss;
supply1 vdd;




endmodule

//////////////////////////////////////////
////// n2_dta_sp_1920b_cust
//////////////////////////////////////////

module n2_dta_sp_1920b_array (
  clk, 
  rd_en_b, 
  wr_en_b, 
  rd_en_a, 
  wr_en_a, 
  addr, 
  wr_inhibit, 
  din, 
  dout);
wire rd_en_b_unused;
	

input			clk;
input	     		rd_en_b;	// comes on negedge
input	     		wr_en_b;	// comes on negedge (way specific)
input	     		rd_en_a;	// comes on posedge
input	     		wr_en_a;	// comes on posedge (not way specific)
input	[7-1:0]	addr;		// comes on negedge
input			wr_inhibit;	// async

input	[30-1:0]	din;		// comes on posedge
output	[30-1:0]	dout;








reg	[30-1:0]	mem[128-1:0];
reg	[30-1:0]	local_dout;

assign rd_en_b_unused = rd_en_b;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<128; i=i+1) begin
    mem[i] = {30{1'b0}}; 
  end
  local_dout = {30{1'b0}};
end
`endif

//////////////////////
// Read/write array
//////////////////////

always @(negedge clk) begin
    if (wr_en_b) begin
        mem[addr] <= din;



    end
end

always @(posedge clk) begin
    local_dout[30-1:0] <= mem[addr];
end

assign dout[30-1:0] = local_dout[30-1:0] & {30{rd_en_a & ~wr_en_a & ~wr_inhibit}};

supply0 vss;
supply1 vdd;


endmodule


//////////////////////////////////////////
////// n2_com_dp_64x84_cust
//////////////////////////////////////////

module n2_com_dp_64x84_cust_n2_com_array_macro__rows_64__width_84__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[5:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[5:0]	wr_adr;
input	[84-1:0]	din;
output	[84-1:0]	dout; 



reg	[84-1:0]	mem[64-1:0];
reg	[84-1:0]	local_dout;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
 for (i=0; i<64; i=i+1) begin
   mem[i] = 84'b0;
 end
 local_dout = 84'b0;
end
`endif
//////////////////////
// Read/write array
//////////////////////
always @(negedge wclk) begin
   if (wr_en) begin
       mem[wr_adr] <= din;


   end
end
always @(rclk or rd_en or wr_en or rd_adr or wr_adr) begin
   if (rclk) begin
     if (rd_en) begin
         if (wr_en & (wr_adr[5:0] == rd_adr[5:0]))
             local_dout[84-1:0] <= 84'hx;
         else
             local_dout[84-1:0] <= mem[rd_adr] ;
     end
     else
             local_dout[84-1:0] <= ~(84'h0);
  end
end
assign dout[84-1:0] = local_dout[84-1:0];
supply0 vss;
supply1 vdd;




endmodule 


//////////////////////////////////////////
////// n2_stb_cm_64x45_cust
//////////////////////////////////////////

`ifndef FPGA
module n2_stb_cm_64x45_array (
  cam_rw_ptr, 
  cam_rw_tid, 
  wptr_vld, 
  rptr_vld, 
  camwr_data, 
  cam_vld, 
  cam_cm_tid, 
  cam_line_en, 
  cam_ldq, 
  stb_rdata, 
  stb_ld_partial_raw, 
  stb_cam_hit_ptr, 
  stb_cam_hit, 
  stb_cam_mhit, 
  clk, 
  tcu_array_wr_inhibit, 
  siclk);
wire [5:0] rw_addr;
wire write_vld;
wire read_vld;
wire [7:0] byte_overlap_mx;
wire [7:0] byte_match_mx;
wire [7:0] ptag_hit_mx;
wire [7:0] cam_hit;


input	[2:0]	cam_rw_ptr ;	// wr pointer for single port.
input	[2:0]	cam_rw_tid ;	// thread id for rw.
input		wptr_vld ;	// write pointer vld
input		rptr_vld ;	// read pointer vld

input	[44:0]	camwr_data ;	// data for compare/write
input		cam_vld ;	// cam is required.
input	[2:0]	cam_cm_tid ;	// thread id for cam operation.
input	[7:0]	cam_line_en;	// mask for squashing cam results (unflopped input)

input		cam_ldq ; 	// quad-ld cam.


output	[44:0]	stb_rdata;	// rd data from CAM RAM.
output		stb_ld_partial_raw ; // ld with partial raw.
output	[2:0]	stb_cam_hit_ptr ;
output		stb_cam_hit ;	  // any hit in stb
output		stb_cam_mhit ;	  // multiple hits in stb	

input		clk;
input		tcu_array_wr_inhibit;
input		siclk;

integer	i,l;

///////////////////////////////////////////////////////////////
// The array
///////////////////////////////////////////////////////////////

reg	[44:0]	stb_ramc[63:0];
reg	[44:0]	stb_rdata;

//=========================================================================================
//	initialize array
//=========================================================================================

`ifndef NOINITMEM
initial begin
  for (i=0;i<64;i=i+1) begin
  stb_ramc[i] =  45'd0;
  end
end
`endif

assign rw_addr[5:0] = {cam_rw_tid[2:0],cam_rw_ptr[2:0]};

assign write_vld = wptr_vld & ~tcu_array_wr_inhibit;
assign read_vld  = rptr_vld & ~tcu_array_wr_inhibit;

///////////
// Write
///////////
always @ (clk or write_vld or rw_addr or camwr_data or cam_vld) begin
    if (clk & write_vld) begin
        if (cam_vld)
            stb_ramc[rw_addr] <= 45'hx;
	else
            stb_ramc[rw_addr] <= camwr_data[44:0];
    end
end




///////////
// Read
///////////

always @(clk or read_vld or rw_addr or write_vld) begin
    if (clk) begin
	if (write_vld | ~read_vld)
		stb_rdata[44:0] <= 45'hx;
	else
		stb_rdata[44:0] <= stb_ramc[rw_addr];
    end
end

//=========================================================================================
//	CAM contents
//=========================================================================================

// - Generate full/partial raw for incoming load.
// - Output signals need to be qualified with per entry
// vlds before causing any subsequent event, the read of
// the DATA RAM specifically.

// Mapping of cam/write data
// 
//	| 	39-3=37b(pa)	|	8b(bytemask)	| <- use
//	|	44:8		|	7:0		| <- input port

reg	[44:0]	ramc_entry;
reg	[36:0]	cam_tag;
reg	[7:0]	cam_bmask;
reg	[63:0]	ptag_hit;
reg	[63:0]	byte_match;
reg	[63:0]	byte_overlap;

// ptag_hit indicates a match at the dword (or qword for quad loads) boundary
// byte_match indciates match at the byte level within the dword
// byte_overlap checks that all bytes in incoming bmask has a corresponding mask bit
//  set in the cam entry.  This differentiates between full and partial raw.

always @(posedge clk) begin
  for (l=0;l<64;l=l+1) begin
    ramc_entry[44:0] = stb_ramc[l] ;
    cam_tag[36:0] = ramc_entry[44:8] ;
    cam_bmask[7:0] = ramc_entry[7:0] ;
    ptag_hit[l] <= (cam_tag[36:1] == camwr_data[44:9]) & (((cam_tag[0] == camwr_data[8]) & ~cam_ldq) | cam_ldq) & cam_vld;
    byte_match[l] <= |(cam_bmask[7:0] & camwr_data[7:0]) & cam_vld;
    byte_overlap[l] <= |(~cam_bmask[7:0] & camwr_data[7:0]) & cam_vld ;
  end	
end

// CAM values will be indeterminate while scanning

always @(posedge siclk) begin
    ptag_hit[63:0] <= 64'hx; 
    byte_match[63:0] <= 64'hx; 
    byte_overlap[63:0] <= 64'hx; 
end


// Mux the raw signals down to 8b quantities. Line enable comes mid-way thru cycle.

assign	byte_overlap_mx[7:0] =
	({8{(cam_cm_tid[2:0] == 3'b000)}} & byte_overlap[7:0]  ) | 
	({8{(cam_cm_tid[2:0] == 3'b001)}} & byte_overlap[15:8] ) |
	({8{(cam_cm_tid[2:0] == 3'b010)}} & byte_overlap[23:16]) |
	({8{(cam_cm_tid[2:0] == 3'b011)}} & byte_overlap[31:24]) |
	({8{(cam_cm_tid[2:0] == 3'b100)}} & byte_overlap[39:32]) |
	({8{(cam_cm_tid[2:0] == 3'b101)}} & byte_overlap[47:40]) |
	({8{(cam_cm_tid[2:0] == 3'b110)}} & byte_overlap[55:48]) |
	({8{(cam_cm_tid[2:0] == 3'b111)}} & byte_overlap[63:56]) ;

assign	byte_match_mx[7:0] =
	({8{(cam_cm_tid[2:0] == 3'b000)}} & byte_match[7:0]  ) |
	({8{(cam_cm_tid[2:0] == 3'b001)}} & byte_match[15:8] ) |
	({8{(cam_cm_tid[2:0] == 3'b010)}} & byte_match[23:16]) |
	({8{(cam_cm_tid[2:0] == 3'b011)}} & byte_match[31:24]) |
	({8{(cam_cm_tid[2:0] == 3'b100)}} & byte_match[39:32]) |
	({8{(cam_cm_tid[2:0] == 3'b101)}} & byte_match[47:40]) |
	({8{(cam_cm_tid[2:0] == 3'b110)}} & byte_match[55:48]) |
	({8{(cam_cm_tid[2:0] == 3'b111)}} & byte_match[63:56]) ;

assign	ptag_hit_mx[7:0] =
	({8{(cam_cm_tid[2:0] == 3'b000)}} & ptag_hit[7:0]  ) |
	({8{(cam_cm_tid[2:0] == 3'b001)}} & ptag_hit[15:8] ) |
	({8{(cam_cm_tid[2:0] == 3'b010)}} & ptag_hit[23:16]) |
	({8{(cam_cm_tid[2:0] == 3'b011)}} & ptag_hit[31:24]) |
	({8{(cam_cm_tid[2:0] == 3'b100)}} & ptag_hit[39:32]) |
	({8{(cam_cm_tid[2:0] == 3'b101)}} & ptag_hit[47:40]) |
	({8{(cam_cm_tid[2:0] == 3'b110)}} & ptag_hit[55:48]) |
	({8{(cam_cm_tid[2:0] == 3'b111)}} & ptag_hit[63:56]) ;

assign	stb_ld_partial_raw =  
	|(ptag_hit_mx[7:0] & byte_match_mx[7:0] &  byte_overlap_mx[7:0] & cam_line_en[7:0]) ;

assign	cam_hit[7:0] = 
	ptag_hit_mx[7:0] & byte_match_mx[7:0] & cam_line_en[7:0] ;
assign	stb_cam_hit = |(cam_hit[7:0]);

// The stb data is meant to be read for single hit full raw case. It may actually be read
// for full raw, partial raw or multiple hit case but the read output will be ignored for
// partial and multiple hit case. Multiple hits will not cause a hazard as the ptr is first
// encoded and then decoded to form the wdline for the stb-data
// Use cam_hit result to void false hits.
assign	stb_cam_hit_ptr[0] 	=  cam_hit[1] | cam_hit[3] | cam_hit[5] | cam_hit[7] ;
assign	stb_cam_hit_ptr[1] 	=  cam_hit[2] | cam_hit[3] | cam_hit[6] | cam_hit[7] ;
assign	stb_cam_hit_ptr[2] 	=  cam_hit[4] | cam_hit[5] | cam_hit[6] | cam_hit[7] ;

//Generating multiple hits
assign  stb_cam_mhit            =  (cam_hit[0]  & cam_hit[1]) | (cam_hit[2] & cam_hit[3])  |
                                   (cam_hit[4]  & cam_hit[5]) | (cam_hit[6] & cam_hit[7])  |
                                   ((cam_hit[0] | cam_hit[1]) & (cam_hit[2] | cam_hit[3])) |
                                   ((cam_hit[4] | cam_hit[5]) & (cam_hit[6] | cam_hit[7])) |
                                   ((|cam_hit[3:0]) & (|cam_hit[7:4]));

supply0 vss;
supply1 vdd;
endmodule
`endif

//////////////////////////////////////////
////// n2_com_dp_32x72_cust
//////////////////////////////////////////

module n2_com_dp_32x72_cust_n2_com_array_macro__rows_32__width_72__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[72-1:0]	din;
output	[72-1:0]	dout; 



reg	[72-1:0]	mem[32-1:0];
reg	[72-1:0]	local_dout;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
 for (i=0; i<32; i=i+1) begin
   mem[i] = 72'b0;
 end
 local_dout = 72'b0;
end
`endif
//////////////////////
// Read/write array
//////////////////////
always @(negedge wclk) begin
   if (wr_en) begin
       mem[wr_adr] <= din;


   end
end
always @(rclk or rd_en or wr_en or rd_adr or wr_adr) begin
   if (rclk) begin
     if (rd_en) begin
         if (wr_en & (wr_adr[4:0] == rd_adr[4:0]))
             local_dout[72-1:0] <= 72'hx;
         else
             local_dout[72-1:0] <= mem[rd_adr] ;
     end
     else
             local_dout[72-1:0] <= ~(72'h0);
  end
end
assign dout[72-1:0] = local_dout[72-1:0];
supply0 vss;
supply1 vdd;




endmodule


//////////////////////////////////////////
////// n2_com_dp_32x84_cust
//////////////////////////////////////////

module n2_com_dp_32x84_cust_n2_com_array_macro__rows_32__width_84__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[84-1:0]	din;
output	[84-1:0]	dout; 



reg	[84-1:0]	mem[32-1:0];
reg	[84-1:0]	local_dout;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
 for (i=0; i<32; i=i+1) begin
   mem[i] = 84'b0;
 end
 local_dout = 84'b0;
end
`endif
//////////////////////
// Read/write array
//////////////////////
always @(negedge wclk) begin
   if (wr_en) begin
       mem[wr_adr] <= din;


   end
end
always @(rclk or rd_en or wr_en or rd_adr or wr_adr) begin
   if (rclk) begin
     if (rd_en) begin
         if (wr_en & (wr_adr[4:0] == rd_adr[4:0]))
             local_dout[84-1:0] <= 84'hx;
         else
             local_dout[84-1:0] <= mem[rd_adr] ;
     end
     else
             local_dout[84-1:0] <= ~(84'h0);
  end
end
assign dout[84-1:0] = local_dout[84-1:0];
supply0 vss;
supply1 vdd;




endmodule 

//////////////////////////////////////////
////// n2_tlb_tl_64x59_cust
//////////////////////////////////////////

`ifndef FPGA
module n2_tlb_tl_64x59_cam (
  l1clk, 
  tlb_bypass, 
  tlb_wr_flopped, 
  tlb_rd_flopped, 
  rw_index, 
  tlb_cam, 
  tlb_cam_flopped, 
  demap, 
  demap_context, 
  demap_all, 
  demap_real, 
  tte_tag, 
  tte_tag_flopped, 
  tte_page_size_mask, 
  tag_read_mux_control, 
  tlb_cam_hit, 
  context0_hit, 
  rd_tte_tag, 
  ram_wwl, 
  ram_rwl, 
  valid) ;
wire [6:0] rw_index_to_decode;
wire [127:0] decoded_index;
wire [127:64] decoded_index_unused;





input		l1clk;

input		tlb_bypass;
input		tlb_wr_flopped;
input		tlb_rd_flopped;
input	[5:0] rw_index;
input		tlb_cam;
input		tlb_cam_flopped;
input		demap;
input		demap_context;
input		demap_all;
input		demap_real;

input	[65:0]	tte_tag;
input	[65:0]	tte_tag_flopped;
input	[2:0]	tte_page_size_mask;

input 		tag_read_mux_control;



output		tlb_cam_hit;
output		context0_hit;
output	[65:0]	rd_tte_tag;
output	[64-1:0] ram_wwl;
output	[64-1:0] ram_rwl;
output	[64-1:0] valid;



`define CNTX1_HI 65
`define CNTX1_LO 53
`define PID_HI   52
`define PID_LO   50
`define REAL_BIT 49
`define VA_47    48
`define VA_28    29
`define VA_27    28
`define VA_22    23
`define TTE_VALID 22 
`define VA_21    21
`define VA_16    16
`define VA_15    15 
`define VA_13    13
`define CNTX0_HI 12
`define CNTX0_LO  0



//----------------------------------------------------------------------
// Declarations
//----------------------------------------------------------------------

// local signals

reg 	[12:0] 	context_a	[64-1:0];  // Contexts a and b are
reg 	[12:0] 	context_a_	[64-1:0];  // to be equal at all times
reg 	[12:0] 	context_b	[64-1:0];  // This is NOT context 0 and 1
reg 	[12:0] 	context_b_	[64-1:0];  // This is NOT primary/secondary
reg        	r_bit		[64-1:0];
reg        	r_bit_		[64-1:0];
reg     [47:28] va_47_28	[64-1:0];
reg     [47:28] va_47_28_	[64-1:0];
reg     [27:22] va_27_22	[64-1:0];
reg     [27:22] va_27_22_	[64-1:0];
reg     [21:16] va_21_16	[64-1:0];
reg     [21:16] va_21_16_	[64-1:0];
reg     [15:13] va_15_13	[64-1:0];
reg     [15:13] va_15_13_	[64-1:0];
reg	[2:0]	pid		[64-1:0];
reg	[2:0]	pid_		[64-1:0];
reg 	[64-1:0]	valid;
reg 	[64-1:0]	match_for_sat;
reg 			tlb_cam_hit;
reg 			context0_hit;

integer n;
reg [31:0] n_reg;

reg [64-1:0] va_47_28_match ;
reg [64-1:0] va_27_22_match ;
reg [64-1:0] va_21_16_match ;
reg [64-1:0] va_15_13_match ;
reg [64-1:0] pid_match      ;
reg [64-1:0] real_match     ;
reg [64-1:0] context0_match ;
reg [64-1:0] context1_match ;
reg [64-1:0] context_match  ;
reg [64-1:0] match          ;
reg [64-1:0] ram_wl         ;
reg [65:0] rd_tte_tag;
reg [12:0] a_xnor_tag;
reg [12:0] b_xnor_tag;

reg 	   demap_posedge_l1clk;



`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
initial begin
	for (n = 0; n < 64; n = n+1) begin
		context_a	[n] = {13 {1'b0}};
		context_a_	[n] = {13 {1'b1}};
		context_b	[n] = {13 {1'b0}};
		context_b_	[n] = {13 {1'b1}};
		r_bit		[n] = { 1 {1'b0}};
		r_bit_		[n] = { 1 {1'b1}};
		va_47_28	[n] = {20 {1'b0}};
		va_47_28_	[n] = {20 {1'b1}};
		va_27_22	[n] = { 6 {1'b0}};
		va_27_22_	[n] = { 6 {1'b1}};
		va_21_16	[n] = { 6 {1'b0}};
		va_21_16_	[n] = { 6 {1'b1}};
		va_15_13	[n] = { 3 {1'b0}};
		va_15_13_	[n] = { 3 {1'b1}};
		pid		[n] = { 3 {1'b0}};
		pid_		[n] = { 3 {1'b1}};
		valid		[n] = { 1 {1'b0}};
	end // for (n = 0; n < 64; n = n+1)
end
`endif



///////////////////////////////////////////////////////////////
// CAM, read
///////////////////////////////////////////////////////////////
always @(posedge l1clk) begin

	demap_posedge_l1clk = demap;
	
	match[64-1:0] = {64 {1'b0}};

	if (tlb_cam | demap) begin
		for (n = 0; n < 64; n = n + 1) begin
			// Have to represent dual match line architecture...
			// LSB 2 bits of context must both match AND MSB 11 bits must not mismatch
			a_xnor_tag[12:0] =       (context_a	[n] &  tte_tag[`CNTX1_HI:`CNTX1_LO]) |
						 (context_a_	[n] & ~tte_tag[`CNTX1_HI:`CNTX1_LO]) ;
			b_xnor_tag[12:0] =       (context_b	[n] &  tte_tag[`CNTX0_HI:`CNTX0_LO]) |
						 (context_b_	[n] & ~tte_tag[`CNTX0_HI:`CNTX0_LO]) ;
			context1_match[n] = demap_all | demap_real | 
					    (& a_xnor_tag[1:0]) & 
					    (~(| {context_a	[n] & ~tte_tag[`CNTX1_HI:`CNTX1_LO] & 13'h1ffc,
						  context_a_	[n] &  tte_tag[`CNTX1_HI:`CNTX1_LO] & 13'h1ffc}));
			context0_match[n] = demap_all | demap_real |
					    (& b_xnor_tag[1:0]) & 
					    (~(| {context_b	[n] & ~tte_tag[`CNTX0_HI:`CNTX0_LO] & 13'h1ffc,
						  context_b_	[n] &  tte_tag[`CNTX0_HI:`CNTX0_LO] & 13'h1ffc}));
			pid_match[n]      = (~(| {pid		[n] & ~tte_tag[`PID_HI	:`PID_LO  ],
						  pid_		[n] &  tte_tag[`PID_HI	:`PID_LO  ]}));
			real_match[n]     = demap_all | 
					    (~(| {r_bit		[n] & ~tte_tag[`REAL_BIT	  ],
						  r_bit_	[n] &  tte_tag[`REAL_BIT	  ]}));
			va_47_28_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_47_28	[n] & ~tte_tag[`VA_47	:`VA_28   ],
						  va_47_28_	[n] &  tte_tag[`VA_47	:`VA_28   ]}));
			va_27_22_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_27_22	[n] & ~tte_tag[`VA_27	:`VA_22   ],
						  va_27_22_	[n] &  tte_tag[`VA_27	:`VA_22   ]}));
			va_21_16_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_21_16	[n] & ~tte_tag[`VA_21	:`VA_16   ],
						  va_21_16_	[n] &  tte_tag[`VA_21	:`VA_16   ]}));
			va_15_13_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_15_13	[n] & ~tte_tag[`VA_15	:`VA_13   ],
						  va_15_13_	[n] &  tte_tag[`VA_15	:`VA_13   ]}));

			context_match[n]  = context0_match[n] | context1_match[n];
			
			match[n] = va_47_28_match[n] & va_27_22_match[n] & va_21_16_match[n] & 
				   va_15_13_match[n] & pid_match[n] & real_match[n] & context_match[n] &
				   valid[n];

		end // for (n = 0; n < 64; n = n + 1)
		
		
	end // if (tlb_cam | demap)
	

		
	ram_wl[64-1:0] <= match[64-1:0];
	
end // always @ (posedge l1clk)



///////////////////////////////////////////////////////////////
// Demap, Write, Read
///////////////////////////////////////////////////////////////
always @(negedge l1clk) begin

	// Demap
	if (demap) begin	
		for (n = 0; n < 64; n = n + 1) begin
			if (match[n]) begin
				valid[n] <= 1'b0;
			end
		end
	end // if (demap)	

	// Write
	if (tlb_wr_flopped) begin

		for (n = 0; n < 64; n = n + 1) begin
			if (ram_wwl[n]) begin
				context_a	[n] <=( tte_tag_flopped[`CNTX1_HI:`CNTX1_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				context_a_	[n] <=(~tte_tag_flopped[`CNTX1_HI:`CNTX1_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				pid		[n] <=  tte_tag_flopped[`PID_HI  :`PID_LO  ];
				pid_		[n] <= ~tte_tag_flopped[`PID_HI  :`PID_LO  ];
				r_bit		[n] <=  tte_tag_flopped[`REAL_BIT          ];
				r_bit_		[n] <= ~tte_tag_flopped[`REAL_BIT          ];
				va_47_28	[n] <=  tte_tag_flopped[`VA_47   :`VA_28   ];
				va_47_28_	[n] <= ~tte_tag_flopped[`VA_47   :`VA_28   ];
				va_27_22	[n] <=  tte_tag_flopped[`VA_27   :`VA_22   ] & { 6 {~tte_page_size_mask[2]}};
				va_27_22_	[n] <= ~tte_tag_flopped[`VA_27   :`VA_22   ] & { 6 {~tte_page_size_mask[2]}};
				va_21_16	[n] <=  tte_tag_flopped[`VA_21   :`VA_16   ] & { 6 {~tte_page_size_mask[1]}};
				va_21_16_	[n] <= ~tte_tag_flopped[`VA_21   :`VA_16   ] & { 6 {~tte_page_size_mask[1]}};
				va_15_13	[n] <=  tte_tag_flopped[`VA_15   :`VA_13   ] & { 3 {~tte_page_size_mask[0]}};
				va_15_13_	[n] <= ~tte_tag_flopped[`VA_15   :`VA_13   ] & { 3 {~tte_page_size_mask[0]}};
				context_b	[n] <=( tte_tag_flopped[`CNTX0_HI:`CNTX0_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				context_b_	[n] <=(~tte_tag_flopped[`CNTX0_HI:`CNTX0_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				valid 		[n] <=  tte_tag_flopped[`TTE_VALID         ];

				
				
					
			end // if (ram_wwl[n])
		end // for (n = 0; n < 64; n = n + 1)
		
	end // if (tlb_wr_flopped)

	// Read	
	if (tlb_rd_flopped) begin
		if (tag_read_mux_control) begin
			rd_tte_tag[`CNTX1_HI:`CNTX1_LO] <= context_a_	[rw_index[5:0]];
			rd_tte_tag[`PID_HI  :`PID_LO  ] <= pid_		[rw_index[5:0]];
			rd_tte_tag[`REAL_BIT          ] <= r_bit_	[rw_index[5:0]];
			rd_tte_tag[`VA_47   :`VA_28   ] <= va_47_28_	[rw_index[5:0]];
			rd_tte_tag[`VA_27   :`VA_22   ] <= va_27_22_	[rw_index[5:0]];
			rd_tte_tag[`VA_21   :`VA_16   ] <= va_21_16_	[rw_index[5:0]];
			rd_tte_tag[`VA_15   :`VA_13   ] <= va_15_13_	[rw_index[5:0]];
			rd_tte_tag[`CNTX0_HI:`CNTX0_LO] <= context_b_	[rw_index[5:0]];
		end // if (tag_read_mux_control)
		else begin
			rd_tte_tag[`CNTX1_HI:`CNTX1_LO] <= context_a	[rw_index[5:0]];
			rd_tte_tag[`PID_HI  :`PID_LO  ] <= pid		[rw_index[5:0]];
			rd_tte_tag[`REAL_BIT          ] <= r_bit	[rw_index[5:0]];
			rd_tte_tag[`VA_47   :`VA_28   ] <= va_47_28	[rw_index[5:0]];
			rd_tte_tag[`VA_27   :`VA_22   ] <= va_27_22	[rw_index[5:0]];
			rd_tte_tag[`VA_21   :`VA_16   ] <= va_21_16	[rw_index[5:0]];
			rd_tte_tag[`VA_15   :`VA_13   ] <= va_15_13	[rw_index[5:0]];
			rd_tte_tag[`CNTX0_HI:`CNTX0_LO] <= context_b	[rw_index[5:0]];
		end // else: !if(tag_read_mux_control)
		rd_tte_tag[`TTE_VALID         ] <= valid	[rw_index[5:0]];
	end // if (tlb_rd
	else begin
	        rd_tte_tag[65:0] <= {66 {1'b0}} ;
	end // else: !if(tlb_rd)

end // always @ (negedge l1clk)



///////////////////////////////////////////////////////////////
// Output assignments
///////////////////////////////////////////////////////////////
// Have to hold them to next clock edge

// Read and write address decode
assign rw_index_to_decode[6:0] =
	{1'b0,
//	{rw_index[6],
	rw_index[5:0]};

assign decoded_index[127:0] = 
	{(rw_index_to_decode[6:0] == 7'h7f),
	 (rw_index_to_decode[6:0] == 7'h7e),
	 (rw_index_to_decode[6:0] == 7'h7d),
	 (rw_index_to_decode[6:0] == 7'h7c),
	 (rw_index_to_decode[6:0] == 7'h7b),
	 (rw_index_to_decode[6:0] == 7'h7a),
	 (rw_index_to_decode[6:0] == 7'h79),
	 (rw_index_to_decode[6:0] == 7'h78),
	 (rw_index_to_decode[6:0] == 7'h77),
	 (rw_index_to_decode[6:0] == 7'h76),
	 (rw_index_to_decode[6:0] == 7'h75),
	 (rw_index_to_decode[6:0] == 7'h74),
	 (rw_index_to_decode[6:0] == 7'h73),
	 (rw_index_to_decode[6:0] == 7'h72),
	 (rw_index_to_decode[6:0] == 7'h71),
	 (rw_index_to_decode[6:0] == 7'h70),
	 (rw_index_to_decode[6:0] == 7'h6f),
	 (rw_index_to_decode[6:0] == 7'h6e),
	 (rw_index_to_decode[6:0] == 7'h6d),
	 (rw_index_to_decode[6:0] == 7'h6c),
	 (rw_index_to_decode[6:0] == 7'h6b),
	 (rw_index_to_decode[6:0] == 7'h6a),
	 (rw_index_to_decode[6:0] == 7'h69),
	 (rw_index_to_decode[6:0] == 7'h68),
	 (rw_index_to_decode[6:0] == 7'h67),
	 (rw_index_to_decode[6:0] == 7'h66),
	 (rw_index_to_decode[6:0] == 7'h65),
	 (rw_index_to_decode[6:0] == 7'h64),
	 (rw_index_to_decode[6:0] == 7'h63),
	 (rw_index_to_decode[6:0] == 7'h62),
	 (rw_index_to_decode[6:0] == 7'h61),
	 (rw_index_to_decode[6:0] == 7'h60),
	 (rw_index_to_decode[6:0] == 7'h5f),
	 (rw_index_to_decode[6:0] == 7'h5e),
	 (rw_index_to_decode[6:0] == 7'h5d),
	 (rw_index_to_decode[6:0] == 7'h5c),
	 (rw_index_to_decode[6:0] == 7'h5b),
	 (rw_index_to_decode[6:0] == 7'h5a),
	 (rw_index_to_decode[6:0] == 7'h59),
	 (rw_index_to_decode[6:0] == 7'h58),
	 (rw_index_to_decode[6:0] == 7'h57),
	 (rw_index_to_decode[6:0] == 7'h56),
	 (rw_index_to_decode[6:0] == 7'h55),
	 (rw_index_to_decode[6:0] == 7'h54),
	 (rw_index_to_decode[6:0] == 7'h53),
	 (rw_index_to_decode[6:0] == 7'h52),
	 (rw_index_to_decode[6:0] == 7'h51),
	 (rw_index_to_decode[6:0] == 7'h50),
	 (rw_index_to_decode[6:0] == 7'h4f),
	 (rw_index_to_decode[6:0] == 7'h4e),
	 (rw_index_to_decode[6:0] == 7'h4d),
	 (rw_index_to_decode[6:0] == 7'h4c),
	 (rw_index_to_decode[6:0] == 7'h4b),
	 (rw_index_to_decode[6:0] == 7'h4a),
	 (rw_index_to_decode[6:0] == 7'h49),
	 (rw_index_to_decode[6:0] == 7'h48),
	 (rw_index_to_decode[6:0] == 7'h47),
	 (rw_index_to_decode[6:0] == 7'h46),
	 (rw_index_to_decode[6:0] == 7'h45),
	 (rw_index_to_decode[6:0] == 7'h44),
	 (rw_index_to_decode[6:0] == 7'h43),
	 (rw_index_to_decode[6:0] == 7'h42),
	 (rw_index_to_decode[6:0] == 7'h41),
	 (rw_index_to_decode[6:0] == 7'h40),
	 (rw_index_to_decode[6:0] == 7'h3f),
	 (rw_index_to_decode[6:0] == 7'h3e),
	 (rw_index_to_decode[6:0] == 7'h3d),
	 (rw_index_to_decode[6:0] == 7'h3c),
	 (rw_index_to_decode[6:0] == 7'h3b),
	 (rw_index_to_decode[6:0] == 7'h3a),
	 (rw_index_to_decode[6:0] == 7'h39),
	 (rw_index_to_decode[6:0] == 7'h38),
	 (rw_index_to_decode[6:0] == 7'h37),
	 (rw_index_to_decode[6:0] == 7'h36),
	 (rw_index_to_decode[6:0] == 7'h35),
	 (rw_index_to_decode[6:0] == 7'h34),
	 (rw_index_to_decode[6:0] == 7'h33),
	 (rw_index_to_decode[6:0] == 7'h32),
	 (rw_index_to_decode[6:0] == 7'h31),
	 (rw_index_to_decode[6:0] == 7'h30),
	 (rw_index_to_decode[6:0] == 7'h2f),
	 (rw_index_to_decode[6:0] == 7'h2e),
	 (rw_index_to_decode[6:0] == 7'h2d),
	 (rw_index_to_decode[6:0] == 7'h2c),
	 (rw_index_to_decode[6:0] == 7'h2b),
	 (rw_index_to_decode[6:0] == 7'h2a),
	 (rw_index_to_decode[6:0] == 7'h29),
	 (rw_index_to_decode[6:0] == 7'h28),
	 (rw_index_to_decode[6:0] == 7'h27),
	 (rw_index_to_decode[6:0] == 7'h26),
	 (rw_index_to_decode[6:0] == 7'h25),
	 (rw_index_to_decode[6:0] == 7'h24),
	 (rw_index_to_decode[6:0] == 7'h23),
	 (rw_index_to_decode[6:0] == 7'h22),
	 (rw_index_to_decode[6:0] == 7'h21),
	 (rw_index_to_decode[6:0] == 7'h20),
	 (rw_index_to_decode[6:0] == 7'h1f),
	 (rw_index_to_decode[6:0] == 7'h1e),
	 (rw_index_to_decode[6:0] == 7'h1d),
	 (rw_index_to_decode[6:0] == 7'h1c),
	 (rw_index_to_decode[6:0] == 7'h1b),
	 (rw_index_to_decode[6:0] == 7'h1a),
	 (rw_index_to_decode[6:0] == 7'h19),
	 (rw_index_to_decode[6:0] == 7'h18),
	 (rw_index_to_decode[6:0] == 7'h17),
	 (rw_index_to_decode[6:0] == 7'h16),
	 (rw_index_to_decode[6:0] == 7'h15),
	 (rw_index_to_decode[6:0] == 7'h14),
	 (rw_index_to_decode[6:0] == 7'h13),
	 (rw_index_to_decode[6:0] == 7'h12),
	 (rw_index_to_decode[6:0] == 7'h11),
	 (rw_index_to_decode[6:0] == 7'h10),
	 (rw_index_to_decode[6:0] == 7'h0f),
	 (rw_index_to_decode[6:0] == 7'h0e),
	 (rw_index_to_decode[6:0] == 7'h0d),
	 (rw_index_to_decode[6:0] == 7'h0c),
	 (rw_index_to_decode[6:0] == 7'h0b),
	 (rw_index_to_decode[6:0] == 7'h0a),
	 (rw_index_to_decode[6:0] == 7'h09),
	 (rw_index_to_decode[6:0] == 7'h08),
	 (rw_index_to_decode[6:0] == 7'h07),
	 (rw_index_to_decode[6:0] == 7'h06),
	 (rw_index_to_decode[6:0] == 7'h05),
	 (rw_index_to_decode[6:0] == 7'h04),
	 (rw_index_to_decode[6:0] == 7'h03),
	 (rw_index_to_decode[6:0] == 7'h02),
	 (rw_index_to_decode[6:0] == 7'h01),
	 (rw_index_to_decode[6:0] == 7'h00)};

assign decoded_index_unused[127:64] = decoded_index[127:64];

always @(negedge l1clk) begin
	match_for_sat[64-1:0] <= match[64-1:0]; // For MMU SAT
	tlb_cam_hit <= (| match[64-1:0]) | tlb_bypass | ~tlb_cam;
	context0_hit <= (|(match[64-1:0] & context0_match[64-1:0])) & ~demap_posedge_l1clk;
end // always @ (negedge l1clk)

assign ram_wwl[64-1:0] = 
       decoded_index[64-1:0] & {64 {tlb_wr_flopped}};

assign ram_rwl[64-1:0] = 
       (decoded_index[64-1:0] & {64 {tlb_rd_flopped }}) |
       (ram_wl       [64-1:0] & {64 {tlb_cam_flopped}});





supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
endmodule
`endif // `ifndef FPGA

`ifndef FPGA
module n2_tlb_tl_64x59_ram (
  l1clk, 
  tlb_bypass, 
  tlb_cam_flopped, 
  ram_wwl, 
  ram_rwl, 
  tte_data, 
  va, 
  pa, 
  rd_tte_data) ;
wire any_wwl;
wire any_rwl;
wire [37:0] prd_data;
wire [39:13] tte_pa;





input		l1clk;

input		tlb_bypass;
input 		tlb_cam_flopped;
input	[64-1:0] ram_wwl;
input	[64-1:0] ram_rwl;

input	[37:0]	tte_data;
input	[39:11]	va;		// Incoming VA



output	[39:11]	pa;
output	[37:0]	rd_tte_data;



`define DATA_PARITY         36
`define DATA_PA_39_28_HI    35
`define DATA_PA_39_28_LO    24
`define DATA_PA_27_22_HI    23
`define DATA_PA_27_22_LO    18
`define DATA_VA_27_22_V     17 
`define DATA_PA_21_16_HI    16
`define DATA_PA_21_16_LO    11
`define DATA_VA_21_16_V     10 
`define DATA_PA_15_13_HI     9
`define DATA_PA_15_13_LO     7
`define DATA_VA_15_13_V      6 
`define DATA_NFO             5 
`define DATA_IE              4 
`define DATA_CP              3 
`define DATA_X               2 
`define DATA_P               1 
`define DATA_W               0 

assign any_wwl =
	| ram_wwl[64-1:0];

assign any_rwl =
	| ram_rwl[64-1:0];



	    
	    
	    
	    
	    
	    
	    
	    
	    

	    
	    
	    
	    
	    
	    
	    
	    
	    








//----------------------------------------------------------------------
// Declarations
//----------------------------------------------------------------------

reg [37:0]  tlb_data_[64-1:0] ;		// this models the data array
						// data stored negative active

integer n;

`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
initial begin
	for (n = 0; n < 64; n = n + 1) begin
		tlb_data_[n] = {38 {1'b1}};
	end
	`ifdef ENABLE_DUMPMEM
	if ($test$plusargs("DUMPMEM_DTLB")) begin
		$fsdbDumpMem(tlb_data_, 0, 64);
	end
	`endif
end
`endif





///////////////////////////////////////////////////////////////
// Write                                                     // 
///////////////////////////////////////////////////////////////
always @(negedge l1clk) begin

	for (n = 0; n < 64; n = n + 1) begin
		if (ram_wwl[n]) begin
			// data stored negative active
			tlb_data_[n] <= ~tte_data[37:0];
			
			
			
			
			n = 64;
			
		end // if (ram_wl[n])
	end // for (n = 0; n < 64; n = n + 1)
	
end // always @ (ram_wl[64-1:0])



///////////////////////////////////////////////////////////////
// Read                                                      // 
///////////////////////////////////////////////////////////////

// ram_rwl is now second half cycle signal... so no need to latch
// Only force outputs to X if read and write at same time
// Model multiple hit read accurately:
//    Whenever stored_data==0 is read from a bit by any of wordline,
//    dout is 0.
// Invert data since stored_data is negative active
assign prd_data[37:0] =
        ((~tlb_data_[0] & {38 {ram_rwl[0]}}) |
         (~tlb_data_[1] & {38 {ram_rwl[1]}}) |
         (~tlb_data_[2] & {38 {ram_rwl[2]}}) |
         (~tlb_data_[3] & {38 {ram_rwl[3]}}) |
         (~tlb_data_[4] & {38 {ram_rwl[4]}}) |
         (~tlb_data_[5] & {38 {ram_rwl[5]}}) |
         (~tlb_data_[6] & {38 {ram_rwl[6]}}) |
         (~tlb_data_[7] & {38 {ram_rwl[7]}}) |
         (~tlb_data_[8] & {38 {ram_rwl[8]}}) |
         (~tlb_data_[9] & {38 {ram_rwl[9]}}) |
         (~tlb_data_[10] & {38 {ram_rwl[10]}}) |
         (~tlb_data_[11] & {38 {ram_rwl[11]}}) |
         (~tlb_data_[12] & {38 {ram_rwl[12]}}) |
         (~tlb_data_[13] & {38 {ram_rwl[13]}}) |
         (~tlb_data_[14] & {38 {ram_rwl[14]}}) |
         (~tlb_data_[15] & {38 {ram_rwl[15]}}) |
         (~tlb_data_[16] & {38 {ram_rwl[16]}}) |
         (~tlb_data_[17] & {38 {ram_rwl[17]}}) |
         (~tlb_data_[18] & {38 {ram_rwl[18]}}) |
         (~tlb_data_[19] & {38 {ram_rwl[19]}}) |
         (~tlb_data_[20] & {38 {ram_rwl[20]}}) |
         (~tlb_data_[21] & {38 {ram_rwl[21]}}) |
         (~tlb_data_[22] & {38 {ram_rwl[22]}}) |
         (~tlb_data_[23] & {38 {ram_rwl[23]}}) |
         (~tlb_data_[24] & {38 {ram_rwl[24]}}) |
         (~tlb_data_[25] & {38 {ram_rwl[25]}}) |
         (~tlb_data_[26] & {38 {ram_rwl[26]}}) |
         (~tlb_data_[27] & {38 {ram_rwl[27]}}) |
         (~tlb_data_[28] & {38 {ram_rwl[28]}}) |
         (~tlb_data_[29] & {38 {ram_rwl[29]}}) |
         (~tlb_data_[30] & {38 {ram_rwl[30]}}) |
         (~tlb_data_[31] & {38 {ram_rwl[31]}}) |
         (~tlb_data_[32] & {38 {ram_rwl[32]}}) |
         (~tlb_data_[33] & {38 {ram_rwl[33]}}) |
         (~tlb_data_[34] & {38 {ram_rwl[34]}}) |
         (~tlb_data_[35] & {38 {ram_rwl[35]}}) |
         (~tlb_data_[36] & {38 {ram_rwl[36]}}) |
         (~tlb_data_[37] & {38 {ram_rwl[37]}}) |
         (~tlb_data_[38] & {38 {ram_rwl[38]}}) |
         (~tlb_data_[39] & {38 {ram_rwl[39]}}) |
         (~tlb_data_[40] & {38 {ram_rwl[40]}}) |
         (~tlb_data_[41] & {38 {ram_rwl[41]}}) |
         (~tlb_data_[42] & {38 {ram_rwl[42]}}) |
         (~tlb_data_[43] & {38 {ram_rwl[43]}}) |
         (~tlb_data_[44] & {38 {ram_rwl[44]}}) |
         (~tlb_data_[45] & {38 {ram_rwl[45]}}) |
         (~tlb_data_[46] & {38 {ram_rwl[46]}}) |
         (~tlb_data_[47] & {38 {ram_rwl[47]}}) |
         (~tlb_data_[48] & {38 {ram_rwl[48]}}) |
         (~tlb_data_[49] & {38 {ram_rwl[49]}}) |
         (~tlb_data_[50] & {38 {ram_rwl[50]}}) |
         (~tlb_data_[51] & {38 {ram_rwl[51]}}) |
         (~tlb_data_[52] & {38 {ram_rwl[52]}}) |
         (~tlb_data_[53] & {38 {ram_rwl[53]}}) |
         (~tlb_data_[54] & {38 {ram_rwl[54]}}) |
         (~tlb_data_[55] & {38 {ram_rwl[55]}}) |
         (~tlb_data_[56] & {38 {ram_rwl[56]}}) |
         (~tlb_data_[57] & {38 {ram_rwl[57]}}) |
         (~tlb_data_[58] & {38 {ram_rwl[58]}}) |
         (~tlb_data_[59] & {38 {ram_rwl[59]}}) |
         (~tlb_data_[60] & {38 {ram_rwl[60]}}) |
         (~tlb_data_[61] & {38 {ram_rwl[61]}}) |
         (~tlb_data_[62] & {38 {ram_rwl[62]}}) |
         (~tlb_data_[63] & {38 {ram_rwl[63]}}) );
			   
assign rd_tte_data[37:0] =
	({38 {any_rwl & ~any_wwl       }} & prd_data[37:0]) |
	({38 {any_rwl &  any_wwl & 1'bx}}                 ) ;


      


///////////////////////////////////////////////////////////////
// Construct the physical page number                        //
///////////////////////////////////////////////////////////////
assign tte_pa[39:13] = {rd_tte_data[`DATA_PA_39_28_HI:`DATA_PA_39_28_LO],
                        rd_tte_data[`DATA_PA_27_22_HI:`DATA_PA_27_22_LO],
                        rd_tte_data[`DATA_PA_21_16_HI:`DATA_PA_21_16_LO], 
                        rd_tte_data[`DATA_PA_15_13_HI:`DATA_PA_15_13_LO]};

assign pa[12:11] = va[12:11];

assign pa[15:13] = 
       (~rd_tte_data[`DATA_VA_15_13_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[15:13] : va[15:13] ;
assign pa[21:16] = 
       (~rd_tte_data[`DATA_VA_21_16_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[21:16] : va[21:16] ;
assign pa[27:22] = 
       (~rd_tte_data[`DATA_VA_27_22_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[27:22] : va[27:22] ;
assign pa[39:28] = 
       (tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[39:28] : va[39:28];




supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 

endmodule
`endif // `ifndef FPGA


//////////////////////////////////////////
////// n2_tlb_tl_128x59_cust
//////////////////////////////////////////

`ifndef FPGA
module n2_tlb_tl_128x59_cam (
  l1clk, 
  tlb_bypass, 
  tlb_wr_flopped, 
  tlb_rd_flopped, 
  rw_index, 
  tlb_cam, 
  tlb_cam_flopped, 
  demap, 
  demap_context, 
  demap_all, 
  demap_real, 
  tte_tag, 
  tte_tag_flopped, 
  tte_page_size_mask, 
  tag_read_mux_control, 
  tlb_cam_hit, 
  context0_hit, 
  rd_tte_tag, 
  ram_wwl, 
  ram_rwl, 
  valid) ;
wire [6:0] rw_index_to_decode;
wire [127:0] decoded_index;





input		l1clk;

input		tlb_bypass;
input		tlb_wr_flopped;
input		tlb_rd_flopped;
input	[6:0] rw_index;
input		tlb_cam;
input		tlb_cam_flopped;
input		demap;
input		demap_context;
input		demap_all;
input		demap_real;

input	[65:0]	tte_tag;
input	[65:0]	tte_tag_flopped;
input	[2:0]	tte_page_size_mask;

input 		tag_read_mux_control;



output		tlb_cam_hit;
output		context0_hit;
output	[65:0]	rd_tte_tag;
output	[128-1:0] ram_wwl;
output	[128-1:0] ram_rwl;
output	[128-1:0] valid;



`define CNTX1_HI 65
`define CNTX1_LO 53
`define PID_HI   52
`define PID_LO   50
`define REAL_BIT 49
`define VA_47    48
`define VA_28    29
`define VA_27    28
`define VA_22    23
`define TTE_VALID 22 
`define VA_21    21
`define VA_16    16
`define VA_15    15 
`define VA_13    13
`define CNTX0_HI 12
`define CNTX0_LO  0



//----------------------------------------------------------------------
// Declarations
//----------------------------------------------------------------------

// local signals

reg 	[12:0] 	context_a	[128-1:0];  // Contexts a and b are
reg 	[12:0] 	context_a_	[128-1:0];  // to be equal at all times
reg 	[12:0] 	context_b	[128-1:0];  // This is NOT context 0 and 1
reg 	[12:0] 	context_b_	[128-1:0];  // This is NOT primary/secondary
reg        	r_bit		[128-1:0];
reg        	r_bit_		[128-1:0];
reg     [47:28] va_47_28	[128-1:0];
reg     [47:28] va_47_28_	[128-1:0];
reg     [27:22] va_27_22	[128-1:0];
reg     [27:22] va_27_22_	[128-1:0];
reg     [21:16] va_21_16	[128-1:0];
reg     [21:16] va_21_16_	[128-1:0];
reg     [15:13] va_15_13	[128-1:0];
reg     [15:13] va_15_13_	[128-1:0];
reg	[2:0]	pid		[128-1:0];
reg	[2:0]	pid_		[128-1:0];
reg 	[128-1:0]	valid;
reg 	[128-1:0]	match_for_sat;
reg 			tlb_cam_hit;
reg 			context0_hit;

integer n;
reg [31:0] n_reg;

reg [128-1:0] va_47_28_match ;
reg [128-1:0] va_27_22_match ;
reg [128-1:0] va_21_16_match ;
reg [128-1:0] va_15_13_match ;
reg [128-1:0] pid_match      ;
reg [128-1:0] real_match     ;
reg [128-1:0] context0_match ;
reg [128-1:0] context1_match ;
reg [128-1:0] context_match  ;
reg [128-1:0] match          ;
reg [128-1:0] ram_wl         ;
reg [65:0] rd_tte_tag;
reg [12:0] a_xnor_tag;
reg [12:0] b_xnor_tag;

reg 	   demap_posedge_l1clk;



`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
initial begin
	for (n = 0; n < 128; n = n+1) begin
		context_a	[n] = {13 {1'b0}};
		context_a_	[n] = {13 {1'b1}};
		context_b	[n] = {13 {1'b0}};
		context_b_	[n] = {13 {1'b1}};
		r_bit		[n] = { 1 {1'b0}};
		r_bit_		[n] = { 1 {1'b1}};
		va_47_28	[n] = {20 {1'b0}};
		va_47_28_	[n] = {20 {1'b1}};
		va_27_22	[n] = { 6 {1'b0}};
		va_27_22_	[n] = { 6 {1'b1}};
		va_21_16	[n] = { 6 {1'b0}};
		va_21_16_	[n] = { 6 {1'b1}};
		va_15_13	[n] = { 3 {1'b0}};
		va_15_13_	[n] = { 3 {1'b1}};
		pid		[n] = { 3 {1'b0}};
		pid_		[n] = { 3 {1'b1}};
		valid		[n] = { 1 {1'b0}};
	end // for (n = 0; n < 128; n = n+1)
end
`endif



///////////////////////////////////////////////////////////////
// CAM, read
///////////////////////////////////////////////////////////////
always @(posedge l1clk) begin

	demap_posedge_l1clk = demap;

	match[128-1:0] = {128 {1'b0}};

	if (tlb_cam | demap) begin
		for (n = 0; n < 128; n = n + 1) begin
			// Have to represent dual match line architecture...
			// LSB 2 bits of context must both match AND MSB 11 bits must not mismatch
			a_xnor_tag[12:0] =       (context_a	[n] &  tte_tag[`CNTX1_HI:`CNTX1_LO]) |
						 (context_a_	[n] & ~tte_tag[`CNTX1_HI:`CNTX1_LO]) ;
			b_xnor_tag[12:0] =       (context_b	[n] &  tte_tag[`CNTX0_HI:`CNTX0_LO]) |
						 (context_b_	[n] & ~tte_tag[`CNTX0_HI:`CNTX0_LO]) ;
			context1_match[n] = demap_all | demap_real | 
					    (& a_xnor_tag[1:0]) & 
					    (~(| {context_a	[n] & ~tte_tag[`CNTX1_HI:`CNTX1_LO] & 13'h1ffc,
						  context_a_	[n] &  tte_tag[`CNTX1_HI:`CNTX1_LO] & 13'h1ffc}));
			context0_match[n] = demap_all | demap_real |
					    (& b_xnor_tag[1:0]) & 
					    (~(| {context_b	[n] & ~tte_tag[`CNTX0_HI:`CNTX0_LO] & 13'h1ffc,
						  context_b_	[n] &  tte_tag[`CNTX0_HI:`CNTX0_LO] & 13'h1ffc}));
			pid_match[n]      = (~(| {pid		[n] & ~tte_tag[`PID_HI	:`PID_LO  ],
						  pid_		[n] &  tte_tag[`PID_HI	:`PID_LO  ]}));
			real_match[n]     = demap_all | 
					    (~(| {r_bit		[n] & ~tte_tag[`REAL_BIT	  ],
						  r_bit_	[n] &  tte_tag[`REAL_BIT	  ]}));
			va_47_28_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_47_28	[n] & ~tte_tag[`VA_47	:`VA_28   ],
						  va_47_28_	[n] &  tte_tag[`VA_47	:`VA_28   ]}));
			va_27_22_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_27_22	[n] & ~tte_tag[`VA_27	:`VA_22   ],
						  va_27_22_	[n] &  tte_tag[`VA_27	:`VA_22   ]}));
			va_21_16_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_21_16	[n] & ~tte_tag[`VA_21	:`VA_16   ],
						  va_21_16_	[n] &  tte_tag[`VA_21	:`VA_16   ]}));
			va_15_13_match[n] = demap_all | demap_real | demap_context |  
					    (~(| {va_15_13	[n] & ~tte_tag[`VA_15	:`VA_13   ],
						  va_15_13_	[n] &  tte_tag[`VA_15	:`VA_13   ]}));

			context_match[n]  = context0_match[n] | context1_match[n];
			
			match[n] = va_47_28_match[n] & va_27_22_match[n] & va_21_16_match[n] & 
				   va_15_13_match[n] & pid_match[n] & real_match[n] & context_match[n] &
				   valid[n];

		end // for (n = 0; n < 128; n = n + 1)
		
		
	end // if (tlb_cam | demap)
	

		
	ram_wl[128-1:0] <= match[128-1:0];
	
end // always @ (posedge l1clk)



///////////////////////////////////////////////////////////////
// Demap, Write, Read
///////////////////////////////////////////////////////////////
always @(negedge l1clk) begin

	// Demap
	if (demap) begin	
		for (n = 0; n < 128; n = n + 1) begin
			if (match[n]) begin
				valid[n] <= 1'b0;
			end
		end
	end // if (demap)	

	// Write
	if (tlb_wr_flopped) begin

		for (n = 0; n < 128; n = n + 1) begin
			if (ram_wwl[n]) begin
				context_a	[n] <=( tte_tag_flopped[`CNTX1_HI:`CNTX1_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				context_a_	[n] <=(~tte_tag_flopped[`CNTX1_HI:`CNTX1_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				pid		[n] <=  tte_tag_flopped[`PID_HI  :`PID_LO  ];
				pid_		[n] <= ~tte_tag_flopped[`PID_HI  :`PID_LO  ];
				r_bit		[n] <=  tte_tag_flopped[`REAL_BIT          ];
				r_bit_		[n] <= ~tte_tag_flopped[`REAL_BIT          ];
				va_47_28	[n] <=  tte_tag_flopped[`VA_47   :`VA_28   ];
				va_47_28_	[n] <= ~tte_tag_flopped[`VA_47   :`VA_28   ];
				va_27_22	[n] <=  tte_tag_flopped[`VA_27   :`VA_22   ] & { 6 {~tte_page_size_mask[2]}};
				va_27_22_	[n] <= ~tte_tag_flopped[`VA_27   :`VA_22   ] & { 6 {~tte_page_size_mask[2]}};
				va_21_16	[n] <=  tte_tag_flopped[`VA_21   :`VA_16   ] & { 6 {~tte_page_size_mask[1]}};
				va_21_16_	[n] <= ~tte_tag_flopped[`VA_21   :`VA_16   ] & { 6 {~tte_page_size_mask[1]}};
				va_15_13	[n] <=  tte_tag_flopped[`VA_15   :`VA_13   ] & { 3 {~tte_page_size_mask[0]}};
				va_15_13_	[n] <= ~tte_tag_flopped[`VA_15   :`VA_13   ] & { 3 {~tte_page_size_mask[0]}};
				context_b	[n] <=( tte_tag_flopped[`CNTX0_HI:`CNTX0_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				context_b_	[n] <=(~tte_tag_flopped[`CNTX0_HI:`CNTX0_LO] & {13 {~tte_tag_flopped[`REAL_BIT]}}) | {11'h00, {2 {tte_tag_flopped[`REAL_BIT]}}};
				valid 		[n] <=  tte_tag_flopped[`TTE_VALID         ];

				
				
					
			end // if (ram_wwl[n])
		end // for (n = 0; n < 128; n = n + 1)
		
	end // if (tlb_wr_flopped)
	
	// Read
	if (tlb_rd_flopped) begin
		if (tag_read_mux_control) begin
			rd_tte_tag[`CNTX1_HI:`CNTX1_LO] <= context_a_	[rw_index[6:0]];
			rd_tte_tag[`PID_HI  :`PID_LO  ] <= pid_		[rw_index[6:0]];
			rd_tte_tag[`REAL_BIT          ] <= r_bit_	[rw_index[6:0]];
			rd_tte_tag[`VA_47   :`VA_28   ] <= va_47_28_	[rw_index[6:0]];
			rd_tte_tag[`VA_27   :`VA_22   ] <= va_27_22_	[rw_index[6:0]];
			rd_tte_tag[`VA_21   :`VA_16   ] <= va_21_16_	[rw_index[6:0]];
			rd_tte_tag[`VA_15   :`VA_13   ] <= va_15_13_	[rw_index[6:0]];
			rd_tte_tag[`CNTX0_HI:`CNTX0_LO] <= context_b_	[rw_index[6:0]];
		end // if (tag_read_mux_control)
		else begin
			rd_tte_tag[`CNTX1_HI:`CNTX1_LO] <= context_a	[rw_index[6:0]];
			rd_tte_tag[`PID_HI  :`PID_LO  ] <= pid		[rw_index[6:0]];
			rd_tte_tag[`REAL_BIT          ] <= r_bit	[rw_index[6:0]];
			rd_tte_tag[`VA_47   :`VA_28   ] <= va_47_28	[rw_index[6:0]];
			rd_tte_tag[`VA_27   :`VA_22   ] <= va_27_22	[rw_index[6:0]];
			rd_tte_tag[`VA_21   :`VA_16   ] <= va_21_16	[rw_index[6:0]];
			rd_tte_tag[`VA_15   :`VA_13   ] <= va_15_13	[rw_index[6:0]];
			rd_tte_tag[`CNTX0_HI:`CNTX0_LO] <= context_b	[rw_index[6:0]];
		end // else: !if(tag_read_mux_control)
		rd_tte_tag[`TTE_VALID         ] <= valid	[rw_index[6:0]];
	end // if (tlb_rd
	else begin
	        rd_tte_tag[65:0] <= {66 {1'b0}} ;
	end // else: !if(tlb_rd)

end // always @ (negedge l1clk)



///////////////////////////////////////////////////////////////
// Output assignments
///////////////////////////////////////////////////////////////
// Have to hold them to next clock edge

// Read and write address decode
assign rw_index_to_decode[6:0] =
//	{1'b0,
	{rw_index[6],
	rw_index[5:0]};

assign decoded_index[127:0] = 
	{(rw_index_to_decode[6:0] == 7'h7f),
	 (rw_index_to_decode[6:0] == 7'h7e),
	 (rw_index_to_decode[6:0] == 7'h7d),
	 (rw_index_to_decode[6:0] == 7'h7c),
	 (rw_index_to_decode[6:0] == 7'h7b),
	 (rw_index_to_decode[6:0] == 7'h7a),
	 (rw_index_to_decode[6:0] == 7'h79),
	 (rw_index_to_decode[6:0] == 7'h78),
	 (rw_index_to_decode[6:0] == 7'h77),
	 (rw_index_to_decode[6:0] == 7'h76),
	 (rw_index_to_decode[6:0] == 7'h75),
	 (rw_index_to_decode[6:0] == 7'h74),
	 (rw_index_to_decode[6:0] == 7'h73),
	 (rw_index_to_decode[6:0] == 7'h72),
	 (rw_index_to_decode[6:0] == 7'h71),
	 (rw_index_to_decode[6:0] == 7'h70),
	 (rw_index_to_decode[6:0] == 7'h6f),
	 (rw_index_to_decode[6:0] == 7'h6e),
	 (rw_index_to_decode[6:0] == 7'h6d),
	 (rw_index_to_decode[6:0] == 7'h6c),
	 (rw_index_to_decode[6:0] == 7'h6b),
	 (rw_index_to_decode[6:0] == 7'h6a),
	 (rw_index_to_decode[6:0] == 7'h69),
	 (rw_index_to_decode[6:0] == 7'h68),
	 (rw_index_to_decode[6:0] == 7'h67),
	 (rw_index_to_decode[6:0] == 7'h66),
	 (rw_index_to_decode[6:0] == 7'h65),
	 (rw_index_to_decode[6:0] == 7'h64),
	 (rw_index_to_decode[6:0] == 7'h63),
	 (rw_index_to_decode[6:0] == 7'h62),
	 (rw_index_to_decode[6:0] == 7'h61),
	 (rw_index_to_decode[6:0] == 7'h60),
	 (rw_index_to_decode[6:0] == 7'h5f),
	 (rw_index_to_decode[6:0] == 7'h5e),
	 (rw_index_to_decode[6:0] == 7'h5d),
	 (rw_index_to_decode[6:0] == 7'h5c),
	 (rw_index_to_decode[6:0] == 7'h5b),
	 (rw_index_to_decode[6:0] == 7'h5a),
	 (rw_index_to_decode[6:0] == 7'h59),
	 (rw_index_to_decode[6:0] == 7'h58),
	 (rw_index_to_decode[6:0] == 7'h57),
	 (rw_index_to_decode[6:0] == 7'h56),
	 (rw_index_to_decode[6:0] == 7'h55),
	 (rw_index_to_decode[6:0] == 7'h54),
	 (rw_index_to_decode[6:0] == 7'h53),
	 (rw_index_to_decode[6:0] == 7'h52),
	 (rw_index_to_decode[6:0] == 7'h51),
	 (rw_index_to_decode[6:0] == 7'h50),
	 (rw_index_to_decode[6:0] == 7'h4f),
	 (rw_index_to_decode[6:0] == 7'h4e),
	 (rw_index_to_decode[6:0] == 7'h4d),
	 (rw_index_to_decode[6:0] == 7'h4c),
	 (rw_index_to_decode[6:0] == 7'h4b),
	 (rw_index_to_decode[6:0] == 7'h4a),
	 (rw_index_to_decode[6:0] == 7'h49),
	 (rw_index_to_decode[6:0] == 7'h48),
	 (rw_index_to_decode[6:0] == 7'h47),
	 (rw_index_to_decode[6:0] == 7'h46),
	 (rw_index_to_decode[6:0] == 7'h45),
	 (rw_index_to_decode[6:0] == 7'h44),
	 (rw_index_to_decode[6:0] == 7'h43),
	 (rw_index_to_decode[6:0] == 7'h42),
	 (rw_index_to_decode[6:0] == 7'h41),
	 (rw_index_to_decode[6:0] == 7'h40),
	 (rw_index_to_decode[6:0] == 7'h3f),
	 (rw_index_to_decode[6:0] == 7'h3e),
	 (rw_index_to_decode[6:0] == 7'h3d),
	 (rw_index_to_decode[6:0] == 7'h3c),
	 (rw_index_to_decode[6:0] == 7'h3b),
	 (rw_index_to_decode[6:0] == 7'h3a),
	 (rw_index_to_decode[6:0] == 7'h39),
	 (rw_index_to_decode[6:0] == 7'h38),
	 (rw_index_to_decode[6:0] == 7'h37),
	 (rw_index_to_decode[6:0] == 7'h36),
	 (rw_index_to_decode[6:0] == 7'h35),
	 (rw_index_to_decode[6:0] == 7'h34),
	 (rw_index_to_decode[6:0] == 7'h33),
	 (rw_index_to_decode[6:0] == 7'h32),
	 (rw_index_to_decode[6:0] == 7'h31),
	 (rw_index_to_decode[6:0] == 7'h30),
	 (rw_index_to_decode[6:0] == 7'h2f),
	 (rw_index_to_decode[6:0] == 7'h2e),
	 (rw_index_to_decode[6:0] == 7'h2d),
	 (rw_index_to_decode[6:0] == 7'h2c),
	 (rw_index_to_decode[6:0] == 7'h2b),
	 (rw_index_to_decode[6:0] == 7'h2a),
	 (rw_index_to_decode[6:0] == 7'h29),
	 (rw_index_to_decode[6:0] == 7'h28),
	 (rw_index_to_decode[6:0] == 7'h27),
	 (rw_index_to_decode[6:0] == 7'h26),
	 (rw_index_to_decode[6:0] == 7'h25),
	 (rw_index_to_decode[6:0] == 7'h24),
	 (rw_index_to_decode[6:0] == 7'h23),
	 (rw_index_to_decode[6:0] == 7'h22),
	 (rw_index_to_decode[6:0] == 7'h21),
	 (rw_index_to_decode[6:0] == 7'h20),
	 (rw_index_to_decode[6:0] == 7'h1f),
	 (rw_index_to_decode[6:0] == 7'h1e),
	 (rw_index_to_decode[6:0] == 7'h1d),
	 (rw_index_to_decode[6:0] == 7'h1c),
	 (rw_index_to_decode[6:0] == 7'h1b),
	 (rw_index_to_decode[6:0] == 7'h1a),
	 (rw_index_to_decode[6:0] == 7'h19),
	 (rw_index_to_decode[6:0] == 7'h18),
	 (rw_index_to_decode[6:0] == 7'h17),
	 (rw_index_to_decode[6:0] == 7'h16),
	 (rw_index_to_decode[6:0] == 7'h15),
	 (rw_index_to_decode[6:0] == 7'h14),
	 (rw_index_to_decode[6:0] == 7'h13),
	 (rw_index_to_decode[6:0] == 7'h12),
	 (rw_index_to_decode[6:0] == 7'h11),
	 (rw_index_to_decode[6:0] == 7'h10),
	 (rw_index_to_decode[6:0] == 7'h0f),
	 (rw_index_to_decode[6:0] == 7'h0e),
	 (rw_index_to_decode[6:0] == 7'h0d),
	 (rw_index_to_decode[6:0] == 7'h0c),
	 (rw_index_to_decode[6:0] == 7'h0b),
	 (rw_index_to_decode[6:0] == 7'h0a),
	 (rw_index_to_decode[6:0] == 7'h09),
	 (rw_index_to_decode[6:0] == 7'h08),
	 (rw_index_to_decode[6:0] == 7'h07),
	 (rw_index_to_decode[6:0] == 7'h06),
	 (rw_index_to_decode[6:0] == 7'h05),
	 (rw_index_to_decode[6:0] == 7'h04),
	 (rw_index_to_decode[6:0] == 7'h03),
	 (rw_index_to_decode[6:0] == 7'h02),
	 (rw_index_to_decode[6:0] == 7'h01),
	 (rw_index_to_decode[6:0] == 7'h00)};

//assign decoded_index_unused[127:64] = decoded_index[127:64];

always @(negedge l1clk) begin
	match_for_sat[128-1:0] <= match[128-1:0]; // For MMU SAT
	tlb_cam_hit <= (| match[128-1:0]) | tlb_bypass | ~tlb_cam;
	context0_hit <= (|(match[128-1:0] & context0_match[128-1:0])) & ~demap_posedge_l1clk;
end // always @ (negedge l1clk)

assign ram_wwl[128-1:0] = 
       decoded_index[128-1:0] & {128 {tlb_wr_flopped}};

assign ram_rwl[128-1:0] = 
       (decoded_index[128-1:0] & {128 {tlb_rd_flopped }}) |
       (ram_wl       [128-1:0] & {128 {tlb_cam_flopped}});





supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
endmodule
`endif 	// `ifndef FPGA

`ifndef FPGA
module n2_tlb_tl_128x59_ram (
  l1clk, 
  tlb_bypass, 
  tlb_cam_flopped, 
  ram_wwl, 
  ram_rwl, 
  tte_data, 
  va, 
  force_data_to_x, 
  pa, 
  rd_tte_data) ;
wire [6:0] encoded_rwl;
wire any_wwl;
wire any_rwl;
wire [39:13] tte_pa;





input		l1clk;

input		tlb_bypass;
input 		tlb_cam_flopped;
input	[128-1:0] ram_wwl;
input	[128-1:0] ram_rwl;

input	[37:0]	tte_data;
input	[39:11]	va;		// Incoming VA
input		force_data_to_x;



output	[39:11]	pa;
output	[37:0]	rd_tte_data;



`define DATA_PARITY         36
`define DATA_PA_39_28_HI    35
`define DATA_PA_39_28_LO    24
`define DATA_PA_27_22_HI    23
`define DATA_PA_27_22_LO    18
`define DATA_VA_27_22_V     17 
`define DATA_PA_21_16_HI    16
`define DATA_PA_21_16_LO    11
`define DATA_VA_21_16_V     10 
`define DATA_PA_15_13_HI     9
`define DATA_PA_15_13_LO     7
`define DATA_VA_15_13_V      6 
`define DATA_NFO             5 
`define DATA_IE              4 
`define DATA_CP              3 
`define DATA_X               2 
`define DATA_P               1 
`define DATA_W               0 

// Converted to structural to eliminate races
assign encoded_rwl[6:0] =
	{| {ram_rwl[127:64] },
	 | {ram_rwl[127:96] , ram_rwl[63:32]},
	 | {ram_rwl[127:112], ram_rwl[95:80], ram_rwl[63:48], ram_rwl[31:16]},
	 | {ram_rwl[127:120], ram_rwl[111:104], 
	    ram_rwl[95:88], ram_rwl[79:72], ram_rwl[63:56], ram_rwl[47:40],
	    ram_rwl[31:24], ram_rwl[15:8]},
	 | {ram_rwl[127:124], ram_rwl[119:116], ram_rwl[111:108], ram_rwl[103:100],
	    ram_rwl[95:92], ram_rwl[87:84], ram_rwl[79:76], ram_rwl[71:68], 
	    ram_rwl[63:60], ram_rwl[55:52], ram_rwl[47:44], ram_rwl[39:36],
	    ram_rwl[31:28], ram_rwl[23:20], ram_rwl[15:12], ram_rwl[7:4]},
	 | {ram_rwl[127:126], ram_rwl[123:122], ram_rwl[119:118], ram_rwl[115:114],
	    ram_rwl[111:110], ram_rwl[107:106], ram_rwl[103:102], ram_rwl[99:98],
	    ram_rwl[95:94], ram_rwl[91:90], ram_rwl[87:86], ram_rwl[83:82], 
	    ram_rwl[79:78], ram_rwl[75:74], ram_rwl[71:70], ram_rwl[67:66],
	    ram_rwl[63:62], ram_rwl[59:58], ram_rwl[55:54], ram_rwl[51:50],
	    ram_rwl[47:46], ram_rwl[43:42], ram_rwl[39:38], ram_rwl[35:34],
	    ram_rwl[31:30], ram_rwl[27:26], ram_rwl[23:22], ram_rwl[19:18],
	    ram_rwl[15:14], ram_rwl[11:10], ram_rwl[7:6], ram_rwl[3:2]},
	 | {ram_rwl[127], ram_rwl[125], ram_rwl[123], ram_rwl[121], 
	    ram_rwl[119], ram_rwl[117], ram_rwl[115], ram_rwl[113], ram_rwl[111], 
	    ram_rwl[109], ram_rwl[107], ram_rwl[105], ram_rwl[103], ram_rwl[101], 
	    ram_rwl[99], ram_rwl[97], ram_rwl[95], ram_rwl[93], ram_rwl[91], 
	    ram_rwl[89], ram_rwl[87], ram_rwl[85], ram_rwl[83], ram_rwl[81], 
	    ram_rwl[79], ram_rwl[77], ram_rwl[75], ram_rwl[73], ram_rwl[71], 
	    ram_rwl[69], ram_rwl[67], ram_rwl[65], ram_rwl[63], ram_rwl[61], 
	    ram_rwl[59], ram_rwl[57], ram_rwl[55], ram_rwl[53], ram_rwl[51], 
	    ram_rwl[49], ram_rwl[47], ram_rwl[45], ram_rwl[43], ram_rwl[41], 
	    ram_rwl[39], ram_rwl[37], ram_rwl[35], ram_rwl[33], ram_rwl[31], 
	    ram_rwl[29], ram_rwl[27], ram_rwl[25], ram_rwl[23], ram_rwl[21], 
	    ram_rwl[19], ram_rwl[17], ram_rwl[15], ram_rwl[13], ram_rwl[11], 
	    ram_rwl[9], ram_rwl[7], ram_rwl[5], ram_rwl[3], ram_rwl[1]}};

assign any_wwl =
	| ram_wwl[128-1:0];

assign any_rwl =
	| ram_rwl[128-1:0];











//----------------------------------------------------------------------
// Declarations
//----------------------------------------------------------------------

reg [37:0]  tlb_data[128-1:0] ;		// this models the data array

integer n;

`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
initial begin
	for (n = 0; n < 128; n = n + 1) begin
		tlb_data[n] = {38 {1'b0}};
	end
	`ifdef ENABLE_DUMPMEM
	if ($test$plusargs("DUMPMEM_DTLB")) begin
		$fsdbDumpMem(tlb_data, 0, 128);
	end
	`endif
end
`endif





///////////////////////////////////////////////////////////////
// Write                                                     // 
///////////////////////////////////////////////////////////////
always @(negedge l1clk) begin

	for (n = 0; n < 128; n = n + 1) begin
		if (ram_wwl[n]) begin
			tlb_data[n] <= tte_data[37:0];
			
			
			
			
			n = 128;
			
		end // if (ram_wl[n])
	end // for (n = 0; n < 128; n = n + 1)
	
end // always @ (ram_wl[128-1:0])



///////////////////////////////////////////////////////////////
// Read                                                      // 
///////////////////////////////////////////////////////////////

// ram_rwl is now second half cycle signal... so no need to latch
// Only force outputs to X if read and write at same time
// or on multiple hit
assign rd_tte_data[37:0] =
	({38 {any_rwl & ~any_wwl & ~force_data_to_x}} & tlb_data[encoded_rwl]) |
	({38 {any_rwl &  any_wwl & 1'bx}}) |
	({38 {force_data_to_x & 1'bx}}) ;


      


///////////////////////////////////////////////////////////////
// Construct the physical page number                        //
///////////////////////////////////////////////////////////////
assign tte_pa[39:13] = {rd_tte_data[`DATA_PA_39_28_HI:`DATA_PA_39_28_LO],
                        rd_tte_data[`DATA_PA_27_22_HI:`DATA_PA_27_22_LO],
                        rd_tte_data[`DATA_PA_21_16_HI:`DATA_PA_21_16_LO], 
                        rd_tte_data[`DATA_PA_15_13_HI:`DATA_PA_15_13_LO]};

assign pa[12:11] = va[12:11];

assign pa[15:13] = 
       (~rd_tte_data[`DATA_VA_15_13_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[15:13] : va[15:13] ;
assign pa[21:16] = 
       (~rd_tte_data[`DATA_VA_21_16_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[21:16] : va[21:16] ;
assign pa[27:22] = 
       (~rd_tte_data[`DATA_VA_27_22_V] & tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[27:22] : va[27:22] ;
assign pa[39:28] = 
       (tlb_cam_flopped & ~tlb_bypass) ? 
	       tte_pa[39:28] : va[39:28];




supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 

endmodule
`endif 	// `ifndef FPGA


//////////////////////////////////////////
////// n2_mmu_cm_64x34s_cust 
//////////////////////////////////////////

module n2_mmu_cm_64x34s_cust_array	(

   // ram control
   clk,
   l2clk,
   rd_addr_array,
   wr_addr_array,
   wr_array,
   rd_array,
   lkup_en_array,
   hld_array,
   din_array, 
   key_array, 
   hit_array, 
   dout_array    

);




   // 
   input 		clk,l2clk;				// clk 
   input [5:0]		rd_addr_array;			// read port address in
   input [5:0]		wr_addr_array;			// write port address in
   input		wr_array;			// write port enable
   input		rd_array;			// read port enable
   input		lkup_en_array;			// enable CAM operation
   input		hld_array;			// enable CAM operation
   input [32:0] 	din_array;			// data in
   input [32:0] 	key_array;			// value to CAM against
   output [32:0] 	dout_array;			// data out
   output [63:0] 	hit_array;			// results of CAM operation

integer	i;
// ----------------------------------------------------------------------------
// Zero In Checkers
// ----------------------------------------------------------------------------
// checker to verify on accesses's that no bits are x
/* //BP 0in assert -var (((|rd_addr_array[6:0] ) == 1'bx)
                    || ((|wr_addr_array[6:0] ) == 1'bx)
                    || ((wr_en_array ) == 1'bx))
               -active (rd_array | wr_array)
               -module dmu_ram128x132_array
                -name dmu_ram128x132_array_x
*/
  // 0in kndr -var rd_addr_array
  // 0in kndr -var wr_addr_array
  // 0in kndr -var wr_array
  // 0in kndr -var rd_array
  // 0in kndr -var lkup_en_array
  // 0in kndr -var din_array -active (wr_array )


/* RAM Array: =128 - 1        -> 127    */

reg     [32:0]  tag      [0:63];
reg	[63:0]	hit_array;
reg	[32:0]	dout_array;

// Initialize the arrays
`ifndef NOINITMEM
initial begin
  for (i=0; i<64; i=i+1) begin
    tag[i] = 33'b0;
  end
  hit_array = 64'b0;
end
`endif



// ----------------------------------------------------------------------------
// Read the array
// ----------------------------------------------------------------------------
//assign	dout_array[131:0] =	array_ram[rd_addr_array[6:0]];
reg read_flag;
always @(clk or rd_addr_array or rd_array or wr_array or wr_addr_array or l2clk) begin
read_flag <=0;
	if (clk & l2clk) begin
	if (rd_array) begin
read_flag <=1;
                if (wr_array  & (rd_addr_array == wr_addr_array)) begin
                dout_array[32:0] <= {33{1'bx}}; //0in <fire -severity 1 -message " got x's in dmu cam" -group mbist_mode
                end
        else begin
		dout_array <=     tag[rd_addr_array[5:0]];
		end
	end
	end
end



// ----------------------------------------------------------------------------
// Write the array, note: it is written when the clock is low
// ----------------------------------------------------------------------------
reg write_flag;
  always @ ( clk or lkup_en_array or hld_array or l2clk or
				wr_addr_array or din_array or key_array or wr_array)  begin
write_flag<=0;
	if(~clk & ~l2clk) begin
      if (wr_array ) begin
write_flag<=1;
        tag[wr_addr_array] <= din_array;
      	end
      end

	if(clk & l2clk) begin
    for (i = 0; i < 64; i = i + 1) begin
      if (~hld_array ) begin
       hit_array[i] <= lkup_en_array & (key_array == tag[i]);
      	end
      end
      end
  end



endmodule	// n2_mmu_cm_64x34s_cust_array



//////////////////////////////////////////
////// n2_l2t_sp_28kb_cust  
//////////////////////////////////////////


`define L2T_ARR_D_WIDTH            28
`define L2T_ARR_DEPTH              512
`define WAY_HIT_WIDTH              16
`define BADREAD                	   BADBADD 


`define  sh_index_lft		  5'b00000
`define  sh_index_rgt		  5'b00000

module n2_l2t_array (
  din, 
  addr_b, 
  l1clk_internal_v1, 
  l1clk_internal_v2, 
  ln1clk, 
  ln2clk, 
  rd_en_b, 
  rd_en_d1_a, 
  rpda_lft, 
  rpda_rgt, 
  rpdb_lft, 
  rpdb_rgt, 
  rpdc_lft, 
  rpdc_rgt, 
  w_inhibit_l, 
  wr_en_b, 
  wr_en_d1_a, 
  wr_way_b, 
  wr_way_b_l, 
  vnw_ary, 
  sao_mx0_h, 
  sao_mx0_l, 
  sao_mx1_h, 
  sao_mx1_l);
wire ln1clk_unused;
wire ln2clk_unused;
wire l1clk_int_v2_unused;
wire rd_en_b_unused;
wire wr_en_b_unused;
wire [1:0] wr_way_b_unused;
wire l1clk_int;
wire rd_en;
wire [4:0] sf_l;
wire [4:0] sf_r;
wire shift_en_lft;
wire shift_en_rgt;
wire redundancy_en;
wire [4:0] sh_index_lft;
wire [4:0] sh_index_rgt;
wire mem_wr_en0;
wire mem_wr_en1;


//   input         l2clk;                  // cmp clock
//   input         iol2clk;                  // io clock
//   input         scan_in;
//   input         tcu_pce_ov;            // scan signals
//   input         tcu_clk_stop;
//   input         tcu_aclk;
//   input         tcu_bclk;
//   input         tcu_scan_en;
//   input         tcu_muxtest;
//   input         tcu_dectest;
//   output        scan_out;


input	[`L2T_ARR_D_WIDTH - 1:0]	din;
input	[8:0]	 			addr_b;
input		 			l1clk_internal_v1;
input		 			l1clk_internal_v2;
input		 			ln1clk;
input		 			ln2clk;
input		 			rd_en_b;
input		 			rd_en_d1_a;
input	[1:0]	 			rpda_lft;
input	[1:0]	 			rpda_rgt;
input	[3:0]	 			rpdb_lft;
input	[3:0]	 			rpdb_rgt;
input	[3:0]	 			rpdc_lft;
input	[3:0]	 			rpdc_rgt;
input		 			w_inhibit_l;
input		 			wr_en_b;
input		 			wr_en_d1_a;
input   [1:0]	 			wr_way_b;
input   [1:0]	 			wr_way_b_l;

// Added vnw_ary pin for n2 for 2.0

input                                   vnw_ary;

output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx0_h;
output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx0_l;
output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx1_h;
output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx1_l;


reg 	[`L2T_ARR_D_WIDTH + 2:0]    	mem_lft[`L2T_ARR_DEPTH - 1 :0];	//one extra bit for redundancy
reg 	[0:`L2T_ARR_D_WIDTH - 2]    	mem_rgt[`L2T_ARR_DEPTH - 1 :0];
reg 	[`L2T_ARR_D_WIDTH + 2:0]    	mem_lft_reg ;
reg 	[0:`L2T_ARR_D_WIDTH - 2]    	mem_rgt_reg ; 			// one entry of the memonry


reg  	[`L2T_ARR_D_WIDTH + 2:0]	mem_data_lft;
reg  	[0:`L2T_ARR_D_WIDTH - 2]	mem_data_rgt;

reg  	[14:0]				rdata0_lft;
reg  	[14:0]				rdata1_lft;
reg  	[0:12]				rdata0_rgt;
reg  	[0:12]				rdata1_rgt;
reg  	[30:0]				wdata_lft;
reg  	[30:0]				wdata_rgt;
reg  	[29:0]				tmp_lft;
reg  	[25:0]				tmp_rgt;

wire  	[14:0]				mem0_lft;
wire  	[14:0]				mem1_lft;
wire  	[12:0]				mem0_rgt;
wire  	[12:0]				mem1_rgt;
wire  	[30:0]				mem_all_lft;
wire  	[26:0]				mem_all_rgt;
wire  	[30:0]				rdata_out_lft;
wire  	[26:0]				rdata_out_rgt;
integer				 	i;
integer				 	j;
integer				 	l;
integer				 	k;

reg  	[`L2T_ARR_D_WIDTH - 1:0] sao_mx0_h ;	
reg  	[`L2T_ARR_D_WIDTH - 1:0] sao_mx0_l ;	
reg  	[`L2T_ARR_D_WIDTH - 1:0] sao_mx1_h ;	
reg  	[`L2T_ARR_D_WIDTH - 1:0] sao_mx1_l ;	

wire  	[`L2T_ARR_D_WIDTH - 1:0] rdata0_out ;	
wire  	[`L2T_ARR_D_WIDTH - 1:0] rdata1_out ;	
//-----------------------------------------------------------------
//	  	INITIALIZE MEMORY	
//-----------------------------------------------------------------
`ifndef NOINITMEM
initial begin
	for (i = 0; i < `L2T_ARR_DEPTH - 1; i = i + 1)
          begin
             mem_rgt[i]=27'h0;
             mem_lft[i]=31'h0;
          end
	end
`endif


//-----------------------------------------------------------------
//	  	UNUSED SIGNALS	
//-----------------------------------------------------------------
assign	ln1clk_unused		= ln1clk;
assign	ln2clk_unused		= ln2clk;
assign	l1clk_int_v2_unused	= l1clk_internal_v2;
assign	rd_en_b_unused		= rd_en_b;
assign	wr_en_b_unused		= wr_en_b;
assign	wr_way_b_unused[1:0]	= wr_way_b_l[1:0];


assign	l1clk_int		= l1clk_internal_v1;

//-----------------------------------------------------------------
//	 	OUTPUTS	
//-----------------------------------------------------------------
//
//always @ (l1clk_int or rd_en)
//  if (l1clk_int || ~rd_en)	
//    begin
//	sao_mx0_h [`L2T_ARR_D_WIDTH - 1:0] <=   28'h0;
//	sao_mx0_l [`L2T_ARR_D_WIDTH - 1:0] <=   28'h0;
//	sao_mx1_h [`L2T_ARR_D_WIDTH - 1:0] <=   28'h0;
//	sao_mx1_l [`L2T_ARR_D_WIDTH - 1:0] <=   28'h0;
//    end
//
//-----------------------------------------------------------------
//	  	INTERNAL LOGIC	
//-----------------------------------------------------------------
// Add vnw_ary high check for read operation for n2_to_2.0
// assign rd_en =  rd_en_d1_a && ~wr_en_d1_a && w_inhibit_l;
  assign rd_en =  rd_en_d1_a && ~wr_en_d1_a && w_inhibit_l && vnw_ary;

//-----------------------------------------------------------------
//			REDUNDANCY
//-----------------------------------------------------------------
// Use [511:0] way0[29] as the redundancy bit, there are total 512 redundancy
// bits. 
// Left side  :	way0_tmp[29:15] = mem0_lft[14:0]
//	       	way1_tmp[27:13] = mem1_lft[14:0]
//	       	way0_tmp[14]    = red_bit_lft     (redundancy bit)	
//	Shift mem1_lft[n] -> mem0_lft[n] , shift mem0_lft[n]->men1_rgt[n-1]
// 			 mem0_lft[0]->redundancy bit = red_bit_lft.
//
// Right side : way0_tmp[12:0] = mem0_rgt[12:0]
//	       	way1_tmp[12:0] = mem1_rgt[12:0]
//	       	way0_tmp[13]    = red_bit_rgt     (redundancy bit)	
//	Shift mem1_rgt[n] -> mem0_rgt[n] , shift mem0_rgt[n]->men1_rgt[n+1]
// 			 mem0_rgt[0]->redundancy bit = red_bit_rgt.
//
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// recover the shift index from rpda, rpdb, rpdc
//-----------------------------------------------------------------
assign  sf_l[4]				= rpda_lft[1] ;
assign  sf_l[3:2]			= rpdb_lft[3] ? 2'b11 :
					  rpdb_lft[2] ? 2'b10 :
					  rpdb_lft[1] ? 2'b01 : 
					  2'b00;
assign  sf_l[1:0]			= rpdc_lft[3] ? 2'b11 :
					  rpdc_lft[2] ? 2'b10 :
					  rpdc_lft[1] ? 2'b01 : 
					  2'b00;

assign  sf_r[4]				= rpda_rgt[1] ;
assign  sf_r[3:2]			= rpdb_rgt[3] ? 2'b11 :
					  rpdb_rgt[2] ? 2'b10 :
					  rpdb_rgt[1] ? 2'b01 : 
					  2'b00;
assign  sf_r[1:0]			= rpdc_rgt[3] ? 2'b11 :
					  rpdc_rgt[2] ? 2'b10 :
					  rpdc_rgt[1] ? 2'b01 : 
					  2'b00;

assign  shift_en_lft			= (sf_l[4:0] < 5'd30) ? (|rpda_lft[1:0]) && (|rpdb_lft[3:0]) && (|rpdc_lft[3:0]) : 1'b0;
assign  shift_en_rgt			= (sf_r[4:0] < 5'd26) ? (|rpda_rgt[1:0]) && (|rpdb_rgt[3:0]) && (|rpdc_rgt[3:0]) : 1'b0;

assign  redundancy_en			= shift_en_lft || shift_en_rgt;

assign  sh_index_lft[4:0]		= shift_en_lft && (sf_l[4:0] < 5'd30) ? sf_l[4:0] : 5'b00000;
assign  sh_index_rgt[4:0]		= shift_en_rgt && (sf_r[4:0] < 5'd26) ? sf_r[4:0] : 5'b00000;



//-----------------------------------------------------------------
//		Write Arrays 
//-----------------------------------------------------------------


//--------------------------------------
//  Write Redundancy Mapping
//--------------------------------------
// Shifting of redundancy base on the sh_index_lft and sh_index_rgt

wire [14:0]	din_lft 	;
wire [0:12]	din_rgt 	;
assign din_lft[14:0]	= din[27:13];
assign din_rgt[0:12]	= din[12:0];

// Add vnw_high check for write operation (implemented for n2_to_2.0)

assign mem_wr_en0	= wr_way_b[0] &&   wr_en_b && ~rd_en_b && w_inhibit_l && wr_en_d1_a && vnw_ary;
assign mem_wr_en1	= wr_way_b[1] &&   wr_en_b && ~rd_en_b && w_inhibit_l && wr_en_d1_a && vnw_ary;




//-------left-------
always @ (sh_index_lft or  din_lft[14:0] or shift_en_lft or mem_wr_en0 or mem_wr_en1 
	  or l1clk_int or  addr_b[8:0] )


    #0

begin 


  mem_lft_reg[`L2T_ARR_D_WIDTH + 2:0] = mem_lft[addr_b] ;



// Write to redundant bit in write cycle for way0 with no redundancy
   if (l1clk_int && (~shift_en_lft) && mem_wr_en0) 
      begin	
          mem_lft_reg[0]      = din_lft[0];	
      end	  

  for (i=14; i >= 0; i=i-1)
  begin
    if (mem_wr_en0 && l1clk_int)		//way0
      begin
        if (( sh_index_lft < (2*i)) || ~shift_en_lft)
          mem_lft_reg[2*i+1]  = din_lft[i];	//no shift
	else
	 begin
          mem_lft_reg[2*i]  = din_lft[i];	// shift
	 end
      end
	  if(shift_en_lft)        
          mem_lft_reg[sh_index_lft+1]  = 1'bx;	// write "x" to bad bit
   end	//for   
	   
  for (i=14; i >= 0; i=i-1)
  begin
    if (mem_wr_en1 && l1clk_int )		//way1
      begin
        if (( sh_index_lft < (2*i + 1)) || ~shift_en_lft)
          mem_lft_reg[2*i+2]  = din_lft[i];	//no shift
	else
	begin
          mem_lft_reg[2*i+1]  = din_lft[i];	//shift
	end
      end
	  if(shift_en_lft)        
          mem_lft_reg[sh_index_lft+1]  = 1'bx;  //write "x" to bad bit 
  end	   

  if (l1clk_int)  mem_lft[addr_b] =  mem_lft_reg[`L2T_ARR_D_WIDTH + 2:0] ;


end

//-------right-------

always @ (sh_index_rgt or  din_rgt[0:12] or shift_en_rgt or mem_wr_en0 or mem_wr_en1 
	  or l1clk_int or  addr_b[8:0] )


    #0

begin 

  mem_rgt_reg[0 : `L2T_ARR_D_WIDTH - 2]  = mem_rgt[addr_b];



// Write to redundant bit in write cycle for way0 with no redundancy
   if (l1clk_int && (~shift_en_rgt) && mem_wr_en0) 
      begin	
          mem_rgt_reg[0]      = din_rgt[0];	
      end	  

  for (k=12; k >= 0; k=k-1)
  begin
    if (mem_wr_en0 && l1clk_int)		//WAY0
      begin
        if (( sh_index_rgt < (2*k )) || ~shift_en_rgt)
          mem_rgt_reg[2*k+1]  = din_rgt[k];	//no shift
	else
	 begin
          mem_rgt_reg[2*k]  = din_rgt[k];	// shift
	 end
      end
	  if(shift_en_rgt)        
          mem_rgt_reg[sh_index_rgt+1]   = 1'bx; // Write "X" to the bad bit
   end	//for   
	   
  for (k=12; k >= 0; k=k-1)
  begin
    if (mem_wr_en1 && l1clk_int )		//WAY1
      begin
        if (( sh_index_rgt < (2*k + 1)) || ~shift_en_rgt)
          mem_rgt_reg[2*k+2]  = din_rgt[k];	//no shift
	else
	 begin
          mem_rgt_reg[2*k+1]  = din_rgt[k];	// shift
	  end
      end
	  if(shift_en_rgt)        
          mem_rgt_reg[sh_index_rgt+1]   = 1'bx; // Write "X" to the bad bit
  end  //for	   

  if (l1clk_int) mem_rgt[addr_b] =  mem_rgt_reg[0 : `L2T_ARR_D_WIDTH - 2] ;



end

//-----------------------------------------------------------------
//		Read Arrays 
//-----------------------------------------------------------------

//--------------------------------------
//  Read Redundancy Mapping
//--------------------------------------


//---------Left--------------
always @ (sh_index_lft or  shift_en_lft or rd_en or l1clk_int or  addr_b[8:0] )
begin 	
  if (l1clk_int)		
  begin
  
    mem_data_lft[`L2T_ARR_D_WIDTH + 2:0] = ~rd_en ? 31'hx : mem_lft[addr_b] ;
  
  end


  if (rd_en && ~l1clk_int)


  begin	  

    for (j=14; j >= 0; j=j-1)	//WAY0	
    begin
        if (( sh_index_lft < (2*j )) || ~shift_en_lft)
	  rdata0_lft[j]	      	= mem_data_lft[2*j+1];  // no shift
	else
          rdata0_lft[j]  	= mem_data_lft[2*j];	// shift
     end	//for   
	   
    for (j=14; j >= 0; j=j-1)	//WAY1
      begin
        if (( sh_index_lft < (2*j + 1)) || ~shift_en_lft)
          rdata1_lft[j]  = mem_data_lft[2*j+2];	//no shift
	else
          rdata1_lft[j]  = mem_data_lft[2*j+1];	// shift
      end
      sao_mx0_h[27:13] =  rdata0_lft[14:0]  & {15{rd_en}};
      sao_mx0_l[27:13] = ~rdata0_lft[14:0]  & {15{rd_en}};
      sao_mx1_h[27:13] =  rdata1_lft[14:0]  & {15{rd_en}};
      sao_mx1_l[27:13] = ~rdata1_lft[14:0]  & {15{rd_en}};
  end	   
 else if(l1clk_int || ~rd_en)
	begin
`ifdef L2TAG_SRLATCH_RETURNTOZERO
		sao_mx0_h[27:13] = 15'h0;
      	sao_mx0_l[27:13] = 15'hFFFF;
      	sao_mx1_h[27:13] = 15'h0;
      	sao_mx1_l[27:13] = 15'hFFFF;
`else		
		sao_mx0_h[27:13] = 15'h0;
      	sao_mx0_l[27:13] = 15'h0;
      	sao_mx1_h[27:13] = 15'h0;
      	sao_mx1_l[27:13] = 15'h0;
`endif
	end
end

//---------Right--------------

always @ (sh_index_rgt or  shift_en_rgt or rd_en or l1clk_int or  addr_b[8:0] )
	  
begin 	
  if (l1clk_int)		
  begin

    mem_data_rgt[0: `L2T_ARR_D_WIDTH - 2] = ~rd_en ? 27'hx : mem_rgt[addr_b] ;

  end 


  if (rd_en && ~l1clk_int)


    begin

    for (l=12; l >= 0; l=l-1)	//WAY0	
    begin
        if (( sh_index_rgt < (2*l)) || ~shift_en_rgt)
	  rdata0_rgt[l]	      	= mem_data_rgt[2*l+1];  // no shift
	else
          rdata0_rgt[l]  	= mem_data_rgt[2*l];	// shift
     end	//for   
	   
    for (l=12; l >= 0; l=l-1)	//WAY1
      begin
        if (( sh_index_rgt < (2*l + 1)) || ~shift_en_rgt)
          rdata1_rgt[l]  = mem_data_rgt[2*l+2];	//no shift
	else
          rdata1_rgt[l]  = mem_data_rgt[2*l+1];	// shift
      end
         sao_mx0_h[12:0] =  rdata0_rgt[0:12]  & {13{rd_en}};
         sao_mx0_l[12:0] = ~rdata0_rgt[0:12]  & {13{rd_en}};
         sao_mx1_h[12:0] =  rdata1_rgt[0:12]  & {13{rd_en}};
         sao_mx1_l[12:0] = ~rdata1_rgt[0:12]  & {13{rd_en}};
  end	   
  else if (l1clk_int || ~rd_en)
        begin
`ifdef L2TAG_SRLATCH_RETURNTOZERO
        sao_mx0_h[12:0] = 13'h0;
        sao_mx0_l[12:0] = 13'hFFFF;
        sao_mx1_h[12:0] = 13'h0;
        sao_mx1_l[12:0] = 13'hFFFF;
`else
        sao_mx0_h[12:0] = 13'h0;
        sao_mx0_l[12:0] = 13'h0;
        sao_mx1_h[12:0] = 13'h0;
        sao_mx1_l[12:0] = 13'h0;
`endif
       end
end


endmodule


//////////////////////////////////////////
////// n2_l2d_sp_512kb_cust   
/////////////////////////////////////////

module n2_l2d_16kb_cust (
  waysel_c4, 
  waysel_err_c3, 
  set_c3b, 
  coloff_c3b_l, 
  coloff_c4_l, 
  coloff_c5, 
  wen_c3b, 
  readen_c5, 
  worden_c3b, 
  l1clk, 
  wrd_lo0_b_l, 
  wrd_lo1_b_l, 
  wrd_hi0_b_l, 
  wrd_hi1_b_l, 
  red_adr, 
  cred, 
  tstmodclk_l, 
  wee_l, 
  vnw_ary, 
  saout_lo0_bc_l, 
  saout_lo1_bc_l, 
  saout_hi0_bc_l, 
  saout_hi1_bc_l);
wire coloff_c3b_l_unused;
wire bank_select;
wire coloff_c4;
wire [7:0] set_c4;
wire [1:0] spare_word_enable;
wire select_red_odd;
wire select_red_even;

	
		
input [7:0] 	waysel_c4;		
input		waysel_err_c3;		// 	Active when multiple way sel is on
input [8:0]   	set_c3b;		//	After b-latch
input    	coloff_c3b_l;		//	After b-latch+inv
input    	coloff_c4_l;		//	stage+inv
input [1:0]   	coloff_c5;		//	2-stage
input         	wen_c3b;	 	//	Write-enable, after b-latch
input         	readen_c5;	 	//	
input [3:0]   	worden_c3b;		//	After b-latch
input         	l1clk;	 		//	After l1clk hdr
input [19:0]  	wrd_lo0_b_l;		//	
input [18:0]  	wrd_lo1_b_l;		//	
input [19:0]  	wrd_hi0_b_l;		//	
input [18:0]  	wrd_hi1_b_l;		//	
input [9:0]	red_adr;		// Redudancy address
input [77:0]	cred;			// Redudancy address
input		tstmodclk_l;		//NEW
input		wee_l;			//NEW
input           vnw_ary;                //NEW

//output		bnken_lat;	//	Address latch enable (1.5cycle)
output [19:0]  	saout_lo0_bc_l;		//	C5bc output from senseamp
output [18:0]  	saout_lo1_bc_l;		//	C5bc output from senseamp
output [19:0]  	saout_hi0_bc_l;		//	C5bc output from senseamp
output [18:0]  	saout_hi1_bc_l;		//	C5bc output from senseamp

//reg		rd_data_out_sel_c5b;
//reg select_read_data_c5b;
reg select_read_data_c5b_hi_rgt;
reg select_read_data_c5b_hi_lft;
reg select_read_data_c5b_lo_rgt;
reg select_read_data_c5b_lo_lft;
reg select_read_data_all_c5b;
reg select_read_red_all_c5b;

//reg select_read_red_c5b;
reg select_read_red_c5b_hi_rgt;
reg select_read_red_c5b_hi_lft;
reg select_read_red_c5b_lo_rgt;
reg select_read_red_c5b_lo_lft;

//reg    	bnken_lat;

reg [19:0]    saout_lo0_bc_l;         //      C5bc output from senseamp
reg [18:0]    saout_lo1_bc_l;         //      C5bc output from senseamp
reg [19:0]    saout_hi0_bc_l;         //      C5bc output from senseamp
reg [18:0]    saout_hi1_bc_l;         //      C5bc output from senseamp

reg [79:0]    read_data;
wire [79:0]    rd_data;
wire [79:0]    wr_data;
reg	rd_spare_0,rd_spare_1;
wire    wr_spare_0,wr_spare_1;

wire [19:0] saout_hi0_b_out_l, saout_lo0_b_out_l;
wire [18:0] saout_hi1_b_out_l, saout_lo1_b_out_l;
wire [19:0]     red_lo0_b_out_l;
wire [18:0]     red_lo1_b_out_l;
wire [19:0]     red_hi0_b_out_l;
wire [18:0]     red_hi1_b_out_l;

wire [1:0] coloff_c5_rgt;
wire [1:0] coloff_c5_lft;
wire	   red_sel_rgt;
wire	   red_sel_lft;




reg  [19:0] mem_lo0_way0 [255:0];
reg  [18:0] mem_lo1_way0 [255:0];
reg  [19:0] mem_hi0_way0 [255:0];
reg  [18:0] mem_hi1_way0 [255:0];
reg  [255:0] mem_way0_spare_0;
reg  [255:0] mem_way0_spare_1;

reg  [19:0] mem_lo0_way1 [255:0];
reg  [18:0] mem_lo1_way1 [255:0];
reg  [19:0] mem_hi0_way1 [255:0];
reg  [18:0] mem_hi1_way1 [255:0];
reg  [255:0] mem_way1_spare_0;
reg  [255:0] mem_way1_spare_1;

reg  [19:0] mem_lo0_way2 [255:0];
reg  [18:0] mem_lo1_way2 [255:0];
reg  [19:0] mem_hi0_way2 [255:0];
reg  [18:0] mem_hi1_way2 [255:0];
reg  [255:0] mem_way2_spare_0;
reg  [255:0] mem_way2_spare_1;


reg  [19:0] mem_lo0_way3 [255:0];
reg  [18:0] mem_lo1_way3 [255:0];
reg  [19:0] mem_hi0_way3 [255:0];
reg  [18:0] mem_hi1_way3 [255:0];
reg  [255:0] mem_way3_spare_0;
reg  [255:0] mem_way3_spare_1;


reg  [19:0] mem_lo0_way4 [255:0];
reg  [18:0] mem_lo1_way4 [255:0];
reg  [19:0] mem_hi0_way4 [255:0];
reg  [18:0] mem_hi1_way4 [255:0];
reg  [255:0] mem_way4_spare_0;
reg  [255:0] mem_way4_spare_1;


reg  [19:0] mem_lo0_way5 [255:0];
reg  [18:0] mem_lo1_way5 [255:0];
reg  [19:0] mem_hi0_way5 [255:0];
reg  [18:0] mem_hi1_way5 [255:0];
reg  [255:0] mem_way5_spare_0;
reg  [255:0] mem_way5_spare_1;


reg  [19:0] mem_lo0_way6 [255:0];
reg  [18:0] mem_lo1_way6 [255:0];
reg  [19:0] mem_hi0_way6 [255:0];
reg  [18:0] mem_hi1_way6 [255:0];
reg  [255:0] mem_way6_spare_0;
reg  [255:0] mem_way6_spare_1;


reg  [19:0] mem_lo0_way7 [255:0];
reg  [18:0] mem_lo1_way7 [255:0];
reg  [19:0] mem_hi0_way7 [255:0];
reg  [18:0] mem_hi1_way7 [255:0];
reg  [255:0] mem_way7_spare_0;
reg  [255:0] mem_way7_spare_1;

//reg    	bnken_lat_c52;
reg [19:0]    saout_lo0_bc;         //      C5bc output from senseamp
reg [18:0]    saout_lo1_bc;         //      C5bc output from senseamp
reg [19:0]    saout_hi0_bc;         //      C5bc output from senseamp
reg [18:0]    saout_hi1_bc;         //      C5bc output from senseamp


//reg [19:0]    saout_lo0_bc_d;         //      C5bc output from senseamp
//reg [18:0]    saout_lo1_bc_d;         //      C5bc output from senseamp
//reg [19:0]    saout_hi0_bc_d;         //      C5bc output from senseamp
//reg [18:0]    saout_hi1_bc_d;         //      C5bc output from senseamp

//reg	set_banken_lat, reset_banken_lat;

reg [19:0]       saout_lo0_bc_c5b_l;
reg [18:0]       saout_lo1_bc_c5b_l;
reg [19:0]       saout_hi0_bc_c5b_l;
reg [18:0]       saout_hi1_bc_c5b_l;

reg [19:0]       saout_lo0_bc_d_l;
reg [18:0]       saout_lo1_bc_d_l;
reg [19:0]       saout_hi0_bc_d_l;
reg [18:0]       saout_hi1_bc_d_l;


assign coloff_c3b_l_unused = coloff_c3b_l;


//always@(posedge l1clk)
//begin
//        if(~coloff_c3b_l)
//                set_banken_lat <= 1'b1;
//        else    set_banken_lat <= 1'b0;
//end
//
//always@(negedge l1clk)
//begin
//        if(coloff_c4_l)
//                reset_banken_lat  <= 1'b1;
//        else    reset_banken_lat  <= 1'b0;
//end
//
//always@(set_banken_lat or reset_banken_lat)
//begin
//        if(set_banken_lat )
//                bnken_lat       <=      1'b1;
//        else if(reset_banken_lat )
//                bnken_lat       <=      1'b0;
//end


reg	[7:0] waysel_c5;
reg	[8:0]	index_c4;
reg	[8:0]	set_c5;
reg	wen_c4; 
reg	[3:0]	worden_c4;



reg	bank_select_c5;
reg     waysel_err_c3b, waysel_err_c4,waysel_err_c5;

always@(l1clk or coloff_c4_l)
begin
        if(~l1clk & coloff_c4_l)
	waysel_err_c3b	<=	waysel_err_c3;
end





always@(posedge l1clk)
begin
	waysel_err_c4	<=	waysel_err_c3b;
	waysel_err_c5	<=	waysel_err_c4;
	waysel_c5[7:0]	<=	waysel_c4[7:0];
	index_c4[8:0]	<=	set_c3b[8:0];
	set_c5[8:0]	<=	index_c4[8:0];
	worden_c4[3:0]	<=	worden_c3b[3:0];
	wen_c4		<=	wen_c3b;
	bank_select_c5  <= 	bank_select;
end


assign coloff_c4 = ~coloff_c4_l;
assign bank_select = index_c4[8];

//reg	[19:0]	saout_lo0_bc_c5b;
//reg	[18:0]	saout_lo1_bc_c5b;
//reg	[19:0]	saout_hi0_bc_c5b;
//reg	[18:0]	saout_hi1_bc_c5b;






assign set_c4[7:0] = index_c4[7:0];
wire	[19:0] wrd_lo0_a;
wire	[19:0] wrd_hi0_a;
wire	[18:0] wrd_lo1_a;
wire	[18:0] wrd_hi1_a;

reg	[19:0] wrd_lo0_a_reg;
reg	[19:0] wrd_hi0_a_reg;
reg	[18:0] wrd_lo1_a_reg;
reg	[18:0] wrd_hi1_a_reg;


always@(posedge l1clk)
begin
wrd_lo0_a_reg[19:0] <= ~wrd_lo0_b_l[19:0];
wrd_hi0_a_reg[19:0] <= ~wrd_hi0_b_l[19:0];
wrd_lo1_a_reg[18:0] <= ~wrd_lo1_b_l[18:0];
wrd_hi1_a_reg[18:0] <= ~wrd_hi1_b_l[18:0];
end



// COL redudancy

//reg [255:0] red_reg1;
//reg [255:0] red_reg2;

wire [79:0] cred_mod;


assign cred_mod[79:0] = {cred[77:59],1'b0,cred[58:19],1'b0,cred[18:0]};


//assign spare_word_enable[1] = cred_mod[19] ? worden_c4[3] : worden_c4[2]; 
//assign spare_word_enable[0] = cred_mod[59] ? worden_c4[3] : worden_c4[2];


assign wr_data[19:0] = 
{wr_spare_0,	  wrd_lo1_a_reg[4], wrd_hi0_a_reg[4],wrd_lo0_a_reg[4],
wrd_hi1_a_reg[3], wrd_lo1_a_reg[3], wrd_hi0_a_reg[3],wrd_lo0_a_reg[3],
wrd_hi1_a_reg[2], wrd_lo1_a_reg[2], wrd_hi0_a_reg[2],wrd_lo0_a_reg[2],
wrd_hi1_a_reg[1], wrd_lo1_a_reg[1], wrd_hi0_a_reg[1],wrd_lo0_a_reg[1],
wrd_hi1_a_reg[0], wrd_lo1_a_reg[0], wrd_hi0_a_reg[0],wrd_lo0_a_reg[0]};

assign wr_data[39:20] = {
		  wrd_lo1_a_reg[9], wrd_hi0_a_reg[9],wrd_lo0_a_reg[9],
wrd_hi1_a_reg[8], wrd_lo1_a_reg[8], wrd_hi0_a_reg[8],wrd_lo0_a_reg[8],
wrd_hi1_a_reg[7], wrd_lo1_a_reg[7], wrd_hi0_a_reg[7],wrd_lo0_a_reg[7],
wrd_hi1_a_reg[6], wrd_lo1_a_reg[6], wrd_hi0_a_reg[6],wrd_lo0_a_reg[6],
wrd_hi1_a_reg[5], wrd_lo1_a_reg[5], wrd_hi0_a_reg[5],wrd_lo0_a_reg[5], wrd_hi1_a_reg[4]};


assign wr_data[59:40] = {
wrd_lo1_a_reg[14], wrd_hi0_a_reg[14],wrd_lo0_a_reg[14],
wrd_hi1_a_reg[13], wrd_lo1_a_reg[13], wrd_hi0_a_reg[13],wrd_lo0_a_reg[13],
wrd_hi1_a_reg[12], wrd_lo1_a_reg[12], wrd_hi0_a_reg[12],wrd_lo0_a_reg[12],
wrd_hi1_a_reg[11], wrd_lo1_a_reg[11], wrd_hi0_a_reg[11],wrd_lo0_a_reg[11],
wrd_hi1_a_reg[10], wrd_lo1_a_reg[10], wrd_hi0_a_reg[10],wrd_lo0_a_reg[10], wrd_hi1_a_reg[9]};

assign wr_data[79:60] = {
wrd_hi0_a_reg[19], wrd_lo0_a_reg[19],
wrd_hi1_a_reg[18], wrd_lo1_a_reg[18], wrd_hi0_a_reg[18],wrd_lo0_a_reg[18],
wrd_hi1_a_reg[17], wrd_lo1_a_reg[17], wrd_hi0_a_reg[17],wrd_lo0_a_reg[17],
wrd_hi1_a_reg[16], wrd_lo1_a_reg[16], wrd_hi0_a_reg[16],wrd_lo0_a_reg[16],
wrd_hi1_a_reg[15], wrd_lo1_a_reg[15], wrd_hi0_a_reg[15],wrd_lo0_a_reg[15], wrd_hi1_a_reg[14],wr_spare_1};


integer i; 
reg	[80:0] data;

always@(cred_mod or wr_data)
begin
if (~cred_mod[0]) begin
 data[0] = wr_data[0];
end

for(i=0; i<18; i=i+1)
begin
  data[i+1] = cred_mod[i] ? wr_data[i] : wr_data[i+1];
end

data[19] = cred_mod[18] ? wr_data[18] : cred_mod[20] ? wr_data[20] : 1'b0;

for(i=21;i<40;i=i+1)
begin 
 data[i-1] = cred_mod[i] ? wr_data[i] : wr_data[i-1];
end


if (~cred_mod[39]) begin
 data[39] = wr_data[39];
end

if (~cred_mod[40]) begin
 data[40] = wr_data[40];
end

for(i=40;i<59;i=i+1)
begin
  data[i+1] = cred_mod[i] ? wr_data[i] : wr_data[i+1];
end

data[60] = cred_mod[59] ? wr_data[59] : cred_mod[61] ? wr_data[61] : 1'b0;

for(i=62;i<80;i=i+1)
begin
  data[i-1] = cred_mod[i] ? wr_data[i] : wr_data[i-1];
end

if (~cred_mod[79]) begin
 data[79] = wr_data[79];
end 
 
end

 
assign { wrd_hi0_a[19], wrd_lo0_a[19],
wrd_hi1_a[18], wrd_lo1_a[18], wrd_hi0_a[18],wrd_lo0_a[18],
wrd_hi1_a[17], wrd_lo1_a[17], wrd_hi0_a[17],wrd_lo0_a[17],
wrd_hi1_a[16], wrd_lo1_a[16], wrd_hi0_a[16],wrd_lo0_a[16],
wrd_hi1_a[15], wrd_lo1_a[15], wrd_hi0_a[15],wrd_lo0_a[15], 
wrd_hi1_a[14],wr_spare_1} = data[79:60];

assign {
wrd_lo1_a[14], wrd_hi0_a[14],wrd_lo0_a[14],
wrd_hi1_a[13], wrd_lo1_a[13], wrd_hi0_a[13],wrd_lo0_a[13],
wrd_hi1_a[12], wrd_lo1_a[12], wrd_hi0_a[12],wrd_lo0_a[12],
wrd_hi1_a[11], wrd_lo1_a[11], wrd_hi0_a[11],wrd_lo0_a[11],
wrd_hi1_a[10], wrd_lo1_a[10], wrd_hi0_a[10],wrd_lo0_a[10],wrd_hi1_a[9]} = data[59:40];

assign {
wrd_lo1_a[9], wrd_hi0_a[9],wrd_lo0_a[9],
wrd_hi1_a[8], wrd_lo1_a[8], wrd_hi0_a[8],wrd_lo0_a[8],
wrd_hi1_a[7], wrd_lo1_a[7], wrd_hi0_a[7],wrd_lo0_a[7],
wrd_hi1_a[6], wrd_lo1_a[6], wrd_hi0_a[6],wrd_lo0_a[6],
wrd_hi1_a[5], wrd_lo1_a[5], wrd_hi0_a[5],wrd_lo0_a[5], wrd_hi1_a[4]} = data[39:20];

assign {
wr_spare_0,   wrd_lo1_a[4], wrd_hi0_a[4],wrd_lo0_a[4],
wrd_hi1_a[3], wrd_lo1_a[3], wrd_hi0_a[3],wrd_lo0_a[3],
wrd_hi1_a[2], wrd_lo1_a[2], wrd_hi0_a[2],wrd_lo0_a[2],
wrd_hi1_a[1], wrd_lo1_a[1], wrd_hi0_a[1],wrd_lo0_a[1],
wrd_hi1_a[0], wrd_lo1_a[0], wrd_hi0_a[0],wrd_lo0_a[0]} = data[19:0];



wire [79:0] worden_data;
wire [19:0] worden_lo0;
wire [19:0] worden_hi0;
wire [18:0] worden_lo1;
wire [18:0] worden_hi1;


assign worden_data[19:0] = 
{spare_word_enable[0],  worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0]};

assign worden_data[39:20] = {
	      worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0], worden_c4[3]};


assign worden_data[59:40] = {
              worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0], worden_c4[3]};

assign worden_data[79:60] = {
                            worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0],
worden_c4[3], worden_c4[2], worden_c4[1],worden_c4[0], worden_c4[3],spare_word_enable[1]};

reg	[79:0] worden_shift;



always@(cred_mod or worden_data or wen_c4 or coloff_c4)
begin
if (wen_c4 & coloff_c4)
begin
if (~cred_mod[0]) begin
 worden_shift[0] = worden_data[0];
end

for(i=0; i<18; i=i+1)
begin
  worden_shift[i+1] = cred_mod[i] ? worden_data[i] : ~cred_mod[i+1] ? worden_data[i+1] : 1'b0;
end

worden_shift[19] = cred_mod[18] ? worden_data[18] : cred_mod[20] ? worden_data[20] : 1'b0;

for(i=21;i<40;i=i+1)
begin 
 worden_shift[i-1]  = cred_mod[i] ? worden_data[i] : ~cred_mod[i-1] ? worden_data[i-1] : 1'b0;
end


if (~cred_mod[39]) begin
 worden_shift[39] = worden_data[39];
end

if (~cred_mod[40]) begin
 worden_shift[40] = worden_data[40];
end

for(i=40;i<59;i=i+1)
begin
  worden_shift[i+1] = cred_mod[i] ? worden_data[i] : ~cred_mod[i+1] ? worden_data[i+1] : 1'b0;
end

worden_shift[60] = cred_mod[59] ? worden_data[59] : cred_mod[61] ? worden_data[61] : 1'b0;

for(i=62;i<80;i=i+1)
begin
  worden_shift[i-1]  = cred_mod[i] ? worden_data[i] : ~cred_mod[i-1] ? worden_data[i-1] : 1'b0;
end

if (~cred_mod[79]) begin
 worden_shift[79] = worden_data[79];
end 

end
else worden_shift[79:0] = 80'b0;

end
 
 
assign { worden_hi0[19], worden_lo0[19],
worden_hi1[18], worden_lo1[18], worden_hi0[18],worden_lo0[18],
worden_hi1[17], worden_lo1[17], worden_hi0[17],worden_lo0[17],
worden_hi1[16], worden_lo1[16], worden_hi0[16],worden_lo0[16],
worden_hi1[15], worden_lo1[15], worden_hi0[15],worden_lo0[15], 
worden_hi1[14],spare_word_enable[1]} = worden_shift[79:60];

assign {
worden_lo1[14], worden_hi0[14],worden_lo0[14],
worden_hi1[13], worden_lo1[13], worden_hi0[13],worden_lo0[13],
worden_hi1[12], worden_lo1[12], worden_hi0[12],worden_lo0[12],
worden_hi1[11], worden_lo1[11], worden_hi0[11],worden_lo0[11],
worden_hi1[10], worden_lo1[10], worden_hi0[10],worden_lo0[10],worden_hi1[9]} = worden_shift[59:40];

assign {
worden_lo1[9], worden_hi0[9],worden_lo0[9],
worden_hi1[8], worden_lo1[8], worden_hi0[8],worden_lo0[8],
worden_hi1[7], worden_lo1[7], worden_hi0[7],worden_lo0[7],
worden_hi1[6], worden_lo1[6], worden_hi0[6],worden_lo0[6],
worden_hi1[5], worden_lo1[5], worden_hi0[5],worden_lo0[5], worden_hi1[4]} = worden_shift[39:20];

assign {
spare_word_enable[0],   worden_lo1[4], worden_hi0[4],worden_lo0[4],
worden_hi1[3], worden_lo1[3], worden_hi0[3],worden_lo0[3],
worden_hi1[2], worden_lo1[2], worden_hi0[2],worden_lo0[2],
worden_hi1[1], worden_lo1[1], worden_hi0[1],worden_lo0[1],
worden_hi1[0], worden_lo1[0], worden_hi0[0],worden_lo0[0]} = worden_shift[19:0];


















always@(l1clk or wen_c4 or set_c4 or waysel_c4 or  waysel_err_c4 or worden_c4 or wrd_lo0_a or 
	wrd_hi0_a or wrd_lo1_a or wrd_hi1_a or coloff_c4 or bank_select  or wr_spare_0 or 
	wr_spare_1 or wee_l or worden_hi0 or worden_lo0 or worden_lo1 or worden_hi1 or spare_word_enable
        or vnw_ary)
begin

////////////////////////////////////////////////////////////////
// Read all entries for a given set 
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
//  Write data computation
////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
// Write to memory
//////////////////////////////////////////////////////////////



    #0


//if(wen_c4  & ~waysel_err_c4 & bank_select & coloff_c4 & (|worden_c4))
if(~l1clk & wee_l & wen_c4  & ~waysel_err_c4 & bank_select & coloff_c4 & (|worden_c4) & vnw_ary)
begin
	if(waysel_c4[0])
	begin
	mem_lo0_way0[set_c4]   = (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way0[set_c4]);
	mem_hi0_way0[set_c4]   = (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way0[set_c4]);
	mem_lo1_way0[set_c4]   = (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way0[set_c4]);
	mem_hi1_way0[set_c4]   = (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way0[set_c4]);
	mem_way0_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way0_spare_0[set_c4]);
	mem_way0_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way0_spare_1[set_c4]);
	end
	else if(waysel_c4[1])
	begin
	mem_lo0_way1[set_c4]   =  (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way1[set_c4]);
	mem_hi0_way1[set_c4]   =  (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way1[set_c4]);
	mem_lo1_way1[set_c4]   =  (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way1[set_c4]);
	mem_hi1_way1[set_c4]   =  (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way1[set_c4]);
	mem_way1_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way1_spare_0[set_c4]);
	mem_way1_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way1_spare_1[set_c4]);
	end
	else if(waysel_c4[2])
	begin
	mem_lo0_way2[set_c4]   =  (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way2[set_c4]);
	mem_lo1_way2[set_c4]   =  (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way2[set_c4]);
	mem_hi0_way2[set_c4]   =  (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way2[set_c4]);
	mem_hi1_way2[set_c4]   =  (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way2[set_c4]);
	mem_way2_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way2_spare_0[set_c4]);
	mem_way2_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way2_spare_1[set_c4]);
	end
	else if(waysel_c4[3])
	begin
	mem_lo0_way3[set_c4]   = (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way3[set_c4]);
	mem_lo1_way3[set_c4]   = (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way3[set_c4]);
	mem_hi0_way3[set_c4]   = (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way3[set_c4]);
	mem_hi1_way3[set_c4]   = (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way3[set_c4]);
	mem_way3_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way3_spare_0[set_c4]);
	mem_way3_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way3_spare_1[set_c4]);
	end
	else if(waysel_c4[4])
	begin
	mem_lo0_way4[set_c4]   = (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way4[set_c4]);
	mem_lo1_way4[set_c4]   = (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way4[set_c4]);
	mem_hi0_way4[set_c4]   = (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way4[set_c4]);
	mem_hi1_way4[set_c4]   = (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way4[set_c4]);
	mem_way4_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way4_spare_0[set_c4]);
	mem_way4_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way4_spare_1[set_c4]);
	end
	else if(waysel_c4[5])
	begin
	mem_lo0_way5[set_c4]   =(worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way5[set_c4]);
	mem_lo1_way5[set_c4]   =(worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way5[set_c4]);
	mem_hi0_way5[set_c4]   =(worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way5[set_c4]);
	mem_hi1_way5[set_c4]   =(worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way5[set_c4]);
	mem_way5_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way5_spare_0[set_c4]);
	mem_way5_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way5_spare_1[set_c4]);
	end
	else if(waysel_c4[6])
	begin
	mem_lo0_way6[set_c4]   =(worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way6[set_c4]);
	mem_lo1_way6[set_c4]   =(worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way6[set_c4]);
	mem_hi0_way6[set_c4]   =(worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way6[set_c4]);
	mem_hi1_way6[set_c4]   =(worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way6[set_c4]);
	mem_way6_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way6_spare_0[set_c4]);
	mem_way6_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way6_spare_1[set_c4]);
	end
	else if(waysel_c4[7])
	begin
	mem_lo0_way7[set_c4]   =(worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & mem_lo0_way7[set_c4]);
	mem_lo1_way7[set_c4]   =(worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & mem_lo1_way7[set_c4]);
	mem_hi0_way7[set_c4]   =(worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & mem_hi0_way7[set_c4]);
	mem_hi1_way7[set_c4]   =(worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & mem_hi1_way7[set_c4]);
	mem_way7_spare_0[set_c4] = (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & mem_way7_spare_0[set_c4]);
	mem_way7_spare_1[set_c4] = (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & mem_way7_spare_1[set_c4]);
	end
  end
end

//always@(waysel_c4 or set_c4 or bnken_lat )
always@(waysel_c4 or set_c4 or coloff_c4_l or vnw_ary)

begin


    #0

if(~coloff_c4_l & vnw_ary)
begin
	if(waysel_c4[0])
		begin
		saout_lo0_bc[19:0]	<=	mem_lo0_way0[set_c4];
		saout_lo1_bc[18:0]	<=	mem_lo1_way0[set_c4];
		saout_hi0_bc[19:0]	<=	mem_hi0_way0[set_c4];
		saout_hi1_bc[18:0]	<=	mem_hi1_way0[set_c4];
 		rd_spare_0		<=	mem_way0_spare_0[set_c4];
 		rd_spare_1		<=	mem_way0_spare_1[set_c4];
		end
	else if(waysel_c4[1])
		begin
		saout_lo0_bc[19:0]	<=	mem_lo0_way1[set_c4];	
		saout_lo1_bc[18:0]	<=	mem_lo1_way1[set_c4];	
		saout_hi0_bc[19:0]	<=	mem_hi0_way1[set_c4];	
		saout_hi1_bc[18:0]	<=	mem_hi1_way1[set_c4];	
 		rd_spare_0		<=	mem_way1_spare_0[set_c4];
 		rd_spare_1		<=	mem_way1_spare_1[set_c4];
		end
	else if(waysel_c4[2])
		begin
		saout_lo0_bc[19:0]	<=	mem_lo0_way2[set_c4];	
		saout_lo1_bc[18:0]	<=	mem_lo1_way2[set_c4];	
		saout_hi0_bc[19:0]	<=	mem_hi0_way2[set_c4];	
		saout_hi1_bc[18:0]	<=	mem_hi1_way2[set_c4];	
 		rd_spare_0		<=	mem_way2_spare_0[set_c4];
 		rd_spare_1		<=	mem_way2_spare_1[set_c4];
		end
	else if(waysel_c4[3])
		begin
		saout_lo0_bc[19:0]	<=	mem_lo0_way3[set_c4];	
		saout_lo1_bc[18:0]	<=	mem_lo1_way3[set_c4];	
		saout_hi0_bc[19:0]	<=	mem_hi0_way3[set_c4];	
		saout_hi1_bc[18:0]	<=	mem_hi1_way3[set_c4];	
 		rd_spare_0		<=	mem_way3_spare_0[set_c4];
 		rd_spare_1		<=	mem_way3_spare_1[set_c4];
		end
	else if(waysel_c4[4])
		begin
		saout_lo0_bc[19:0]	<=	mem_lo0_way4[set_c4];	
		saout_lo1_bc[18:0]	<=	mem_lo1_way4[set_c4];	
		saout_hi0_bc[19:0]	<=	mem_hi0_way4[set_c4];	
		saout_hi1_bc[18:0]	<=	mem_hi1_way4[set_c4];	
 		rd_spare_0		<=	mem_way4_spare_0[set_c4];
 		rd_spare_1		<=	mem_way4_spare_1[set_c4];
		end
	else if(waysel_c4[5])
		begin
		saout_lo0_bc[19:0]	<=	mem_lo0_way5[set_c4];
		saout_lo1_bc[18:0]	<=	mem_lo1_way5[set_c4];
		saout_hi0_bc[19:0]	<=	mem_hi0_way5[set_c4];
		saout_hi1_bc[18:0]	<=	mem_hi1_way5[set_c4];
 		rd_spare_0		<=	mem_way5_spare_0[set_c4];
 		rd_spare_1		<=	mem_way5_spare_1[set_c4];
		end
	else if(waysel_c4[6])
		begin
		saout_lo0_bc[19:0]	<=	mem_lo0_way6[set_c4];	
		saout_lo1_bc[18:0]	<=	mem_lo1_way6[set_c4];	
		saout_hi0_bc[19:0]	<=	mem_hi0_way6[set_c4];	
		saout_hi1_bc[18:0]	<=	mem_hi1_way6[set_c4];	
 		rd_spare_0		<=	mem_way6_spare_0[set_c4];
 		rd_spare_1		<=	mem_way6_spare_1[set_c4];
		end
	else if(waysel_c4[7])
		begin
	        saout_lo0_bc[19:0]    	<=	mem_lo0_way7[set_c4];      
	        saout_lo1_bc[18:0]    	<=	mem_lo1_way7[set_c4];      
	        saout_hi0_bc[19:0]    	<=	mem_hi0_way7[set_c4];      
	        saout_hi1_bc[18:0]    	<=	mem_hi1_way7[set_c4];      
 		rd_spare_0		<=	mem_way7_spare_0[set_c4];
 		rd_spare_1		<=	mem_way7_spare_1[set_c4];
		end
end
end


// READ
// Data is read out of the above array in c4 and gets registered and latched
// to become a c5b signal which gets muxed and goes to dmux


reg rd_spare_0_d_l,rd_spare_1_d_l;
reg rdd_spare_0,rdd_spare_1;
reg tstmodclk_c3b_l;
always@(posedge l1clk)
begin
	saout_lo0_bc_d_l[19:0] <= ~saout_lo0_bc[19:0];
	saout_lo1_bc_d_l[18:0] <= ~saout_lo1_bc[18:0];
	saout_hi0_bc_d_l[19:0] <= ~saout_hi0_bc[19:0];
	saout_hi1_bc_d_l[18:0] <= ~saout_hi1_bc[18:0];
	rd_spare_0_d_l         <= ~rd_spare_0;
	rd_spare_1_d_l         <= ~rd_spare_1;
end

always@(negedge l1clk)
begin
        saout_lo0_bc_c5b_l[19:0] <= saout_lo0_bc_d_l[19:0];
        saout_lo1_bc_c5b_l[18:0] <= saout_lo1_bc_d_l[18:0];
        saout_hi0_bc_c5b_l[19:0] <= saout_hi0_bc_d_l[19:0];
        saout_hi1_bc_c5b_l[18:0] <= saout_hi1_bc_d_l[18:0];
	rdd_spare_0		 <= rd_spare_0_d_l;
	rdd_spare_1		 <= rd_spare_1_d_l;
	tstmodclk_c3b_l		 <= tstmodclk_l;
end


assign rd_data[19:0] =
	{rdd_spare_0,      saout_lo1_bc_c5b_l[4], saout_hi0_bc_c5b_l[4],saout_lo0_bc_c5b_l[4],
	saout_hi1_bc_c5b_l[3], saout_lo1_bc_c5b_l[3], saout_hi0_bc_c5b_l[3],saout_lo0_bc_c5b_l[3],
	saout_hi1_bc_c5b_l[2], saout_lo1_bc_c5b_l[2], saout_hi0_bc_c5b_l[2],saout_lo0_bc_c5b_l[2],
	saout_hi1_bc_c5b_l[1], saout_lo1_bc_c5b_l[1], saout_hi0_bc_c5b_l[1],saout_lo0_bc_c5b_l[1],
	saout_hi1_bc_c5b_l[0], saout_lo1_bc_c5b_l[0], saout_hi0_bc_c5b_l[0],saout_lo0_bc_c5b_l[0]};

	assign rd_data[39:20] = {
			  saout_lo1_bc_c5b_l[9], saout_hi0_bc_c5b_l[9],saout_lo0_bc_c5b_l[9],
	saout_hi1_bc_c5b_l[8], saout_lo1_bc_c5b_l[8], saout_hi0_bc_c5b_l[8],saout_lo0_bc_c5b_l[8],
	saout_hi1_bc_c5b_l[7], saout_lo1_bc_c5b_l[7], saout_hi0_bc_c5b_l[7],saout_lo0_bc_c5b_l[7],
	saout_hi1_bc_c5b_l[6], saout_lo1_bc_c5b_l[6], saout_hi0_bc_c5b_l[6],saout_lo0_bc_c5b_l[6],
	saout_hi1_bc_c5b_l[5], saout_lo1_bc_c5b_l[5], saout_hi0_bc_c5b_l[5],saout_lo0_bc_c5b_l[5], saout_hi1_bc_c5b_l[4]};


	assign rd_data[59:40] = {
	saout_lo1_bc_c5b_l[14], saout_hi0_bc_c5b_l[14],saout_lo0_bc_c5b_l[14],
	saout_hi1_bc_c5b_l[13], saout_lo1_bc_c5b_l[13], saout_hi0_bc_c5b_l[13],saout_lo0_bc_c5b_l[13],
	saout_hi1_bc_c5b_l[12], saout_lo1_bc_c5b_l[12], saout_hi0_bc_c5b_l[12],saout_lo0_bc_c5b_l[12],
	saout_hi1_bc_c5b_l[11], saout_lo1_bc_c5b_l[11], saout_hi0_bc_c5b_l[11],saout_lo0_bc_c5b_l[11],
	saout_hi1_bc_c5b_l[10], saout_lo1_bc_c5b_l[10], saout_hi0_bc_c5b_l[10],saout_lo0_bc_c5b_l[10], saout_hi1_bc_c5b_l[9]};

	assign rd_data[79:60] = {
	saout_hi0_bc_c5b_l[19], saout_lo0_bc_c5b_l[19],
	saout_hi1_bc_c5b_l[18], saout_lo1_bc_c5b_l[18], saout_hi0_bc_c5b_l[18],saout_lo0_bc_c5b_l[18],
	saout_hi1_bc_c5b_l[17], saout_lo1_bc_c5b_l[17], saout_hi0_bc_c5b_l[17],saout_lo0_bc_c5b_l[17],
	saout_hi1_bc_c5b_l[16], saout_lo1_bc_c5b_l[16], saout_hi0_bc_c5b_l[16],saout_lo0_bc_c5b_l[16],
	saout_hi1_bc_c5b_l[15], saout_lo1_bc_c5b_l[15], saout_hi0_bc_c5b_l[15],saout_lo0_bc_c5b_l[15], saout_hi1_bc_c5b_l[14],rdd_spare_1};


	always@(cred_mod or rd_data)
	begin
	
	for(i=0;i<19;i=i+1)
	begin
	read_data[i] = cred_mod[i] ? rd_data[i+1] : rd_data[i];
        end
	
	for(i=20;i<40;i=i+1)
        begin
	read_data[i] = cred_mod[i] ? rd_data[i-1] : rd_data[i];
        end
	

	for(i=40;i<60;i=i+1)
	 begin
	 read_data[i] = cred_mod[i] ? rd_data[i+1] : rd_data[i];
         end
	 
	for(i=61;i<80;i=i+1)
         begin
	 read_data[i] = cred_mod[i] ? rd_data[i-1] : rd_data[i];
         end
	
	end 



	assign { saout_hi0_b_out_l[19], saout_lo0_b_out_l[19],
        saout_hi1_b_out_l[18], saout_lo1_b_out_l[18], saout_hi0_b_out_l[18],saout_lo0_b_out_l[18],
        saout_hi1_b_out_l[17], saout_lo1_b_out_l[17], saout_hi0_b_out_l[17],saout_lo0_b_out_l[17],
        saout_hi1_b_out_l[16], saout_lo1_b_out_l[16], saout_hi0_b_out_l[16],saout_lo0_b_out_l[16],
        saout_hi1_b_out_l[15], saout_lo1_b_out_l[15], saout_hi0_b_out_l[15],saout_lo0_b_out_l[15], 
	saout_hi1_b_out_l[14]} = read_data[79:61];
         
        assign {saout_lo1_b_out_l[14], saout_hi0_b_out_l[14],saout_lo0_b_out_l[14],
        saout_hi1_b_out_l[13], saout_lo1_b_out_l[13], saout_hi0_b_out_l[13],saout_lo0_b_out_l[13],
        saout_hi1_b_out_l[12], saout_lo1_b_out_l[12], saout_hi0_b_out_l[12],saout_lo0_b_out_l[12],
        saout_hi1_b_out_l[11], saout_lo1_b_out_l[11], saout_hi0_b_out_l[11],saout_lo0_b_out_l[11],
        saout_hi1_b_out_l[10], saout_lo1_b_out_l[10], saout_hi0_b_out_l[10],saout_lo0_b_out_l[10], 
	saout_hi1_b_out_l[9]} = read_data[59:40];

        assign { saout_lo1_b_out_l[9], saout_hi0_b_out_l[9],saout_lo0_b_out_l[9],
        saout_hi1_b_out_l[8], saout_lo1_b_out_l[8], saout_hi0_b_out_l[8],saout_lo0_b_out_l[8],
        saout_hi1_b_out_l[7], saout_lo1_b_out_l[7], saout_hi0_b_out_l[7],saout_lo0_b_out_l[7],
        saout_hi1_b_out_l[6], saout_lo1_b_out_l[6], saout_hi0_b_out_l[6],saout_lo0_b_out_l[6],
        saout_hi1_b_out_l[5], saout_lo1_b_out_l[5], saout_hi0_b_out_l[5],saout_lo0_b_out_l[5], 
	saout_hi1_b_out_l[4]} = read_data[39:20];

        assign {saout_lo1_b_out_l[4], saout_hi0_b_out_l[4],saout_lo0_b_out_l[4],
        saout_hi1_b_out_l[3], saout_lo1_b_out_l[3], saout_hi0_b_out_l[3],saout_lo0_b_out_l[3],
        saout_hi1_b_out_l[2], saout_lo1_b_out_l[2], saout_hi0_b_out_l[2],saout_lo0_b_out_l[2],
        saout_hi1_b_out_l[1], saout_lo1_b_out_l[1], saout_hi0_b_out_l[1],saout_lo0_b_out_l[1],
        saout_hi1_b_out_l[0], saout_lo1_b_out_l[0], saout_hi0_b_out_l[0],saout_lo0_b_out_l[0]} = read_data[18:0];

assign red_sel_rgt = |cred[19:18];
assign red_sel_lft = |cred[59:58];

assign coloff_c5_rgt[1] = coloff_c5[1] | red_sel_rgt & coloff_c5[0];
assign coloff_c5_rgt[0] = coloff_c5[0] | red_sel_rgt & coloff_c5[1];
assign coloff_c5_lft[1] = coloff_c5[1] | red_sel_lft & coloff_c5[0];
assign coloff_c5_lft[0] = coloff_c5[0] | red_sel_lft & coloff_c5[1];







 



always@(negedge l1clk)
begin
select_read_data_all_c5b <= (bank_select_c5 & ~(select_red_odd | select_red_even) & (|waysel_c5) & (|coloff_c5) & readen_c5 & wee_l & ~waysel_err_c4);
select_read_red_all_c5b  <=(bank_select_c5 &  (select_red_odd | select_red_even) & (|waysel_c5) & (|coloff_c5) & readen_c5 & wee_l & ~waysel_err_c4);
 
select_read_data_c5b_hi_rgt <= (bank_select_c5 & ~(select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_rgt[1] & ~waysel_err_c5);
select_read_data_c5b_hi_lft <= (bank_select_c5 & ~(select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_lft[1] & ~waysel_err_c5);
select_read_data_c5b_lo_rgt <= (bank_select_c5 & ~(select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_rgt[0] & ~waysel_err_c5);
select_read_data_c5b_lo_lft <= (bank_select_c5 & ~(select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_lft[0] & ~waysel_err_c5);
select_read_red_c5b_hi_rgt  <=(bank_select_c5 &  (select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_rgt[1] & ~waysel_err_c5);
select_read_red_c5b_hi_lft  <=(bank_select_c5 &  (select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_lft[1] & ~waysel_err_c5);
select_read_red_c5b_lo_rgt  <=(bank_select_c5 &  (select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_rgt[0] & ~waysel_err_c5);
select_read_red_c5b_lo_lft  <=(bank_select_c5 &  (select_red_odd | select_red_even) & (|waysel_c5)  & wee_l) & 
                               (readen_c5 & coloff_c5_lft[0] & ~waysel_err_c5);
end


//assign saout_lo0_bc_l[19:0] = select_read_data_c5b ? saout_lo0_bc_c5b_l[19:0] : 
//			      select_read_red_c5b ? red_lo0_out[19:0] : 20'hFFFFF;
//assign saout_lo1_bc_l[18:0] = select_read_data_c5b ? saout_lo1_bc_c5b_l[18:0] : 
//			      select_read_red_c5b ? red_lo1_out[18:0] : 19'h7FFFF;
//assign saout_hi0_bc_l[19:0] = select_read_data_c5b ? saout_hi0_bc_c5b_l[19:0] : 
//			      select_read_red_c5b ? red_hi0_out[19:0] : 20'hFFFFF;
//assign saout_hi1_bc_l[18:0] = select_read_data_c5b ? saout_hi1_bc_c5b_l[18:0] : 
//			      select_read_red_c5b ? red_hi1_out[18:0] : 19'h7FFFF;
//
always@(select_read_red_c5b_lo_rgt or select_read_red_c5b_lo_lft or select_read_red_c5b_hi_rgt or select_read_red_c5b_hi_lft or
	select_read_data_c5b_lo_rgt or select_read_data_c5b_lo_lft or select_read_data_c5b_hi_rgt or select_read_data_c5b_hi_lft
      or red_lo0_b_out_l or red_hi0_b_out_l or red_lo1_b_out_l or saout_hi1_b_out_l 
      or saout_lo0_b_out_l or red_hi0_b_out_l or saout_lo1_b_out_l or saout_hi1_b_out_l or tstmodclk_c3b_l or l1clk)
begin

if(tstmodclk_c3b_l)
begin
saout_lo0_bc_l[9:0]   = select_read_red_c5b_lo_rgt  ? red_lo0_b_out_l[9:0]     : 
		      select_read_data_c5b_lo_rgt ? saout_lo0_b_out_l[9:0]   : 10'h3FF;
saout_lo0_bc_l[19:10] = select_read_red_c5b_lo_lft  ? red_lo0_b_out_l[19:10]   : 
		      select_read_data_c5b_lo_lft ? saout_lo0_b_out_l[19:10] : 10'h3FF;
saout_hi0_bc_l[9:0]   = select_read_red_c5b_lo_rgt  ? red_hi0_b_out_l[9:0]     : 
		      select_read_data_c5b_lo_rgt ? saout_hi0_b_out_l[9:0]   : 10'h3FF;
saout_hi0_bc_l[19:10] = select_read_red_c5b_lo_lft  ? red_hi0_b_out_l[19:10]   : 
		      select_read_data_c5b_lo_lft ? saout_hi0_b_out_l[19:10] : 10'h3FF;
saout_lo1_bc_l[9:0]   = select_read_red_c5b_hi_rgt  ? red_lo1_b_out_l[9:0]     : 
		      select_read_data_c5b_hi_rgt ? saout_lo1_b_out_l[9:0]   : 10'h3FF;
saout_lo1_bc_l[18:10] = select_read_red_c5b_hi_lft  ? red_lo1_b_out_l[18:10]   : 
		      select_read_data_c5b_hi_lft ? saout_lo1_b_out_l[18:10] : 9'h1FF;
saout_hi1_bc_l[8:0]   = select_read_red_c5b_hi_rgt  ? red_hi1_b_out_l[8:0]     : 
		      select_read_data_c5b_hi_rgt ? saout_hi1_b_out_l[8:0]   : 9'h1FF;
saout_hi1_bc_l[18:9]  = select_read_red_c5b_hi_lft  ? red_hi1_b_out_l[18:9]    : 
		      select_read_data_c5b_hi_lft ? saout_hi1_b_out_l[18:9]  : 10'h3FF;
end
else
begin
saout_lo0_bc_l[19:0] = select_read_red_all_c5b  ? red_lo0_b_out_l[19:0]   : 
 		       select_read_data_all_c5b ? saout_lo0_b_out_l[19:0] : 20'bx;
saout_hi0_bc_l[19:0] = select_read_red_all_c5b  ? red_hi0_b_out_l[19:0]   : 
 		       select_read_data_all_c5b ? saout_hi0_b_out_l[19:0] : 20'bx;
saout_lo1_bc_l[18:0] = select_read_red_all_c5b  ? red_lo1_b_out_l[18:0]   : 
 		       select_read_data_all_c5b ? saout_lo1_b_out_l[18:0] : 19'bx;
saout_hi1_bc_l[18:0] = select_read_red_all_c5b  ? red_hi1_b_out_l[18:0]   : 
		       select_read_data_all_c5b ? saout_hi1_b_out_l[18:0] : 19'bx;
		       
//saout_lo0_bc_l[19:0] = select_read_data_all_c5b ? saout_lo0_bc_c5b_l[19:0] : 20'hFFFFF;
//saout_lo1_bc_l[18:0] = select_read_data_all_c5b ? saout_lo1_bc_c5b_l[18:0] : 19'hFFFFF;
//saout_hi0_bc_l[19:0] = select_read_data_all_c5b ? saout_hi0_bc_c5b_l[19:0] : 20'hFFFFF;
//saout_hi1_bc_l[18:0] = select_read_data_all_c5b ? saout_hi1_bc_c5b_l[18:0] : 19'hFFFFF;
end
end


//assign repair_saout_lo0_bc_l[9:0]   = 
//select_read_red_c5b_lo_rgt  ? red_lo0_b_out_l[9:0]     : select_read_data_c5b_lo_rgt ? saout_lo0_b_out_l[9:0]   : 10'h3FF ;
//assign repair_saout_lo0_bc_l[19:10] = 
//select_read_red_c5b_lo_lft  ? red_lo0_b_out_l[19:10]   : select_read_data_c5b_lo_lft ? saout_lo0_b_out_l[19:10] : 10'h3FF ;
//assign repair_saout_hi0_bc_l[9:0]   = 
//select_read_red_c5b_lo_rgt  ? red_hi0_b_out_l[9:0]     : select_read_data_c5b_lo_rgt ? saout_hi0_b_out_l[9:0]   : 10'h3FF ;
//assign repair_saout_hi0_bc_l[19:10] = 
//select_read_red_c5b_lo_lft  ? red_hi0_b_out_l[19:10]   : select_read_data_c5b_lo_lft ? saout_hi0_b_out_l[19:10] : 10'h3FF ;
//assign repair_saout_lo1_bc_l[9:0]   = 
//select_read_red_c5b_hi_rgt  ? red_lo1_b_out_l[9:0]     : select_read_data_c5b_hi_rgt ? saout_lo1_b_out_l[9:0]   : 10'h3FF ;
//assign repair_saout_lo1_bc_l[18:10] = 
//select_read_red_c5b_hi_lft  ? red_lo1_b_out_l[18:10]   : select_read_data_c5b_hi_lft ? saout_lo1_b_out_l[18:10] : 9'h1FF ;
//assign repair_saout_hi1_bc_l[8:0]   = 
//select_read_red_c5b_hi_rgt  ? red_hi1_b_out_l[8:0]     : select_read_data_c5b_hi_rgt ? saout_hi1_b_out_l[8:0]   : 9'h1FF ;
//assign repair_saout_hi1_bc_l[18:9]  = 
//select_read_red_c5b_hi_lft  ? red_hi1_b_out_l[18:9]    : select_read_data_c5b_hi_lft ? saout_hi1_b_out_l[18:9]  : 10'h3FF ;
//
//
//assign norepair_saout_lo0_bc_l[19:0] = select_read_data_all_c5b ? saout_lo0_bc_c5b_l[19:0] : 20'hFFFFF;
//assign norepair_saout_lo1_bc_l[18:0] = select_read_data_all_c5b ? saout_lo1_bc_c5b_l[18:0] : 19'hFFFFF;
//assign norepair_saout_hi0_bc_l[19:0] = select_read_data_all_c5b ? saout_hi0_bc_c5b_l[19:0] : 20'hFFFFF;
//assign norepair_saout_hi1_bc_l[18:0] = select_read_data_all_c5b ? saout_hi1_bc_c5b_l[18:0] : 19'hFFFFF;
//
//`endif
//
//`ifdef AXIS_SMEM
//
//	always@(negedge l1clk)  
//	begin
//        axis_saout_lo0_bc[19:0]  = saout_lo0_bc[19:0];
//        axis_saout_lo1_bc[18:0]  = saout_lo1_bc[18:0];
//        axis_saout_hi0_bc[19:0]  = saout_hi0_bc[19:0];
//        axis_saout_hi1_bc[18:0]  = saout_hi1_bc[18:0];
//	end
//	assign saout_lo0_bc_l[19:0] = axis_select_read_data_c5b ? axis_saout_lo0_bc[19:0] : 20'hFFFFF;
//	assign saout_lo1_bc_l[18:0] = axis_select_read_data_c5b ? axis_saout_lo1_bc[18:0] : 19'h7FFFF;
//	assign saout_hi0_bc_l[19:0] = axis_select_read_data_c5b ? axis_saout_hi0_bc[19:0] : 20'hFFFFF;
//	assign saout_hi1_bc_l[18:0] = axis_select_read_data_c5b ? axis_saout_hi1_bc[18:0] : 19'h7FFFF;
//
//`else
//assign saout_lo0_bc_l[19:0] = ~tstmodclk_c3b_l ? repair_saout_lo0_bc_l[19:0] : norepair_saout_lo0_bc_l[19:0];
//assign saout_lo1_bc_l[18:0] = ~tstmodclk_c3b_l ? repair_saout_lo1_bc_l[18:0] : norepair_saout_lo1_bc_l[18:0];
//assign saout_hi0_bc_l[19:0] = ~tstmodclk_c3b_l ? repair_saout_hi0_bc_l[19:0] : norepair_saout_hi0_bc_l[19:0];
//assign saout_hi1_bc_l[18:0] = ~tstmodclk_c3b_l ? repair_saout_hi1_bc_l[18:0] : norepair_saout_hi1_bc_l[18:0];

///////////////////////////////////////////////////////////////////////////////////////////////

// REDUDANCY

reg [19:0]    red_lo0_odd_0;         
reg [18:0]    red_lo1_odd_0;         
reg [19:0]    red_hi0_odd_0;         
reg [18:0]    red_hi1_odd_0;         
reg [19:0]    red_lo0_even_0;
reg [18:0]    red_lo1_even_0;
reg [19:0]    red_hi0_even_0;
reg [18:0]    red_hi1_even_0;
reg	      redrow_way0_spare_odd_0;
reg	      redrow_way0_spare_even_0;
reg	      redrow_way0_spare_odd_1;
reg	      redrow_way0_spare_even_1;

reg [19:0]    red_lo0_odd_1;
reg [18:0]    red_lo1_odd_1;
reg [19:0]    red_hi0_odd_1;
reg [18:0]    red_hi1_odd_1;
reg [19:0]    red_lo0_even_1;
reg [18:0]    red_lo1_even_1;
reg [19:0]    red_hi0_even_1;
reg [18:0]    red_hi1_even_1;
reg	      redrow_way1_spare_odd_0;
reg	      redrow_way1_spare_even_0;
reg	      redrow_way1_spare_odd_1;
reg	      redrow_way1_spare_even_1;

reg [19:0]    red_lo0_odd_2;
reg [18:0]    red_lo1_odd_2;
reg [19:0]    red_hi0_odd_2;
reg [18:0]    red_hi1_odd_2;
reg [19:0]    red_lo0_even_2;
reg [18:0]    red_lo1_even_2;
reg [19:0]    red_hi0_even_2;
reg [18:0]    red_hi1_even_2;
reg	      redrow_way2_spare_odd_0;
reg	      redrow_way2_spare_even_0;
reg	      redrow_way2_spare_odd_1;
reg	      redrow_way2_spare_even_1;

reg [19:0]    red_lo0_odd_3;
reg [18:0]    red_lo1_odd_3;
reg [19:0]    red_hi0_odd_3;
reg [18:0]    red_hi1_odd_3;
reg [19:0]    red_lo0_even_3;
reg [18:0]    red_lo1_even_3;
reg [19:0]    red_hi0_even_3;
reg [18:0]    red_hi1_even_3;
reg	      redrow_way3_spare_odd_0;
reg	      redrow_way3_spare_even_0;
reg	      redrow_way3_spare_odd_1;
reg	      redrow_way3_spare_even_1;

reg [19:0]    red_lo0_odd_4;
reg [18:0]    red_lo1_odd_4;
reg [19:0]    red_hi0_odd_4;
reg [18:0]    red_hi1_odd_4;
reg [19:0]    red_lo0_even_4;
reg [18:0]    red_lo1_even_4;
reg [19:0]    red_hi0_even_4;
reg [18:0]    red_hi1_even_4;
reg	      redrow_way4_spare_odd_0;
reg	      redrow_way4_spare_even_0;
reg	      redrow_way4_spare_odd_1;
reg	      redrow_way4_spare_even_1;

reg [19:0]    red_lo0_odd_5;
reg [18:0]    red_lo1_odd_5;
reg [19:0]    red_hi0_odd_5;
reg [18:0]    red_hi1_odd_5;
reg [19:0]    red_lo0_even_5;
reg [18:0]    red_lo1_even_5;
reg [19:0]    red_hi0_even_5;
reg [18:0]    red_hi1_even_5;
reg	      redrow_way5_spare_odd_0;
reg	      redrow_way5_spare_even_0;
reg	      redrow_way5_spare_odd_1;
reg	      redrow_way5_spare_even_1;

reg [19:0]    red_lo0_odd_6;
reg [18:0]    red_lo1_odd_6;
reg [19:0]    red_hi0_odd_6;
reg [18:0]    red_hi1_odd_6;
reg [19:0]    red_lo0_even_6;
reg [18:0]    red_lo1_even_6;
reg [19:0]    red_hi0_even_6;
reg [18:0]    red_hi1_even_6;
reg	      redrow_way6_spare_odd_0;
reg	      redrow_way6_spare_even_0;
reg	      redrow_way6_spare_odd_1;
reg	      redrow_way6_spare_even_1;

reg [19:0]    red_lo0_odd_7;
reg [18:0]    red_lo1_odd_7;
reg [19:0]    red_hi0_odd_7;
reg [18:0]    red_hi1_odd_7;
reg [19:0]    red_lo0_even_7;
reg [18:0]    red_lo1_even_7;
reg [19:0]    red_hi0_even_7;
reg [18:0]    red_hi1_even_7;
reg	      redrow_way7_spare_odd_0;
reg	      redrow_way7_spare_even_0;
reg	      redrow_way7_spare_odd_1;
reg	      redrow_way7_spare_even_1;



reg [19:0]     red_lo0_out_bc;
reg [18:0]     red_lo1_out_bc;
reg [19:0]     red_hi0_out_bc;
reg [18:0]     red_hi1_out_bc;
reg            redrow_rd_spare_0;
reg            redrow_rd_spare_1;

reg [19:0]     red_lo0_out_bc_d_l;
reg [18:0]     red_lo1_out_bc_d_l;
reg [19:0]     red_hi0_out_bc_d_l;
reg [18:0]     red_hi1_out_bc_d_l;
reg	       redrow_rd_spare_0_d_l;
reg	       redrow_rd_spare_1_d_l;

reg [19:0]     red_lo0_bc_c5b_l;
reg [19:0]     red_hi0_bc_c5b_l;
reg [18:0]     red_lo1_bc_c5b_l;
reg [18:0]     red_hi1_bc_c5b_l;
reg	       redrow_rdd_spare_0;
reg	       redrow_rdd_spare_1;

wire [79:0]    red_rd_data;
reg [79:0]    red_read_data;

// Folloing 2 assigns detects a red index to hit with incoming index
// and assert.  While writing and reading the way info is looked at

assign select_red_odd = (red_adr[9:8] == 2'b11) & (red_adr[7:1] == set_c3b[7:1]) 
				& set_c3b[0]  & red_adr[0];
assign select_red_even = (red_adr[9:8] == 2'b11) & (red_adr[7:1] == set_c3b[7:1]) 
				& ~set_c3b[0] & ~red_adr[0];


always@(wee_l or l1clk or wen_c4 or set_c4 or waysel_c4 or waysel_err_c4 or bank_select or coloff_c4 or worden_c4 or
        select_red_odd or select_red_even or worden_lo0 or worden_hi0 or worden_lo1 or worden_hi1 or wrd_lo0_a
	or wrd_hi0_a or wrd_lo1_a or wrd_hi1_a or wr_spare_0 or wr_spare_1 or spare_word_enable or vnw_ary)
begin
// Odd row to be written
if(~l1clk & wee_l & wen_c4 & select_red_odd & ~waysel_err_c4 & bank_select & coloff_c4 & (|worden_c4) & vnw_ary)
 begin
  if(waysel_c4[0])
  begin  
    red_lo0_odd_0   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_0);
    red_hi0_odd_0   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_0);
    red_lo1_odd_0   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_0);
    red_hi1_odd_0   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_0);
    redrow_way0_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way0_spare_odd_0);
    redrow_way0_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way0_spare_odd_1);
   end
  else if(waysel_c4[1])
  begin
    red_lo0_odd_1   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_1);
    red_hi0_odd_1   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_1);
    red_lo1_odd_1   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_1);
    red_hi1_odd_1   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_1);
    redrow_way1_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way1_spare_odd_0);
    redrow_way1_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way1_spare_odd_1);
  end
  else if(waysel_c4[2])
  begin
    red_lo0_odd_2   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_2);
    red_hi0_odd_2   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_2);
    red_lo1_odd_2   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_2);
    red_hi1_odd_2   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_2);
    redrow_way2_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way2_spare_odd_0);
    redrow_way2_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way2_spare_odd_1);
  end
  else if(waysel_c4[3])
  begin
    red_lo0_odd_3   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_3);
    red_hi0_odd_3   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_3);
    red_lo1_odd_3   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_3);
    red_hi1_odd_3   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_3);
    redrow_way3_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way3_spare_odd_0);
    redrow_way3_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way3_spare_odd_1);
  end
  else if(waysel_c4[4])
  begin
    red_lo0_odd_4   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_4);
    red_hi0_odd_4   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_4);
    red_lo1_odd_4   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_4);
    red_hi1_odd_4   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_4);
    redrow_way4_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way4_spare_odd_0);
    redrow_way4_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way4_spare_odd_1);
  end
  else if(waysel_c4[5])
  begin
    red_lo0_odd_5   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_5);
    red_hi0_odd_5   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_5);
    red_lo1_odd_5   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_5);
    red_hi1_odd_5   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_5);
    redrow_way5_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way5_spare_odd_0);
    redrow_way5_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way5_spare_odd_1);
  end
  else if(waysel_c4[6])
  begin
    red_lo0_odd_6   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_6);
    red_hi0_odd_6   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_6);
    red_lo1_odd_6   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_6);
    red_hi1_odd_6   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_6);
    redrow_way6_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way6_spare_odd_0);
    redrow_way6_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way6_spare_odd_1);
  end
  else if(waysel_c4[7])
  begin
    red_lo0_odd_7   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_odd_7);
    red_hi0_odd_7   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_odd_7);
    red_lo1_odd_7   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_odd_7);
    red_hi1_odd_7   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_odd_7);
    redrow_way7_spare_odd_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way7_spare_odd_0);
    redrow_way7_spare_odd_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way7_spare_odd_1);
   end
  end
 

// Even rows to be written
if(~l1clk & wee_l & wen_c4 & select_red_even & ~waysel_err_c4 & bank_select & coloff_c4 & (|worden_c4) & vnw_ary)
 begin
  if(waysel_c4[0])
  begin
    red_lo0_even_0   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_0);
    red_hi0_even_0   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_0);
    red_lo1_even_0   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_0);
    red_hi1_even_0   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_0);
    redrow_way0_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way0_spare_even_0);
    redrow_way0_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way0_spare_even_1);
   end
  else if(waysel_c4[1])
  begin
    red_lo0_even_1   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_1);
    red_hi0_even_1   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_1);
    red_lo1_even_1   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_1);
    red_hi1_even_1   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_1);
    redrow_way1_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way1_spare_even_0);
    redrow_way1_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way1_spare_even_1);
  end
  else if(waysel_c4[2])
  begin
    red_lo0_even_2   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_2);
    red_hi0_even_2   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_2);
    red_lo1_even_2   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_2);
    red_hi1_even_2   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_2);
    redrow_way2_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way2_spare_even_0);
    redrow_way2_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way2_spare_even_1);
  end
  else if(waysel_c4[3])
  begin
    red_lo0_even_3   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_3);
    red_hi0_even_3   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_3);
    red_lo1_even_3   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_3);
    red_hi1_even_3   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_3);
    redrow_way3_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way3_spare_even_0);
    redrow_way3_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way3_spare_even_1);
  end
  else if(waysel_c4[4])
  begin
    red_lo0_even_4   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_4);
    red_hi0_even_4   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_4);
    red_lo1_even_4   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_4);
    red_hi1_even_4   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_4);
    redrow_way4_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way4_spare_even_0);
    redrow_way4_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way4_spare_even_1);
  end
  else if(waysel_c4[5])
  begin
    red_lo0_even_5   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_5);
    red_hi0_even_5   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_5);
    red_lo1_even_5   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_5);
    red_hi1_even_5   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_5);
    redrow_way5_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way5_spare_even_0);
    redrow_way5_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way5_spare_even_1);
  end
  else if(waysel_c4[6])
  begin
    red_lo0_even_6   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_6);
    red_hi0_even_6   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_6);
    red_lo1_even_6   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_6);
    red_hi1_even_6   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_6);
    redrow_way6_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way6_spare_even_0);
    redrow_way6_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way6_spare_even_1);
  end
  else if(waysel_c4[7])
  begin
    red_lo0_even_7   <= (worden_lo0[19:0] & wrd_lo0_a[19:0] | ~worden_lo0[19:0] & red_lo0_even_7);
    red_hi0_even_7   <= (worden_hi0[19:0] & wrd_hi0_a[19:0] | ~worden_hi0[19:0] & red_hi0_even_7);
    red_lo1_even_7   <= (worden_lo1[18:0] & wrd_lo1_a[18:0] | ~worden_lo1[18:0] & red_lo1_even_7);
    red_hi1_even_7   <= (worden_hi1[18:0] & wrd_hi1_a[18:0] | ~worden_hi1[18:0] & red_hi1_even_7);
    redrow_way7_spare_even_0 <= (spare_word_enable[0] & wr_spare_0 | ~spare_word_enable[0] & redrow_way7_spare_even_0);
    redrow_way7_spare_even_1 <= (spare_word_enable[1] & wr_spare_1 | ~spare_word_enable[1] & redrow_way7_spare_even_1);
  end
end
end

// read out
always@(waysel_c4 or coloff_c4_l or set_c4 or vnw_ary)
begin
if(~coloff_c4_l & vnw_ary)
 begin
 if(waysel_c4[0])
     begin
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_0 : red_lo0_even_0;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_0 : red_lo1_even_0;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_0 : red_hi0_even_0;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_0 : red_hi1_even_0;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way0_spare_odd_0 : redrow_way0_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way0_spare_odd_1 : redrow_way0_spare_even_1;	     
     end
 else if(waysel_c4[1])
     begin
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_1 : red_lo0_even_1;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_1 : red_lo1_even_1;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_1 : red_hi0_even_1;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_1 : red_hi1_even_1;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way1_spare_odd_0 : redrow_way1_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way1_spare_odd_1 : redrow_way1_spare_even_1;	     
     end
 else if(waysel_c4[2])
     begin            							  
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_2 : red_lo0_even_2;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_2 : red_lo1_even_2;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_2 : red_hi0_even_2;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_2 : red_hi1_even_2;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way2_spare_odd_0 : redrow_way2_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way2_spare_odd_1 : redrow_way2_spare_even_1;	     
     end
 else if(waysel_c4[3])
     begin            							  
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_3 : red_lo0_even_3;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_3 : red_lo1_even_3;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_3 : red_hi0_even_3;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_3 : red_hi1_even_3;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way3_spare_odd_0 : redrow_way3_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way3_spare_odd_1 : redrow_way3_spare_even_1;	     
     end
 else if(waysel_c4[4])
     begin            							  
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_4 : red_lo0_even_4;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_4 : red_lo1_even_4;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_4 : red_hi0_even_4;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_4 : red_hi1_even_4;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way4_spare_odd_0 : redrow_way4_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way4_spare_odd_1 : redrow_way4_spare_even_1;	     
     end
 else if(waysel_c4[5])
     begin            							  
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_5 : red_lo0_even_5;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_5 : red_lo1_even_5;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_5 : red_hi0_even_5;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_5 : red_hi1_even_5;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way5_spare_odd_0 : redrow_way5_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way5_spare_odd_1 : redrow_way5_spare_even_1;	     
     end
 else if(waysel_c4[6])
     begin            							  
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_6 : red_lo0_even_6;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_6 : red_lo1_even_6;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_6 : red_hi0_even_6;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_6 : red_hi1_even_6;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way6_spare_odd_0 : redrow_way6_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way6_spare_odd_1 : redrow_way6_spare_even_1;	     
     end
 else if(waysel_c4[7])
     begin           							  
     red_lo0_out_bc[19:0] <= (set_c4[0]) ? red_lo0_odd_7 : red_lo0_even_7;
     red_lo1_out_bc[18:0] <= (set_c4[0]) ? red_lo1_odd_7 : red_lo1_even_7;
     red_hi0_out_bc[19:0] <= (set_c4[0]) ? red_hi0_odd_7 : red_hi0_even_7;
     red_hi1_out_bc[18:0] <= (set_c4[0]) ? red_hi1_odd_7 : red_hi1_even_7;
     redrow_rd_spare_0 	  <= (set_c4[0]) ? redrow_way7_spare_odd_0 : redrow_way7_spare_even_0;
     redrow_rd_spare_1 	  <= (set_c4[0]) ? redrow_way7_spare_odd_1 : redrow_way7_spare_even_1;	
     end
end
end

always@(negedge l1clk)
begin
    red_lo0_out_bc_d_l <= ~red_lo0_out_bc;
    red_hi0_out_bc_d_l <= ~red_hi0_out_bc;
    red_lo1_out_bc_d_l <= ~red_lo1_out_bc;
    red_hi1_out_bc_d_l <= ~red_hi1_out_bc;
    redrow_rd_spare_0_d_l	     <= ~redrow_rd_spare_0;
    redrow_rd_spare_1_d_l	     <= ~redrow_rd_spare_1;	
end

always@(posedge l1clk)
begin
    red_lo0_bc_c5b_l <= red_lo0_out_bc_d_l;
    red_hi0_bc_c5b_l <= red_hi0_out_bc_d_l;
    red_lo1_bc_c5b_l <= red_lo1_out_bc_d_l;
    red_hi1_bc_c5b_l <= red_hi1_out_bc_d_l;
    redrow_rdd_spare_0	 <= redrow_rd_spare_0_d_l;
    redrow_rdd_spare_1	 <= redrow_rd_spare_1_d_l;
end

assign red_rd_data[19:0] =
	{redrow_rdd_spare_0,      red_lo1_bc_c5b_l[4], red_hi0_bc_c5b_l[4],red_lo0_bc_c5b_l[4],
	red_hi1_bc_c5b_l[3], red_lo1_bc_c5b_l[3], red_hi0_bc_c5b_l[3],red_lo0_bc_c5b_l[3],
	red_hi1_bc_c5b_l[2], red_lo1_bc_c5b_l[2], red_hi0_bc_c5b_l[2],red_lo0_bc_c5b_l[2],
	red_hi1_bc_c5b_l[1], red_lo1_bc_c5b_l[1], red_hi0_bc_c5b_l[1],red_lo0_bc_c5b_l[1],
	red_hi1_bc_c5b_l[0], red_lo1_bc_c5b_l[0], red_hi0_bc_c5b_l[0],red_lo0_bc_c5b_l[0]};

	assign red_rd_data[39:20] = {
			  red_lo1_bc_c5b_l[9], red_hi0_bc_c5b_l[9],red_lo0_bc_c5b_l[9],
	red_hi1_bc_c5b_l[8], red_lo1_bc_c5b_l[8], red_hi0_bc_c5b_l[8],red_lo0_bc_c5b_l[8],
	red_hi1_bc_c5b_l[7], red_lo1_bc_c5b_l[7], red_hi0_bc_c5b_l[7],red_lo0_bc_c5b_l[7],
	red_hi1_bc_c5b_l[6], red_lo1_bc_c5b_l[6], red_hi0_bc_c5b_l[6],red_lo0_bc_c5b_l[6],
	red_hi1_bc_c5b_l[5], red_lo1_bc_c5b_l[5], red_hi0_bc_c5b_l[5],red_lo0_bc_c5b_l[5], red_hi1_bc_c5b_l[4]};


	assign red_rd_data[59:40] = {
	red_lo1_bc_c5b_l[14], red_hi0_bc_c5b_l[14],red_lo0_bc_c5b_l[14],
	red_hi1_bc_c5b_l[13], red_lo1_bc_c5b_l[13], red_hi0_bc_c5b_l[13],red_lo0_bc_c5b_l[13],
	red_hi1_bc_c5b_l[12], red_lo1_bc_c5b_l[12], red_hi0_bc_c5b_l[12],red_lo0_bc_c5b_l[12],
	red_hi1_bc_c5b_l[11], red_lo1_bc_c5b_l[11], red_hi0_bc_c5b_l[11],red_lo0_bc_c5b_l[11],
	red_hi1_bc_c5b_l[10], red_lo1_bc_c5b_l[10], red_hi0_bc_c5b_l[10],red_lo0_bc_c5b_l[10], red_hi1_bc_c5b_l[9]};

	assign red_rd_data[79:60] = {
	red_hi0_bc_c5b_l[19], red_lo0_bc_c5b_l[19],
	red_hi1_bc_c5b_l[18], red_lo1_bc_c5b_l[18], red_hi0_bc_c5b_l[18],red_lo0_bc_c5b_l[18],
	red_hi1_bc_c5b_l[17], red_lo1_bc_c5b_l[17], red_hi0_bc_c5b_l[17],red_lo0_bc_c5b_l[17],
	red_hi1_bc_c5b_l[16], red_lo1_bc_c5b_l[16], red_hi0_bc_c5b_l[16],red_lo0_bc_c5b_l[16],
	red_hi1_bc_c5b_l[15], red_lo1_bc_c5b_l[15], red_hi0_bc_c5b_l[15],red_lo0_bc_c5b_l[15], red_hi1_bc_c5b_l[14],redrow_rdd_spare_1};


	always@(cred_mod or red_rd_data)
	begin
	
	for(i=0;i<19;i=i+1)
	begin
	 red_read_data[i] = cred_mod[i] ? red_rd_data[i+1] : red_rd_data[i];
        end
	
	for(i=20;i<40;i=i+1)
        begin
	 red_read_data[i] = cred_mod[i] ? red_rd_data[i-1] : red_rd_data[i];
        end
	

	for(i=40;i<60;i=i+1)
	begin
	 red_read_data[i] = cred_mod[i] ? red_rd_data[i+1] : red_rd_data[i];
        end
	
	for(i=61;i<80;i=i+1)
        begin
	 red_read_data[i] = cred_mod[i] ? red_rd_data[i-1] : red_rd_data[i];
        end
	
	end 



	assign { red_hi0_b_out_l[19], red_lo0_b_out_l[19],
        red_hi1_b_out_l[18], red_lo1_b_out_l[18], red_hi0_b_out_l[18],red_lo0_b_out_l[18],
        red_hi1_b_out_l[17], red_lo1_b_out_l[17], red_hi0_b_out_l[17],red_lo0_b_out_l[17],
        red_hi1_b_out_l[16], red_lo1_b_out_l[16], red_hi0_b_out_l[16],red_lo0_b_out_l[16],
        red_hi1_b_out_l[15], red_lo1_b_out_l[15], red_hi0_b_out_l[15],red_lo0_b_out_l[15], 
	red_hi1_b_out_l[14]} = red_read_data[79:61];
         
        assign {red_lo1_b_out_l[14], red_hi0_b_out_l[14],red_lo0_b_out_l[14],
        red_hi1_b_out_l[13], red_lo1_b_out_l[13], red_hi0_b_out_l[13],red_lo0_b_out_l[13],
        red_hi1_b_out_l[12], red_lo1_b_out_l[12], red_hi0_b_out_l[12],red_lo0_b_out_l[12],
        red_hi1_b_out_l[11], red_lo1_b_out_l[11], red_hi0_b_out_l[11],red_lo0_b_out_l[11],
        red_hi1_b_out_l[10], red_lo1_b_out_l[10], red_hi0_b_out_l[10],red_lo0_b_out_l[10], 
	red_hi1_b_out_l[9]} = red_read_data[59:40];

        assign { red_lo1_b_out_l[9], red_hi0_b_out_l[9],red_lo0_b_out_l[9],
        red_hi1_b_out_l[8], red_lo1_b_out_l[8], red_hi0_b_out_l[8],red_lo0_b_out_l[8],
        red_hi1_b_out_l[7], red_lo1_b_out_l[7], red_hi0_b_out_l[7],red_lo0_b_out_l[7],
        red_hi1_b_out_l[6], red_lo1_b_out_l[6], red_hi0_b_out_l[6],red_lo0_b_out_l[6],
        red_hi1_b_out_l[5], red_lo1_b_out_l[5], red_hi0_b_out_l[5],red_lo0_b_out_l[5], 
	red_hi1_b_out_l[4]} = red_read_data[39:20];

        assign {red_lo1_b_out_l[4], red_hi0_b_out_l[4],red_lo0_b_out_l[4],
        red_hi1_b_out_l[3], red_lo1_b_out_l[3], red_hi0_b_out_l[3],red_lo0_b_out_l[3],
        red_hi1_b_out_l[2], red_lo1_b_out_l[2], red_hi0_b_out_l[2],red_lo0_b_out_l[2],
        red_hi1_b_out_l[1], red_lo1_b_out_l[1], red_hi0_b_out_l[1],red_lo0_b_out_l[1],
        red_hi1_b_out_l[0], red_lo1_b_out_l[0], red_hi0_b_out_l[0],red_lo0_b_out_l[0]} = red_read_data[18:0];


//////////////////////////////////////////////////////////////////////////////
// col redudancy
// hi1, lo1, hi0, lo0

//assign cred_mod_lo0[18:0]  = cred_mod[18:0];
//assign cred_mod_hi0[38:19] = cred_mod[38:19];
//assign cred_mod_lo1[58:39] = cred_mod[58:39];
//assign cred_mod_hi1[77:59] = cred_mod[77:59];

// mux 0+1
// mux 19 spare
// mux 18 and spare
// mux 38 and 37 
// mux 77  




endmodule

//////////////////////////////////////////
////// n2_l2t_dp_32x128_cust    
//////////////////////////////////////////


module n2_l2t_dp_32x128_cust_array (
  wr_en, 
  rd_en, 
  l1clk, 
  wr_addr, 
  rd_addr, 
  write_disable, 
  din, 
  dout) ;

input 		wr_en;
input 		rd_en;
input 		l1clk;
input 	[31:0] 	wr_addr;
input 	[31:0] 	rd_addr;
input 		write_disable;
input 	[127:0] din;

output 	[127:0] dout;

// memory array
reg [127:0]  	inq_ary [31:0];
// internal variable
reg 	[127:0] temp; 
reg	[127:0]	data_in;
reg 	[4:0]   rdptr_d1; 
reg	[4:0]	wrptr_d1;
reg 	[127:0] dout;

reg 	[127:0] rd_data;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<32; i=i+1) begin
   inq_ary[i] = {128{1'b0}};
  end
end
`endif

 















//////////////////////////////////////////////////////////////////////
// Read Operation
//////////////////////////////////////////////////////////////////////


always @(rd_addr or rd_en or write_disable or wr_en or wr_addr or l1clk)
begin


	// ---- \/ added the write_disable qual on 11/11 \/------
           if (l1clk )  begin

             if (rd_en & ~write_disable) begin  

		case(rd_addr & {32{~write_disable}})
          		32'b0000_0000_0000_0000_0000_0000_0000_0000: ;  // do nothing
          		32'b0000_0000_0000_0000_0000_0000_0000_0001: rdptr_d1     = 5'b00000;
          		32'b0000_0000_0000_0000_0000_0000_0000_0010: rdptr_d1     = 5'b00001;
          		32'b0000_0000_0000_0000_0000_0000_0000_0100: rdptr_d1     = 5'b00010;
          		32'b0000_0000_0000_0000_0000_0000_0000_1000: rdptr_d1     = 5'b00011;
          		32'b0000_0000_0000_0000_0000_0000_0001_0000: rdptr_d1     = 5'b00100;
          		32'b0000_0000_0000_0000_0000_0000_0010_0000: rdptr_d1     = 5'b00101;
          		32'b0000_0000_0000_0000_0000_0000_0100_0000: rdptr_d1     = 5'b00110;
          		32'b0000_0000_0000_0000_0000_0000_1000_0000: rdptr_d1     = 5'b00111;
          		32'b0000_0000_0000_0000_0000_0001_0000_0000: rdptr_d1     = 5'b01000;
          		32'b0000_0000_0000_0000_0000_0010_0000_0000: rdptr_d1     = 5'b01001;
          		32'b0000_0000_0000_0000_0000_0100_0000_0000: rdptr_d1     = 5'b01010;
          		32'b0000_0000_0000_0000_0000_1000_0000_0000: rdptr_d1     = 5'b01011;
          		32'b0000_0000_0000_0000_0001_0000_0000_0000: rdptr_d1     = 5'b01100;
          		32'b0000_0000_0000_0000_0010_0000_0000_0000: rdptr_d1     = 5'b01101;
          		32'b0000_0000_0000_0000_0100_0000_0000_0000: rdptr_d1     = 5'b01110;
          		32'b0000_0000_0000_0000_1000_0000_0000_0000: rdptr_d1     = 5'b01111;
          		32'b0000_0000_0000_0001_0000_0000_0000_0000: rdptr_d1     = 5'b10000;
          		32'b0000_0000_0000_0010_0000_0000_0000_0000: rdptr_d1     = 5'b10001;
          		32'b0000_0000_0000_0100_0000_0000_0000_0000: rdptr_d1     = 5'b10010;
          		32'b0000_0000_0000_1000_0000_0000_0000_0000: rdptr_d1     = 5'b10011;
          		32'b0000_0000_0001_0000_0000_0000_0000_0000: rdptr_d1     = 5'b10100;
          		32'b0000_0000_0010_0000_0000_0000_0000_0000: rdptr_d1     = 5'b10101;
          		32'b0000_0000_0100_0000_0000_0000_0000_0000: rdptr_d1     = 5'b10110;
          		32'b0000_0000_1000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b10111;
          		32'b0000_0001_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11000;
          		32'b0000_0010_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11001;
          		32'b0000_0100_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11010;
          		32'b0000_1000_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11011;
          		32'b0001_0000_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11100;
          		32'b0010_0000_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11101;
          		32'b0100_0000_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11110;
          		32'b1000_0000_0000_0000_0000_0000_0000_0000: rdptr_d1     = 5'b11111;
         		default: rdptr_d1 = 5'bx ; 
       		endcase
                      rd_data = inq_ary[rdptr_d1];
                      dout = rd_data;

                end 
                //else      
                      //dout[127:0] = 128'h0 ;
            end  //l1clk
end // always @ (...


//////////////////////////////////////////////////////////////////////
// Write Operation
//////////////////////////////////////////////////////////////////////
always @ (write_disable or wr_en or wr_addr or din or l1clk)
begin


	//`ifdef  INNO_MUXEX
		if((wr_en==1'bx) & ~l1clk) 
		begin
			// do nothing
		end
	//`endif
	 	else if(wr_en & ~write_disable & ~l1clk)  
		begin
			case(wr_addr)
		          32'b0000_0000_0000_0000_0000_0000_0000_0000: ;  // do nothing
		          32'b0000_0000_0000_0000_0000_0000_0000_0001: wrptr_d1     = 5'b00000;
		          32'b0000_0000_0000_0000_0000_0000_0000_0010: wrptr_d1     = 5'b00001;
		          32'b0000_0000_0000_0000_0000_0000_0000_0100: wrptr_d1     = 5'b00010;
		          32'b0000_0000_0000_0000_0000_0000_0000_1000: wrptr_d1     = 5'b00011;
		          32'b0000_0000_0000_0000_0000_0000_0001_0000: wrptr_d1     = 5'b00100;
		          32'b0000_0000_0000_0000_0000_0000_0010_0000: wrptr_d1     = 5'b00101;
		          32'b0000_0000_0000_0000_0000_0000_0100_0000: wrptr_d1     = 5'b00110;
		          32'b0000_0000_0000_0000_0000_0000_1000_0000: wrptr_d1     = 5'b00111;
		          32'b0000_0000_0000_0000_0000_0001_0000_0000: wrptr_d1     = 5'b01000;
		          32'b0000_0000_0000_0000_0000_0010_0000_0000: wrptr_d1     = 5'b01001;
		          32'b0000_0000_0000_0000_0000_0100_0000_0000: wrptr_d1     = 5'b01010;
		          32'b0000_0000_0000_0000_0000_1000_0000_0000: wrptr_d1     = 5'b01011;
		          32'b0000_0000_0000_0000_0001_0000_0000_0000: wrptr_d1     = 5'b01100;
		          32'b0000_0000_0000_0000_0010_0000_0000_0000: wrptr_d1     = 5'b01101;
		          32'b0000_0000_0000_0000_0100_0000_0000_0000: wrptr_d1     = 5'b01110;
		          32'b0000_0000_0000_0000_1000_0000_0000_0000: wrptr_d1     = 5'b01111;
		          32'b0000_0000_0000_0001_0000_0000_0000_0000: wrptr_d1     = 5'b10000;
		          32'b0000_0000_0000_0010_0000_0000_0000_0000: wrptr_d1     = 5'b10001;
		          32'b0000_0000_0000_0100_0000_0000_0000_0000: wrptr_d1     = 5'b10010;
		          32'b0000_0000_0000_1000_0000_0000_0000_0000: wrptr_d1     = 5'b10011;
		          32'b0000_0000_0001_0000_0000_0000_0000_0000: wrptr_d1     = 5'b10100;
		          32'b0000_0000_0010_0000_0000_0000_0000_0000: wrptr_d1     = 5'b10101;
		          32'b0000_0000_0100_0000_0000_0000_0000_0000: wrptr_d1     = 5'b10110;
		          32'b0000_0000_1000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b10111;
		          32'b0000_0001_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11000;
		          32'b0000_0010_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11001;
		          32'b0000_0100_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11010;
		          32'b0000_1000_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11011;
		          32'b0001_0000_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11100;
		          32'b0010_0000_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11101;
		          32'b0100_0000_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11110;
		          32'b1000_0000_0000_0000_0000_0000_0000_0000: wrptr_d1     = 5'b11111;
          		  default:  wrptr_d1= 5'bx ; 
			endcase
			//`ifdef  INNO_MUXEX
			      if(wr_addr!=32'b0)
             			inq_ary[wrptr_d1] = din ;
			//`else
	 		else   
			begin
		       if(wr_addr!=32'b0)
             			inq_ary[wrptr_d1] = din ;
         		end
			//`endif
	 	end	
	 	else  
		begin
			// do nothing
	 	end	

end // always @ (...

endmodule // rf_32x128d


//////////////////////////////////////////
////// n2_com_cm_32x40_cust     
//////////////////////////////////////////


module n2_com_cm_32x40_cust_array (
  l1clk, 
  wr_en, 
  rd_en, 
  tcu_array_wr_inhibit, 
  key, 
  wr_addr, 
  rd_addr, 
  din, 
  lookup_en, 
  bypass, 
  dout, 
  match, 
  match_idx);

input l1clk;
input wr_en;
input rd_en;

input tcu_array_wr_inhibit;
input [41:7] key;
input [31:0] wr_addr;
input [31:0] rd_addr;
input [41:0] din;
input lookup_en;
input bypass;

output [41:0] dout;
output [31:0] match;
output [31:0] match_idx;





reg     [41:0]  mb_cam_data[31:0] ;
reg     [41:0]  dout;
reg     [41:0]  tmp_addr ;
reg     [41:0]  tmp_addr0 ;
reg     [41:0]  tmp_addr1 ;
reg     [41:0]  tmp_addr2 ;
reg     [41:0]  tmp_addr3 ;
reg     [41:0]  tmp_addr4 ;
reg     [41:0]  tmp_addr5 ;
reg     [41:0]  tmp_addr6 ;
reg     [41:0]  tmp_addr7 ;
reg     [41:0]  tmp_addr8 ;
reg     [41:0]  tmp_addr9 ;
reg     [41:0]  tmp_addr10 ;
reg     [41:0]  tmp_addr11 ;
reg     [41:0]  tmp_addr12 ;
reg     [41:0]  tmp_addr13 ;
reg     [41:0]  tmp_addr14 ;
reg     [41:0]  tmp_addr15 ;
reg     [41:0]  tmp_addr16;
reg     [41:0]  tmp_addr17;
reg     [41:0]  tmp_addr18;
reg     [41:0]  tmp_addr19;
reg     [41:0]  tmp_addr20;
reg     [41:0]  tmp_addr21;
reg     [41:0]  tmp_addr22;
reg     [41:0]  tmp_addr23;
reg     [41:0]  tmp_addr24;
reg     [41:0]  tmp_addr25;
reg     [41:0]  tmp_addr26;
reg     [41:0]  tmp_addr27;
reg     [41:0]  tmp_addr28;
reg     [41:0]  tmp_addr29;
reg     [41:0]  tmp_addr30;
reg     [41:0]  tmp_addr31;

wire    [31:0]  match ;
wire    [31:0]  match_idx ;
reg     [31:0]  match_p ;
reg     [31:0]  match_idx_p ;

  wire [41:0] tmp_data0;
  wire [41:0] tmp_data1;
  wire [41:0] tmp_data2;
  wire [41:0] tmp_data3;
  wire [41:0] tmp_data4;
  wire [41:0] tmp_data5;
  wire [41:0] tmp_data6;
  wire [41:0] tmp_data7;
  wire [41:0] tmp_data8;
  wire [41:0] tmp_data9;
  wire [41:0] tmp_data10;
  wire [41:0] tmp_data11;
  wire [41:0] tmp_data12;
  wire [41:0] tmp_data13;
  wire [41:0] tmp_data14;
  wire [41:0] tmp_data15;
  wire [41:0] tmp_data16;
  wire [41:0] tmp_data17;
  wire [41:0] tmp_data18;
  wire [41:0] tmp_data19;
  wire [41:0] tmp_data20;
  wire [41:0] tmp_data21;
  wire [41:0] tmp_data22;
  wire [41:0] tmp_data23;
  wire [41:0] tmp_data24;
  wire [41:0] tmp_data25;
  wire [41:0] tmp_data26;
  wire [41:0] tmp_data27;
  wire [41:0] tmp_data28;
  wire [41:0] tmp_data29;
  wire [41:0] tmp_data30;
  wire [41:0] tmp_data31;
// bamick, added wires above to allow us to view array contents in SSF

`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the arrays.            //
///////////////////////////////////////
integer n;
initial begin
        for (n = 0; n < 32; n = n + 1) begin
                mb_cam_data[n] = {42 {1'b0}};
        end
end
`endif

assign tmp_data0 = mb_cam_data[0];
assign tmp_data1 = mb_cam_data[1];
assign tmp_data2 = mb_cam_data[2];
assign tmp_data3 = mb_cam_data[3];
assign tmp_data4 = mb_cam_data[4];
assign tmp_data5 = mb_cam_data[5];
assign tmp_data6 = mb_cam_data[6];
assign tmp_data7 = mb_cam_data[7];
assign tmp_data8 = mb_cam_data[8];
assign tmp_data9 = mb_cam_data[9];
assign tmp_data10 = mb_cam_data[10];
assign tmp_data11 = mb_cam_data[11];
assign tmp_data12 = mb_cam_data[12];
assign tmp_data13 = mb_cam_data[13];
assign tmp_data14 = mb_cam_data[14];
assign tmp_data15 = mb_cam_data[15];
assign tmp_data16 = mb_cam_data[16];
assign tmp_data17 = mb_cam_data[17];
assign tmp_data18 = mb_cam_data[18];
assign tmp_data19 = mb_cam_data[19];
assign tmp_data20 = mb_cam_data[20];
assign tmp_data21 = mb_cam_data[21];
assign tmp_data22 = mb_cam_data[22];
assign tmp_data23 = mb_cam_data[23];
assign tmp_data24 = mb_cam_data[24];
assign tmp_data25 = mb_cam_data[25];
assign tmp_data26 = mb_cam_data[26];
assign tmp_data27 = mb_cam_data[27];
assign tmp_data28 = mb_cam_data[28];
assign tmp_data29 = mb_cam_data[29];
assign tmp_data30 = mb_cam_data[30];
assign tmp_data31 = mb_cam_data[31];
// bamick, added assign statements to allow use to view array contents in SSF

integer	i;

assign	match = match_p ;
assign	match_idx = match_idx_p ;

//0in kndr -var wr_addr[31:0] -active wr_en
//0in kndr -var rd_addr[31:0] -active rd_en
//0in one_hot -var rd_addr[31:0] -active (|rd_addr & rd_en) -group mbist_mode
//0in one_hot -var wr_addr[31:0] -active (|wr_addr & wr_en) -group mbist_mode

// CAM OPERATION
always  @( /*AUTOSENSE*/ /*memory or*/ wr_addr or key or 
          tmp_data0 or tmp_data1 or tmp_data2 or tmp_data3 or tmp_data4 or tmp_data5 or
          tmp_data6 or tmp_data7 or tmp_data8 or tmp_data9 or tmp_data10 or tmp_data11 or
          tmp_data12 or tmp_data13 or tmp_data14 or tmp_data15 or tmp_data16 or tmp_data17 or
          tmp_data18 or tmp_data19 or tmp_data20 or tmp_data21 or tmp_data22 or tmp_data23 or
          tmp_data24 or tmp_data25 or tmp_data26 or tmp_data27 or tmp_data28 or tmp_data29 or
          tmp_data30 or tmp_data31 or
          lookup_en or wr_en or bypass or tcu_array_wr_inhibit or l1clk) begin



    #0


  
        if (bypass)        begin
                match_p = 32'b0 ;
                match_idx_p = 32'hffffffff;
        end
      else if ( l1clk & lookup_en & ~tcu_array_wr_inhibit) begin

  
		tmp_addr0 = tmp_data0;
                match_p[0] =  ( wr_en & wr_addr[0] ) ? 1'bx :
                               ( tmp_addr0[41:7] == key[41:7] ) ;
                match_idx_p[0] = ( wr_en & wr_addr[0] ) ? 1'bx :
                                 ( tmp_addr0[17:9] == key[17:9] ) ;
  
		tmp_addr1 = tmp_data1;
                match_p[1] =  ( wr_en & wr_addr[1] ) ? 1'bx :
                               ( tmp_addr1[41:7] == key[41:7] ) ;
                match_idx_p[1] = ( wr_en & wr_addr[1] ) ? 1'bx :
                                 ( tmp_addr1[17:9] == key[17:9] ) ;
  
		tmp_addr2 = tmp_data2;
                match_p[2] =  ( wr_en & wr_addr[2] ) ? 1'bx :
                               ( tmp_addr2[41:7] == key[41:7] ) ;
                match_idx_p[2] = ( wr_en & wr_addr[2] ) ? 1'bx :
                                 ( tmp_addr2[17:9] == key[17:9] ) ;
  
		tmp_addr3 = tmp_data3;
                match_p[3] =  ( wr_en & wr_addr[3] ) ? 1'bx :
                               ( tmp_addr3[41:7] == key[41:7] ) ;
                match_idx_p[3] = ( wr_en & wr_addr[3] ) ? 1'bx :
                                 ( tmp_addr3[17:9] == key[17:9] ) ;
  
		tmp_addr4 = tmp_data4;
                match_p[4] =  ( wr_en & wr_addr[4] ) ? 1'bx :
                               ( tmp_addr4[41:7] == key[41:7] ) ;
                match_idx_p[4] = ( wr_en & wr_addr[4] ) ? 1'bx :
                                 ( tmp_addr4[17:9] == key[17:9] ) ;
  
		tmp_addr5 = tmp_data5;
                match_p[5] =  ( wr_en & wr_addr[5] ) ? 1'bx :
                               ( tmp_addr5[41:7] == key[41:7] ) ;
                match_idx_p[5] = ( wr_en & wr_addr[5] ) ? 1'bx :
                                 ( tmp_addr5[17:9] == key[17:9] ) ;
  
		tmp_addr6 = tmp_data6;
                match_p[6] =  ( wr_en & wr_addr[6] ) ? 1'bx :
                               ( tmp_addr6[41:7] == key[41:7] ) ;
                match_idx_p[6] = ( wr_en & wr_addr[6] ) ? 1'bx :
                                 ( tmp_addr6[17:9] == key[17:9] ) ;
  
		tmp_addr7 = tmp_data7;
                match_p[7] =  ( wr_en & wr_addr[7] ) ? 1'bx :
                               ( tmp_addr7[41:7] == key[41:7] ) ;
                match_idx_p[7] = ( wr_en & wr_addr[7] ) ? 1'bx :
                                 ( tmp_addr7[17:9] == key[17:9] ) ;
  
		tmp_addr8 = tmp_data8;
                match_p[8] =  ( wr_en & wr_addr[8] ) ? 1'bx :
                               ( tmp_addr8[41:7] == key[41:7] ) ;
                match_idx_p[8] = ( wr_en & wr_addr[8] ) ? 1'bx :
                                 ( tmp_addr8[17:9] == key[17:9] ) ;
  
		tmp_addr9 = tmp_data9;
                match_p[9] =  ( wr_en & wr_addr[9] ) ? 1'bx :
                               ( tmp_addr9[41:7] == key[41:7] ) ;
                match_idx_p[9] = ( wr_en & wr_addr[9] ) ? 1'bx :
                                 ( tmp_addr9[17:9] == key[17:9] ) ;
  
		tmp_addr10 = tmp_data10;
                match_p[10] =  ( wr_en & wr_addr[10] ) ? 1'bx :
                               ( tmp_addr10[41:7] == key[41:7] ) ;
                match_idx_p[10] = ( wr_en & wr_addr[10] ) ? 1'bx :
                                 ( tmp_addr10[17:9] == key[17:9] ) ;
  
		tmp_addr11 = tmp_data11;
                match_p[11] =  ( wr_en & wr_addr[11] ) ? 1'bx :
                               ( tmp_addr11[41:7] == key[41:7] ) ;
                match_idx_p[11] = ( wr_en & wr_addr[11] ) ? 1'bx :
                                 ( tmp_addr11[17:9] == key[17:9] ) ;
  
		tmp_addr12 = tmp_data12;
                match_p[12] =  ( wr_en & wr_addr[12] ) ? 1'bx :
                               ( tmp_addr12[41:7] == key[41:7] ) ;
                match_idx_p[12] = ( wr_en & wr_addr[12] ) ? 1'bx :
                                 ( tmp_addr12[17:9] == key[17:9] ) ;
  
		tmp_addr13 = tmp_data13;
                match_p[13] =  ( wr_en & wr_addr[13] ) ? 1'bx :
                               ( tmp_addr13[41:7] == key[41:7] ) ;
                match_idx_p[13] = ( wr_en & wr_addr[13] ) ? 1'bx :
                                 ( tmp_addr13[17:9] == key[17:9] ) ;
  
		tmp_addr14 = tmp_data14;
                match_p[14] =  ( wr_en & wr_addr[14] ) ? 1'bx :
                               ( tmp_addr14[41:7] == key[41:7] ) ;
                match_idx_p[14] = ( wr_en & wr_addr[14] ) ? 1'bx :
                                 ( tmp_addr14[17:9] == key[17:9] ) ;
  
		tmp_addr15 = tmp_data15;
                match_p[15] =  ( wr_en & wr_addr[15] ) ? 1'bx :
                               ( tmp_addr15[41:7] == key[41:7] ) ;
                match_idx_p[15] = ( wr_en & wr_addr[15] ) ? 1'bx :
                                 ( tmp_addr15[17:9] == key[17:9] ) ;

// BS & SR 11/04/03, MB grows to 32

		tmp_addr16 = tmp_data16;
		match_p[16] = ( wr_en & wr_addr[16] ) ? 1'bx : ( tmp_addr16[41:7] == key[41:7] ) ;
		match_idx_p[16] = ( wr_en & wr_addr[16] ) ? 1'bx : ( tmp_addr16[17:9] == key[17:9] ) ;

		tmp_addr17 = tmp_data17;
		match_p[17] = ( wr_en & wr_addr[17] ) ? 1'bx : ( tmp_addr17[41:7] == key[41:7] ) ;
		match_idx_p[17] = ( wr_en & wr_addr[17] ) ? 1'bx : ( tmp_addr17[17:9] == key[17:9] ) ;

		tmp_addr18 = tmp_data18;
		match_p[18] = ( wr_en & wr_addr[18] ) ? 1'bx : ( tmp_addr18[41:7] == key[41:7] ) ;
		match_idx_p[18] = ( wr_en & wr_addr[18] ) ? 1'bx : ( tmp_addr18[17:9] == key[17:9] ) ;

		tmp_addr19 = tmp_data19;
		match_p[19] = ( wr_en & wr_addr[19] ) ? 1'bx : ( tmp_addr19[41:7] == key[41:7] ) ;
		match_idx_p[19] = ( wr_en & wr_addr[19] ) ? 1'bx : ( tmp_addr19[17:9] == key[17:9] ) ;

		tmp_addr20 = tmp_data20;
		match_p[20] = ( wr_en & wr_addr[20] ) ? 1'bx : ( tmp_addr20[41:7] == key[41:7] ) ;
		match_idx_p[20] = ( wr_en & wr_addr[20] ) ? 1'bx : ( tmp_addr20[17:9] == key[17:9] ) ;

		tmp_addr21 = tmp_data21;
		match_p[21] = ( wr_en & wr_addr[21] ) ? 1'bx : ( tmp_addr21[41:7] == key[41:7] ) ;
		match_idx_p[21] = ( wr_en & wr_addr[21] ) ? 1'bx : ( tmp_addr21[17:9] == key[17:9] ) ;

		tmp_addr22 = tmp_data22;
		match_p[22] = ( wr_en & wr_addr[22] ) ? 1'bx : ( tmp_addr22[41:7] == key[41:7] ) ;
		match_idx_p[22] = ( wr_en & wr_addr[22] ) ? 1'bx : ( tmp_addr22[17:9] == key[17:9] ) ;

		tmp_addr23 = tmp_data23;
		match_p[23] = ( wr_en & wr_addr[23] ) ? 1'bx : ( tmp_addr23[41:7] == key[41:7] ) ;
		match_idx_p[23] = ( wr_en & wr_addr[23] ) ? 1'bx : ( tmp_addr23[17:9] == key[17:9] ) ;

		tmp_addr24 = tmp_data24;
		match_p[24] = ( wr_en & wr_addr[24] ) ? 1'bx : ( tmp_addr24[41:7] == key[41:7] ) ;
		match_idx_p[24] = ( wr_en & wr_addr[24] ) ? 1'bx : ( tmp_addr24[17:9] == key[17:9] ) ;

		tmp_addr25 = tmp_data25;
		match_p[25] = ( wr_en & wr_addr[25] ) ? 1'bx : ( tmp_addr25[41:7] == key[41:7] ) ;
		match_idx_p[25] = ( wr_en & wr_addr[25] ) ? 1'bx : ( tmp_addr25[17:9] == key[17:9] ) ;

		tmp_addr26 = tmp_data26;
		match_p[26] = ( wr_en & wr_addr[26] ) ? 1'bx : ( tmp_addr26[41:7] == key[41:7] ) ;
		match_idx_p[26] = ( wr_en & wr_addr[26] ) ? 1'bx : ( tmp_addr26[17:9] == key[17:9] ) ;

		tmp_addr27 = tmp_data27;
		match_p[27] = ( wr_en & wr_addr[27] ) ? 1'bx : ( tmp_addr27[41:7] == key[41:7] ) ;
		match_idx_p[27] = ( wr_en & wr_addr[27] ) ? 1'bx : ( tmp_addr27[17:9] == key[17:9] ) ;


		tmp_addr28 = tmp_data28;
		match_p[28] = ( wr_en & wr_addr[28] ) ? 1'bx : ( tmp_addr28[41:7] == key[41:7] ) ;
		match_idx_p[28] = ( wr_en & wr_addr[28] ) ? 1'bx : ( tmp_addr28[17:9] == key[17:9] ) ;

		tmp_addr29 = tmp_data29;
		match_p[29] = ( wr_en & wr_addr[29] ) ? 1'bx : ( tmp_addr29[41:7] == key[41:7] ) ;
		match_idx_p[29] = ( wr_en & wr_addr[29] ) ? 1'bx : ( tmp_addr29[17:9] == key[17:9] ) ;

		tmp_addr30 = tmp_data30;
		match_p[30] = ( wr_en & wr_addr[30] ) ? 1'bx : ( tmp_addr30[41:7] == key[41:7] ) ;
		match_idx_p[30] = ( wr_en & wr_addr[30] ) ? 1'bx : ( tmp_addr30[17:9] == key[17:9] ) ;


		tmp_addr31 = tmp_data31;
		match_p[31] = ( wr_en & wr_addr[31] ) ? 1'bx : ( tmp_addr31[41:7] == key[41:7] ) ;
		match_idx_p[31] = ( wr_en & wr_addr[31] ) ? 1'bx : ( tmp_addr31[17:9] == key[17:9] ) ;


	end

	else if ( l1clk & ~lookup_en & ~tcu_array_wr_inhibit ) 
              begin
                match_p = 32'b0;
                match_idx_p = 32'b0;
        end
          
        else
            begin
            end  // do nothing, hold output latched during l1clk low

end


// READ AND WRITE HAPPEN in Phase 1.

//bamick:  convert write_disable to se; add bypass
always  @(l1clk or wr_addr or din or wr_en or tcu_array_wr_inhibit or bypass or rd_addr or rd_en) 
  begin
    if (l1clk & wr_en  & ~tcu_array_wr_inhibit & ~bypass) 
    begin
        case(wr_addr )
          32'b0000_0000_0000_0000_0000_0000_0000_0000: ;  // do nothing
          32'b0000_0000_0000_0000_0000_0000_0000_0001: mb_cam_data[0] = din ;
          32'b0000_0000_0000_0000_0000_0000_0000_0010: mb_cam_data[1] = din ;
          32'b0000_0000_0000_0000_0000_0000_0000_0100: mb_cam_data[2] = din ;
          32'b0000_0000_0000_0000_0000_0000_0000_1000: mb_cam_data[3] = din ;
          32'b0000_0000_0000_0000_0000_0000_0001_0000: mb_cam_data[4] = din;
          32'b0000_0000_0000_0000_0000_0000_0010_0000: mb_cam_data[5] = din ;
          32'b0000_0000_0000_0000_0000_0000_0100_0000: mb_cam_data[6] = din ;
          32'b0000_0000_0000_0000_0000_0000_1000_0000: mb_cam_data[7] = din ;
          32'b0000_0000_0000_0000_0000_0001_0000_0000: mb_cam_data[8] = din ;
          32'b0000_0000_0000_0000_0000_0010_0000_0000: mb_cam_data[9] = din ;
          32'b0000_0000_0000_0000_0000_0100_0000_0000: mb_cam_data[10] = din ;
          32'b0000_0000_0000_0000_0000_1000_0000_0000: mb_cam_data[11] = din ;
          32'b0000_0000_0000_0000_0001_0000_0000_0000: mb_cam_data[12] = din ;
          32'b0000_0000_0000_0000_0010_0000_0000_0000: mb_cam_data[13] = din ;
          32'b0000_0000_0000_0000_0100_0000_0000_0000: mb_cam_data[14] = din ;
          32'b0000_0000_0000_0000_1000_0000_0000_0000: mb_cam_data[15] = din ;
          32'b0000_0000_0000_0001_0000_0000_0000_0000: mb_cam_data[16] = din ;    
          32'b0000_0000_0000_0010_0000_0000_0000_0000: mb_cam_data[17] = din ;    
          32'b0000_0000_0000_0100_0000_0000_0000_0000: mb_cam_data[18] = din ;    
          32'b0000_0000_0000_1000_0000_0000_0000_0000: mb_cam_data[19] = din ;    
          32'b0000_0000_0001_0000_0000_0000_0000_0000: mb_cam_data[20] = din;     
          32'b0000_0000_0010_0000_0000_0000_0000_0000: mb_cam_data[21] = din ;    
          32'b0000_0000_0100_0000_0000_0000_0000_0000: mb_cam_data[22] = din ;    
          32'b0000_0000_1000_0000_0000_0000_0000_0000: mb_cam_data[23] = din ;    
          32'b0000_0001_0000_0000_0000_0000_0000_0000: mb_cam_data[24] = din ;    
          32'b0000_0010_0000_0000_0000_0000_0000_0000: mb_cam_data[25] = din ;    
          32'b0000_0100_0000_0000_0000_0000_0000_0000: mb_cam_data[26] = din ;   
          32'b0000_1000_0000_0000_0000_0000_0000_0000: mb_cam_data[27] = din ;   
          32'b0001_0000_0000_0000_0000_0000_0000_0000: mb_cam_data[28] = din ;   
          32'b0010_0000_0000_0000_0000_0000_0000_0000: mb_cam_data[29] = din ;   
          32'b0100_0000_0000_0000_0000_0000_0000_0000: mb_cam_data[30] = din ;   
          32'b1000_0000_0000_0000_0000_0000_0000_0000: mb_cam_data[31] = din ;   
          default: begin 
		// 0in <fire -message "FATAL ERROR: incorrect write wordline" -group mbist_mode
		end
	endcase
	if(rd_en & (wr_addr==rd_addr))
	begin
		// 0in <fire -message "ERROR : reading and writing to same location " -group mbist_mode
	end
      end
  end

// Notice that the renable is qualified with l1clk to take 
// care that we do not read from the array if reset_l goes high
// during the negative phase of l1clk. 
// 

// bamick, add bypass
always  @( rd_addr or wr_addr or rd_en or wr_en or tcu_array_wr_inhibit or bypass or l1clk or 
          tmp_data0 or tmp_data1 or tmp_data2 or tmp_data3 or tmp_data4 or tmp_data5 or
          tmp_data6 or tmp_data7 or tmp_data8 or tmp_data9 or tmp_data10 or tmp_data11 or
          tmp_data12 or tmp_data13 or tmp_data14 or tmp_data15 or tmp_data16 or tmp_data17 or
          tmp_data18 or tmp_data19 or tmp_data20 or tmp_data21 or tmp_data22 or tmp_data23 or
          tmp_data24 or tmp_data25 or tmp_data26 or tmp_data27 or tmp_data28 or tmp_data29 or
          tmp_data30 or tmp_data31 or 
          din) begin
  if (bypass) begin
	dout <= din;
  end

// bamick, IMPORTANT:  not sure the below if matches circuit case, can't confirm yet 
// as don't yet know how to run SSF to verify scan...
//  I do think the value should be 42'b0 or hold the current value

  else if (rd_en & l1clk & tcu_array_wr_inhibit ) begin
//		dout <= 42'h000_0000_0000 ;
  end

  else if (rd_en & l1clk & ~tcu_array_wr_inhibit ) 
       	begin
    	if ((wr_en) && (rd_addr == wr_addr))
      		begin
         	dout <= 42'bx ;	
		// 0in <fire -message "ERROR : reading and writing to same location " -group mbist_mode
      	end
  else
      begin
        case(rd_addr)
          // match sense amp ckt behavior when no read wl is selected
         //32'b0000_0000_0000_0000_0000_0000_0000_0000: dout <= 42'hff_ffff_ffff;
          32'b0000_0000_0000_0000_0000_0000_0000_0000: dout <= 42'b0; 
          32'b0000_0000_0000_0000_0000_0000_0000_0001: dout <= tmp_data0 ;
          32'b0000_0000_0000_0000_0000_0000_0000_0010: dout <= tmp_data1 ;
          32'b0000_0000_0000_0000_0000_0000_0000_0100: dout <= tmp_data2 ;
          32'b0000_0000_0000_0000_0000_0000_0000_1000: dout <= tmp_data3 ;
          32'b0000_0000_0000_0000_0000_0000_0001_0000: dout <= tmp_data4 ;
          32'b0000_0000_0000_0000_0000_0000_0010_0000: dout <= tmp_data5 ;
          32'b0000_0000_0000_0000_0000_0000_0100_0000: dout <= tmp_data6 ;
          32'b0000_0000_0000_0000_0000_0000_1000_0000: dout <= tmp_data7 ;
          32'b0000_0000_0000_0000_0000_0001_0000_0000: dout <= tmp_data8 ;
          32'b0000_0000_0000_0000_0000_0010_0000_0000: dout <= tmp_data9 ;
          32'b0000_0000_0000_0000_0000_0100_0000_0000: dout <= tmp_data10 ;
          32'b0000_0000_0000_0000_0000_1000_0000_0000: dout <= tmp_data11 ;
          32'b0000_0000_0000_0000_0001_0000_0000_0000: dout <= tmp_data12 ;
          32'b0000_0000_0000_0000_0010_0000_0000_0000: dout <= tmp_data13 ;
          32'b0000_0000_0000_0000_0100_0000_0000_0000: dout <= tmp_data14 ;
          32'b0000_0000_0000_0000_1000_0000_0000_0000: dout <= tmp_data15 ;
          32'b0000_0000_0000_0001_0000_0000_0000_0000: dout <= tmp_data16 ;
          32'b0000_0000_0000_0010_0000_0000_0000_0000: dout <= tmp_data17 ;
          32'b0000_0000_0000_0100_0000_0000_0000_0000: dout <= tmp_data18 ;
          32'b0000_0000_0000_1000_0000_0000_0000_0000: dout <= tmp_data19 ;
          32'b0000_0000_0001_0000_0000_0000_0000_0000: dout <= tmp_data20 ;
          32'b0000_0000_0010_0000_0000_0000_0000_0000: dout <= tmp_data21 ;
          32'b0000_0000_0100_0000_0000_0000_0000_0000: dout <= tmp_data22 ;
          32'b0000_0000_1000_0000_0000_0000_0000_0000: dout <= tmp_data23 ;
          32'b0000_0001_0000_0000_0000_0000_0000_0000: dout <= tmp_data24 ;
          32'b0000_0010_0000_0000_0000_0000_0000_0000: dout <= tmp_data25 ;
          32'b0000_0100_0000_0000_0000_0000_0000_0000: dout <= tmp_data26 ;
          32'b0000_1000_0000_0000_0000_0000_0000_0000: dout <= tmp_data27 ;
          32'b0001_0000_0000_0000_0000_0000_0000_0000: dout <= tmp_data28 ;
          32'b0010_0000_0000_0000_0000_0000_0000_0000: dout <= tmp_data29 ;
          32'b0100_0000_0000_0000_0000_0000_0000_0000: dout <= tmp_data30 ;
          32'b1000_0000_0000_0000_0000_0000_0000_0000: dout <= tmp_data31 ;
          default: 
           begin
            dout <= 42'bx;
           // 0in <fire -message "FATAL ERROR: incorrect read wordline" -group mbist_mode
           end
        endcase
      end
	end // of else if
end
endmodule


//////////////////////////////////////////
////// n2_com_cm_64x64_cust     
//////////////////////////////////////////

module dc_panel_array (
  l2clk, 
  wr_en, 
  rd_en, 
  cam_en, 
  rst_warm, 
  write_disable, 
  force_hit, 
  rw_addr, 
  inval_mask, 
  wr_data, 
  valid_bit, 
  bypass, 
  valid, 
  rd_data, 
  lkup_hit);
wire [12:0] addr_array_0;
wire [12:0] addr_array_1;
wire [12:0] addr_array_2;
wire [12:0] addr_array_3;
wire [12:0] addr_array_4;
wire [12:0] addr_array_5;
wire [12:0] addr_array_6;
wire [12:0] addr_array_7;
wire [12:0] addr_array_8;
wire [12:0] addr_array_9;
wire [12:0] addr_array_10;
wire [12:0] addr_array_11;
wire [12:0] addr_array_12;
wire [12:0] addr_array_13;
wire [12:0] addr_array_14;
wire [12:0] addr_array_15;
wire [12:0] addr_array_16;
wire [12:0] addr_array_17;
wire [12:0] addr_array_18;
wire [12:0] addr_array_19;
wire [12:0] addr_array_20;
wire [12:0] addr_array_21;
wire [12:0] addr_array_22;
wire [12:0] addr_array_23;
wire [12:0] addr_array_24;
wire [12:0] addr_array_25;
wire [12:0] addr_array_26;
wire [12:0] addr_array_27;
wire [12:0] addr_array_28;
wire [12:0] addr_array_29;
wire [12:0] addr_array_30;
wire [12:0] addr_array_31;
wire [12:0] addr_array_32;
wire [12:0] addr_array_33;
wire [12:0] addr_array_34;
wire [12:0] addr_array_35;
wire [12:0] addr_array_36;
wire [12:0] addr_array_37;
wire [12:0] addr_array_38;
wire [12:0] addr_array_39;
wire [12:0] addr_array_40;
wire [12:0] addr_array_41;
wire [12:0] addr_array_42;
wire [12:0] addr_array_43;
wire [12:0] addr_array_44;
wire [12:0] addr_array_45;
wire [12:0] addr_array_46;
wire [12:0] addr_array_47;
wire [12:0] addr_array_48;
wire [12:0] addr_array_49;
wire [12:0] addr_array_50;
wire [12:0] addr_array_51;
wire [12:0] addr_array_52;
wire [12:0] addr_array_53;
wire [12:0] addr_array_54;
wire [12:0] addr_array_55;
wire [12:0] addr_array_56;
wire [12:0] addr_array_57;
wire [12:0] addr_array_58;
wire [12:0] addr_array_59;
wire [12:0] addr_array_60;
wire [12:0] addr_array_61;
wire [12:0] addr_array_62;
wire [12:0] addr_array_63;

input          		l2clk;
input          		wr_en;
input          		rd_en;
input          		cam_en;
input          		rst_warm;
input          		write_disable;
input			force_hit;
input   [5:0]  		rw_addr;
input   [63:0] 		inval_mask;
input   [15:0] 		wr_data;
input   [63:0] 		valid_bit;
input			bypass;
output  [63:0] 		valid;
output  [15:0] 		rd_data;
output  [63:0] 		lkup_hit;


// 
// Registers and wires
//

integer		i,j;

reg	[12:0]	addr_array[63:0]	; //  BS and SR 11/18/03 Reverse Directory change
reg	[63:0]	addr_bit4; //  Restructuring directories
reg	[63:0]	valid	;
reg	[63:0]	parity	;
reg	[15:0]	rd_data; // BS and SR 11/18/03 Reverse Directory change
reg	[63:0]	lkup_hit;
reg	[63:0]	cam_hit;
reg	[63:0]	cam_hit0;
reg	[63:0]	cam_hit1;
reg	[63:0]	new_valid;

`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the cam/arrays.        //
///////////////////////////////////////
integer n;
initial begin
        for (n = 0; n < 64; n = n + 1) begin
                addr_array[n] = {13{1'b0}};
                addr_bit4[n]  =      1'b0;
                valid[n]      =      1'b0;
                parity[n]     =      1'b0;
        end
end
`endif

assign addr_array_0 	= addr_array[0];
assign addr_array_1 	= addr_array[1];
assign addr_array_2 	= addr_array[2];
assign addr_array_3 	= addr_array[3];
assign addr_array_4 	= addr_array[4];
assign addr_array_5 	= addr_array[5];
assign addr_array_6 	= addr_array[6];
assign addr_array_7 	= addr_array[7];
assign addr_array_8 	= addr_array[8];
assign addr_array_9 	= addr_array[9];
assign addr_array_10 	= addr_array[10];
assign addr_array_11 	= addr_array[11];
assign addr_array_12 	= addr_array[12];
assign addr_array_13 	= addr_array[13];
assign addr_array_14 	= addr_array[14];
assign addr_array_15 	= addr_array[15];
assign addr_array_16 	= addr_array[16];
assign addr_array_17 	= addr_array[17];
assign addr_array_18 	= addr_array[18];
assign addr_array_19 	= addr_array[19];
assign addr_array_20 	= addr_array[20];
assign addr_array_21 	= addr_array[21];
assign addr_array_22 	= addr_array[22];
assign addr_array_23 	= addr_array[23];
assign addr_array_24 	= addr_array[24];
assign addr_array_25 	= addr_array[25];
assign addr_array_26 	= addr_array[26];
assign addr_array_27 	= addr_array[27];
assign addr_array_28 	= addr_array[28];
assign addr_array_29 	= addr_array[29];
assign addr_array_30 	= addr_array[30];
assign addr_array_31 	= addr_array[31];

assign addr_array_32    = addr_array[32];
assign addr_array_33    = addr_array[33];
assign addr_array_34    = addr_array[34];
assign addr_array_35    = addr_array[35];
assign addr_array_36    = addr_array[36];
assign addr_array_37    = addr_array[37];
assign addr_array_38    = addr_array[38];
assign addr_array_39    = addr_array[39];
assign addr_array_40    = addr_array[40];
assign addr_array_41    = addr_array[41];
assign addr_array_42    = addr_array[42];
assign addr_array_43    = addr_array[43];
assign addr_array_44    = addr_array[44];
assign addr_array_45    = addr_array[45];
assign addr_array_46    = addr_array[46];
assign addr_array_47    = addr_array[47];
assign addr_array_48    = addr_array[48];
assign addr_array_49    = addr_array[49];
assign addr_array_50    = addr_array[50];
assign addr_array_51    = addr_array[51];
assign addr_array_52    = addr_array[52];
assign addr_array_53    = addr_array[53];
assign addr_array_54    = addr_array[54];
assign addr_array_55    = addr_array[55];
assign addr_array_56    = addr_array[56];
assign addr_array_57    = addr_array[57];
assign addr_array_58    = addr_array[58];
assign addr_array_59    = addr_array[59];
assign addr_array_60    = addr_array[60];
assign addr_array_61    = addr_array[61];
assign addr_array_62    = addr_array[62];
assign addr_array_63    = addr_array[63];


// CAM OPERATION
// PH 1 CAM

always	@( cam_en or inval_mask or wr_data or valid_bit or force_hit or addr_bit4 
or l2clk or bypass or write_disable or rst_warm or
addr_array_0 or addr_array_1 or addr_array_2 or addr_array_3 or addr_array_4 or 
addr_array_5 or addr_array_6 or addr_array_7 or addr_array_8 or addr_array_9 or 
addr_array_10 or addr_array_11 or addr_array_12 or addr_array_13 or addr_array_14 or 
addr_array_15 or addr_array_16 or addr_array_17 or addr_array_18 or addr_array_19 or 
addr_array_20 or addr_array_21 or addr_array_22 or addr_array_23 or addr_array_24 or 
addr_array_25 or addr_array_26 or addr_array_27 or addr_array_28 or addr_array_29 or 
addr_array_30 or addr_array_31 or addr_array_32 or addr_array_33 or addr_array_34 or 
addr_array_35 or addr_array_36 or addr_array_37 or addr_array_38 or addr_array_39 or 
addr_array_40 or addr_array_41 or addr_array_42 or addr_array_43 or addr_array_44 or 
addr_array_45 or addr_array_46 or addr_array_47 or addr_array_48 or addr_array_49 or 
addr_array_50 or addr_array_51 or addr_array_52 or addr_array_53 or addr_array_54 or 
addr_array_55 or addr_array_56 or addr_array_57 or addr_array_58 or addr_array_59 or 
addr_array_60 or addr_array_61 or addr_array_62 or addr_array_63 )

 begin
 	// CAM

        if (bypass)        
	begin
                lkup_hit <= 64'b0; // RACE FIX
        end
	else if(l2clk & rst_warm) 
	begin
		lkup_hit <= 64'b0; // RAACE FIX
	end

	else 
	 if(l2clk & cam_en & ~write_disable) 
          begin



		cam_hit0[0]	=	( wr_data[12:0] == addr_array_0[12:0] );
		cam_hit1[0]	=	(( wr_data[13] == addr_bit4[0] ) | force_hit);
		cam_hit[0]	=	(cam_hit0[0] & cam_hit1[0]) & valid_bit[0];
		new_valid[0]	=	valid_bit[0] & ~( cam_hit[0] & inval_mask[0]);


		cam_hit0[1]	=	( wr_data[12:0] == addr_array_1[12:0] );
		cam_hit1[1]	=	(( wr_data[13] == addr_bit4[1] ) | force_hit);
		cam_hit[1]	=	(cam_hit0[1] & cam_hit1[1]) & valid_bit[1];
		new_valid[1]	=	valid_bit[1] & ~( cam_hit[1] & inval_mask[1]);


		cam_hit0[2]	=	( wr_data[12:0] == addr_array_2[12:0] );
		cam_hit1[2]	=	(( wr_data[13] == addr_bit4[2] ) | force_hit);
		cam_hit[2]	=	(cam_hit0[2] & cam_hit1[2]) & valid_bit[2];
		new_valid[2]	=	valid_bit[2] & ~( cam_hit[2] & inval_mask[2]);


		cam_hit0[3]	=	( wr_data[12:0] == addr_array_3[12:0] );
		cam_hit1[3]	=	(( wr_data[13] == addr_bit4[3] ) | force_hit);
		cam_hit[3]	=	(cam_hit0[3] & cam_hit1[3]) & valid_bit[3];
		new_valid[3]	=	valid_bit[3] & ~( cam_hit[3] & inval_mask[3]);


		cam_hit0[4]	=	( wr_data[12:0] == addr_array_4[12:0] );
		cam_hit1[4]	=	(( wr_data[13] == addr_bit4[4] ) | force_hit);
		cam_hit[4]	=	(cam_hit0[4] & cam_hit1[4]) & valid_bit[4];
		new_valid[4]	=	valid_bit[4] & ~( cam_hit[4] & inval_mask[4]);


		cam_hit0[5]	=	( wr_data[12:0] == addr_array_5[12:0] );
		cam_hit1[5]	=	(( wr_data[13] == addr_bit4[5] ) | force_hit);
		cam_hit[5]	=	(cam_hit0[5] & cam_hit1[5]) & valid_bit[5];
		new_valid[5]	=	valid_bit[5] & ~( cam_hit[5] & inval_mask[5]);


		cam_hit0[6]	=	( wr_data[12:0] == addr_array_6[12:0] );
		cam_hit1[6]	=	(( wr_data[13] == addr_bit4[6] ) | force_hit);
		cam_hit[6]	=	(cam_hit0[6] & cam_hit1[6]) & valid_bit[6];
		new_valid[6]	=	valid_bit[6] & ~( cam_hit[6] & inval_mask[6]);


		cam_hit0[7]	=	( wr_data[12:0] == addr_array_7[12:0] );
		cam_hit1[7]	=	(( wr_data[13] == addr_bit4[7] ) | force_hit);
		cam_hit[7]	=	(cam_hit0[7] & cam_hit1[7]) & valid_bit[7];
		new_valid[7]	=	valid_bit[7] & ~( cam_hit[7] & inval_mask[7]);


		cam_hit0[8]	=	( wr_data[12:0] == addr_array_8[12:0] );
		cam_hit1[8]	=	(( wr_data[13] == addr_bit4[8] ) | force_hit);
		cam_hit[8]	=	(cam_hit0[8] & cam_hit1[8]) & valid_bit[8];
		new_valid[8]	=	valid_bit[8] & ~( cam_hit[8] & inval_mask[8]);


		cam_hit0[9]	=	( wr_data[12:0] == addr_array_9[12:0] );
		cam_hit1[9]	=	(( wr_data[13] == addr_bit4[9] ) | force_hit);
		cam_hit[9]	=	(cam_hit0[9] & cam_hit1[9]) & valid_bit[9];
		new_valid[9]	=	valid_bit[9] & ~( cam_hit[9] & inval_mask[9]);


		cam_hit0[10]	=	( wr_data[12:0] == addr_array_10[12:0] );
		cam_hit1[10]	=	(( wr_data[13] == addr_bit4[10] ) | force_hit);
		cam_hit[10]	=	(cam_hit0[10] & cam_hit1[10]) & valid_bit[10];
		new_valid[10]	=	valid_bit[10] & ~( cam_hit[10] & inval_mask[10]);


		cam_hit0[11]	=	( wr_data[12:0] == addr_array_11[12:0] );
		cam_hit1[11]	=	(( wr_data[13] == addr_bit4[11] ) | force_hit);
		cam_hit[11]	=	(cam_hit0[11] & cam_hit1[11]) & valid_bit[11];
		new_valid[11]	=	valid_bit[11] & ~( cam_hit[11] & inval_mask[11]);


		cam_hit0[12]	=	( wr_data[12:0] == addr_array_12[12:0] );
		cam_hit1[12]	=	(( wr_data[13] == addr_bit4[12] ) | force_hit);
		cam_hit[12]	=	(cam_hit0[12] & cam_hit1[12]) & valid_bit[12];
		new_valid[12]	=	valid_bit[12] & ~( cam_hit[12] & inval_mask[12]);


		cam_hit0[13]	=	( wr_data[12:0] == addr_array_13[12:0] );
		cam_hit1[13]	=	(( wr_data[13] == addr_bit4[13] ) | force_hit);
		cam_hit[13]	=	(cam_hit0[13] & cam_hit1[13]) & valid_bit[13];
		new_valid[13]	=	valid_bit[13] & ~( cam_hit[13] & inval_mask[13]);


		cam_hit0[14]	=	( wr_data[12:0] == addr_array_14[12:0] );
		cam_hit1[14]	=	(( wr_data[13] == addr_bit4[14] ) | force_hit);
		cam_hit[14]	=	(cam_hit0[14] & cam_hit1[14]) & valid_bit[14];
		new_valid[14]	=	valid_bit[14] & ~( cam_hit[14] & inval_mask[14]);


		cam_hit0[15]	=	( wr_data[12:0] == addr_array_15[12:0] );
		cam_hit1[15]	=	(( wr_data[13] == addr_bit4[15] ) | force_hit);
		cam_hit[15]	=	(cam_hit0[15] & cam_hit1[15]) & valid_bit[15];
		new_valid[15]	=	valid_bit[15] & ~( cam_hit[15] & inval_mask[15]);


		cam_hit0[16]	=	( wr_data[12:0] == addr_array_16[12:0] );
		cam_hit1[16]	=	(( wr_data[13] == addr_bit4[16] ) | force_hit);
		cam_hit[16]	=	(cam_hit0[16] & cam_hit1[16]) & valid_bit[16];
		new_valid[16]	=	valid_bit[16] & ~( cam_hit[16] & inval_mask[16]);


		cam_hit0[17]	=	( wr_data[12:0] == addr_array_17[12:0] );
		cam_hit1[17]	=	(( wr_data[13] == addr_bit4[17] ) | force_hit);
		cam_hit[17]	=	(cam_hit0[17] & cam_hit1[17]) & valid_bit[17];
		new_valid[17]	=	valid_bit[17] & ~( cam_hit[17] & inval_mask[17]);


		cam_hit0[18]	=	( wr_data[12:0] == addr_array_18[12:0] );
		cam_hit1[18]	=	(( wr_data[13] == addr_bit4[18] ) | force_hit);
		cam_hit[18]	=	(cam_hit0[18] & cam_hit1[18]) & valid_bit[18];
		new_valid[18]	=	valid_bit[18] & ~( cam_hit[18] & inval_mask[18]);


		cam_hit0[19]	=	( wr_data[12:0] == addr_array_19[12:0] );
		cam_hit1[19]	=	(( wr_data[13] == addr_bit4[19] ) | force_hit);
		cam_hit[19]	=	(cam_hit0[19] & cam_hit1[19]) & valid_bit[19];
		new_valid[19]	=	valid_bit[19] & ~( cam_hit[19] & inval_mask[19]);


		cam_hit0[20]	=	( wr_data[12:0] == addr_array_20[12:0] );
		cam_hit1[20]	=	(( wr_data[13] == addr_bit4[20] ) | force_hit);
		cam_hit[20]	=	(cam_hit0[20] & cam_hit1[20]) & valid_bit[20];
		new_valid[20]	=	valid_bit[20] & ~( cam_hit[20] & inval_mask[20]);


		cam_hit0[21]	=	( wr_data[12:0] == addr_array_21[12:0] );
		cam_hit1[21]	=	(( wr_data[13] == addr_bit4[21] ) | force_hit);
		cam_hit[21]	=	(cam_hit0[21] & cam_hit1[21]) & valid_bit[21];
		new_valid[21]	=	valid_bit[21] & ~( cam_hit[21] & inval_mask[21]);


		cam_hit0[22]	=	( wr_data[12:0] == addr_array_22[12:0] );
		cam_hit1[22]	=	(( wr_data[13] == addr_bit4[22] ) | force_hit);
		cam_hit[22]	=	(cam_hit0[22] & cam_hit1[22]) & valid_bit[22];
		new_valid[22]	=	valid_bit[22] & ~( cam_hit[22] & inval_mask[22]);


		cam_hit0[23]	=	( wr_data[12:0] == addr_array_23[12:0] );
		cam_hit1[23]	=	(( wr_data[13] == addr_bit4[23] ) | force_hit);
		cam_hit[23]	=	(cam_hit0[23] & cam_hit1[23]) & valid_bit[23];
		new_valid[23]	=	valid_bit[23] & ~( cam_hit[23] & inval_mask[23]);


		cam_hit0[24]	=	( wr_data[12:0] == addr_array_24[12:0] );
		cam_hit1[24]	=	(( wr_data[13] == addr_bit4[24] ) | force_hit);
		cam_hit[24]	=	(cam_hit0[24] & cam_hit1[24]) & valid_bit[24];
		new_valid[24]	=	valid_bit[24] & ~( cam_hit[24] & inval_mask[24]);


		cam_hit0[25]	=	( wr_data[12:0] == addr_array_25[12:0] );
		cam_hit1[25]	=	(( wr_data[13] == addr_bit4[25] ) | force_hit);
		cam_hit[25]	=	(cam_hit0[25] & cam_hit1[25]) & valid_bit[25];
		new_valid[25]	=	valid_bit[25] & ~( cam_hit[25] & inval_mask[25]);


		cam_hit0[26]	=	( wr_data[12:0] == addr_array_26[12:0] );
		cam_hit1[26]	=	(( wr_data[13] == addr_bit4[26] ) | force_hit);
		cam_hit[26]	=	(cam_hit0[26] & cam_hit1[26]) & valid_bit[26];
		new_valid[26]	=	valid_bit[26] & ~( cam_hit[26] & inval_mask[26]);


		cam_hit0[27]	=	( wr_data[12:0] == addr_array_27[12:0] );
		cam_hit1[27]	=	(( wr_data[13] == addr_bit4[27] ) | force_hit);
		cam_hit[27]	=	(cam_hit0[27] & cam_hit1[27]) & valid_bit[27];
		new_valid[27]	=	valid_bit[27] & ~( cam_hit[27] & inval_mask[27]);


		cam_hit0[28]	=	( wr_data[12:0] == addr_array_28[12:0] );
		cam_hit1[28]	=	(( wr_data[13] == addr_bit4[28] ) | force_hit);
		cam_hit[28]	=	(cam_hit0[28] & cam_hit1[28]) & valid_bit[28];
		new_valid[28]	=	valid_bit[28] & ~( cam_hit[28] & inval_mask[28]);


		cam_hit0[29]	=	( wr_data[12:0] == addr_array_29[12:0] );
		cam_hit1[29]	=	(( wr_data[13] == addr_bit4[29] ) | force_hit);
		cam_hit[29]	=	(cam_hit0[29] & cam_hit1[29]) & valid_bit[29];
		new_valid[29]	=	valid_bit[29] & ~( cam_hit[29] & inval_mask[29]);


		cam_hit0[30]	=	( wr_data[12:0] == addr_array_30[12:0] );
		cam_hit1[30]	=	(( wr_data[13] == addr_bit4[30] ) | force_hit);
		cam_hit[30]	=	(cam_hit0[30] & cam_hit1[30]) & valid_bit[30];
		new_valid[30]	=	valid_bit[30] & ~( cam_hit[30] & inval_mask[30]);


		cam_hit0[31]	=	( wr_data[12:0] == addr_array_31[12:0] );
		cam_hit1[31]	=	(( wr_data[13] == addr_bit4[31] ) | force_hit);
		cam_hit[31]	=	(cam_hit0[31] & cam_hit1[31]) & valid_bit[31];
		new_valid[31]	=	valid_bit[31] & ~( cam_hit[31] & inval_mask[31]);


		cam_hit0[32]	=	( wr_data[12:0] == addr_array_32[12:0] );
		cam_hit1[32]	=	(( wr_data[13] == addr_bit4[32] ) | force_hit);
		cam_hit[32]	=	(cam_hit0[32] & cam_hit1[32]) & valid_bit[32];
		new_valid[32]	=	valid_bit[32] & ~( cam_hit[32] & inval_mask[32]);


		cam_hit0[33]	=	( wr_data[12:0] == addr_array_33[12:0] );
		cam_hit1[33]	=	(( wr_data[13] == addr_bit4[33] ) | force_hit);
		cam_hit[33]	=	(cam_hit0[33] & cam_hit1[33]) & valid_bit[33];
		new_valid[33]	=	valid_bit[33] & ~( cam_hit[33] & inval_mask[33]);


		cam_hit0[34]	=	( wr_data[12:0] == addr_array_34[12:0] );
		cam_hit1[34]	=	(( wr_data[13] == addr_bit4[34] ) | force_hit);
		cam_hit[34]	=	(cam_hit0[34] & cam_hit1[34]) & valid_bit[34];
		new_valid[34]	=	valid_bit[34] & ~( cam_hit[34] & inval_mask[34]);


		cam_hit0[35]	=	( wr_data[12:0] == addr_array_35[12:0] );
		cam_hit1[35]	=	(( wr_data[13] == addr_bit4[35] ) | force_hit);
		cam_hit[35]	=	(cam_hit0[35] & cam_hit1[35]) & valid_bit[35];
		new_valid[35]	=	valid_bit[35] & ~( cam_hit[35] & inval_mask[35]);


		cam_hit0[36]	=	( wr_data[12:0] == addr_array_36[12:0] );
		cam_hit1[36]	=	(( wr_data[13] == addr_bit4[36] ) | force_hit);
		cam_hit[36]	=	(cam_hit0[36] & cam_hit1[36]) & valid_bit[36];
		new_valid[36]	=	valid_bit[36] & ~( cam_hit[36] & inval_mask[36]);


		cam_hit0[37]	=	( wr_data[12:0] == addr_array_37[12:0] );
		cam_hit1[37]	=	(( wr_data[13] == addr_bit4[37] ) | force_hit);
		cam_hit[37]	=	(cam_hit0[37] & cam_hit1[37]) & valid_bit[37];
		new_valid[37]	=	valid_bit[37] & ~( cam_hit[37] & inval_mask[37]);


		cam_hit0[38]	=	( wr_data[12:0] == addr_array_38[12:0] );
		cam_hit1[38]	=	(( wr_data[13] == addr_bit4[38] ) | force_hit);
		cam_hit[38]	=	(cam_hit0[38] & cam_hit1[38]) & valid_bit[38];
		new_valid[38]	=	valid_bit[38] & ~( cam_hit[38] & inval_mask[38]);


		cam_hit0[39]	=	( wr_data[12:0] == addr_array_39[12:0] );
		cam_hit1[39]	=	(( wr_data[13] == addr_bit4[39] ) | force_hit);
		cam_hit[39]	=	(cam_hit0[39] & cam_hit1[39]) & valid_bit[39];
		new_valid[39]	=	valid_bit[39] & ~( cam_hit[39] & inval_mask[39]);


		cam_hit0[40]	=	( wr_data[12:0] == addr_array_40[12:0] );
		cam_hit1[40]	=	(( wr_data[13] == addr_bit4[40] ) | force_hit);
		cam_hit[40]	=	(cam_hit0[40] & cam_hit1[40]) & valid_bit[40];
		new_valid[40]	=	valid_bit[40] & ~( cam_hit[40] & inval_mask[40]);


		cam_hit0[41]	=	( wr_data[12:0] == addr_array_41[12:0] );
		cam_hit1[41]	=	(( wr_data[13] == addr_bit4[41] ) | force_hit);
		cam_hit[41]	=	(cam_hit0[41] & cam_hit1[41]) & valid_bit[41];
		new_valid[41]	=	valid_bit[41] & ~( cam_hit[41] & inval_mask[41]);


		cam_hit0[42]	=	( wr_data[12:0] == addr_array_42[12:0] );
		cam_hit1[42]	=	(( wr_data[13] == addr_bit4[42] ) | force_hit);
		cam_hit[42]	=	(cam_hit0[42] & cam_hit1[42]) & valid_bit[42];
		new_valid[42]	=	valid_bit[42] & ~( cam_hit[42] & inval_mask[42]);


		cam_hit0[43]	=	( wr_data[12:0] == addr_array_43[12:0] );
		cam_hit1[43]	=	(( wr_data[13] == addr_bit4[43] ) | force_hit);
		cam_hit[43]	=	(cam_hit0[43] & cam_hit1[43]) & valid_bit[43];
		new_valid[43]	=	valid_bit[43] & ~( cam_hit[43] & inval_mask[43]);


		cam_hit0[44]	=	( wr_data[12:0] == addr_array_44[12:0] );
		cam_hit1[44]	=	(( wr_data[13] == addr_bit4[44] ) | force_hit);
		cam_hit[44]	=	(cam_hit0[44] & cam_hit1[44]) & valid_bit[44];
		new_valid[44]	=	valid_bit[44] & ~( cam_hit[44] & inval_mask[44]);


		cam_hit0[45]	=	( wr_data[12:0] == addr_array_45[12:0] );
		cam_hit1[45]	=	(( wr_data[13] == addr_bit4[45] ) | force_hit);
		cam_hit[45]	=	(cam_hit0[45] & cam_hit1[45]) & valid_bit[45];
		new_valid[45]	=	valid_bit[45] & ~( cam_hit[45] & inval_mask[45]);


		cam_hit0[46]	=	( wr_data[12:0] == addr_array_46[12:0] );
		cam_hit1[46]	=	(( wr_data[13] == addr_bit4[46] ) | force_hit);
		cam_hit[46]	=	(cam_hit0[46] & cam_hit1[46]) & valid_bit[46];
		new_valid[46]	=	valid_bit[46] & ~( cam_hit[46] & inval_mask[46]);


		cam_hit0[47]	=	( wr_data[12:0] == addr_array_47[12:0] );
		cam_hit1[47]	=	(( wr_data[13] == addr_bit4[47] ) | force_hit);
		cam_hit[47]	=	(cam_hit0[47] & cam_hit1[47]) & valid_bit[47];
		new_valid[47]	=	valid_bit[47] & ~( cam_hit[47] & inval_mask[47]);


		cam_hit0[48]	=	( wr_data[12:0] == addr_array_48[12:0] );
		cam_hit1[48]	=	(( wr_data[13] == addr_bit4[48] ) | force_hit);
		cam_hit[48]	=	(cam_hit0[48] & cam_hit1[48]) & valid_bit[48];
		new_valid[48]	=	valid_bit[48] & ~( cam_hit[48] & inval_mask[48]);


		cam_hit0[49]	=	( wr_data[12:0] == addr_array_49[12:0] );
		cam_hit1[49]	=	(( wr_data[13] == addr_bit4[49] ) | force_hit);
		cam_hit[49]	=	(cam_hit0[49] & cam_hit1[49]) & valid_bit[49];
		new_valid[49]	=	valid_bit[49] & ~( cam_hit[49] & inval_mask[49]);


		cam_hit0[50]	=	( wr_data[12:0] == addr_array_50[12:0] );
		cam_hit1[50]	=	(( wr_data[13] == addr_bit4[50] ) | force_hit);
		cam_hit[50]	=	(cam_hit0[50] & cam_hit1[50]) & valid_bit[50];
		new_valid[50]	=	valid_bit[50] & ~( cam_hit[50] & inval_mask[50]);


		cam_hit0[51]	=	( wr_data[12:0] == addr_array_51[12:0] );
		cam_hit1[51]	=	(( wr_data[13] == addr_bit4[51] ) | force_hit);
		cam_hit[51]	=	(cam_hit0[51] & cam_hit1[51]) & valid_bit[51];
		new_valid[51]	=	valid_bit[51] & ~( cam_hit[51] & inval_mask[51]);


		cam_hit0[52]	=	( wr_data[12:0] == addr_array_52[12:0] );
		cam_hit1[52]	=	(( wr_data[13] == addr_bit4[52] ) | force_hit);
		cam_hit[52]	=	(cam_hit0[52] & cam_hit1[52]) & valid_bit[52];
		new_valid[52]	=	valid_bit[52] & ~( cam_hit[52] & inval_mask[52]);


		cam_hit0[53]	=	( wr_data[12:0] == addr_array_53[12:0] );
		cam_hit1[53]	=	(( wr_data[13] == addr_bit4[53] ) | force_hit);
		cam_hit[53]	=	(cam_hit0[53] & cam_hit1[53]) & valid_bit[53];
		new_valid[53]	=	valid_bit[53] & ~( cam_hit[53] & inval_mask[53]);


		cam_hit0[54]	=	( wr_data[12:0] == addr_array_54[12:0] );
		cam_hit1[54]	=	(( wr_data[13] == addr_bit4[54] ) | force_hit);
		cam_hit[54]	=	(cam_hit0[54] & cam_hit1[54]) & valid_bit[54];
		new_valid[54]	=	valid_bit[54] & ~( cam_hit[54] & inval_mask[54]);


		cam_hit0[55]	=	( wr_data[12:0] == addr_array_55[12:0] );
		cam_hit1[55]	=	(( wr_data[13] == addr_bit4[55] ) | force_hit);
		cam_hit[55]	=	(cam_hit0[55] & cam_hit1[55]) & valid_bit[55];
		new_valid[55]	=	valid_bit[55] & ~( cam_hit[55] & inval_mask[55]);


		cam_hit0[56]	=	( wr_data[12:0] == addr_array_56[12:0] );
		cam_hit1[56]	=	(( wr_data[13] == addr_bit4[56] ) | force_hit);
		cam_hit[56]	=	(cam_hit0[56] & cam_hit1[56]) & valid_bit[56];
		new_valid[56]	=	valid_bit[56] & ~( cam_hit[56] & inval_mask[56]);


		cam_hit0[57]	=	( wr_data[12:0] == addr_array_57[12:0] );
		cam_hit1[57]	=	(( wr_data[13] == addr_bit4[57] ) | force_hit);
		cam_hit[57]	=	(cam_hit0[57] & cam_hit1[57]) & valid_bit[57];
		new_valid[57]	=	valid_bit[57] & ~( cam_hit[57] & inval_mask[57]);


		cam_hit0[58]	=	( wr_data[12:0] == addr_array_58[12:0] );
		cam_hit1[58]	=	(( wr_data[13] == addr_bit4[58] ) | force_hit);
		cam_hit[58]	=	(cam_hit0[58] & cam_hit1[58]) & valid_bit[58];
		new_valid[58]	=	valid_bit[58] & ~( cam_hit[58] & inval_mask[58]);


		cam_hit0[59]	=	( wr_data[12:0] == addr_array_59[12:0] );
		cam_hit1[59]	=	(( wr_data[13] == addr_bit4[59] ) | force_hit);
		cam_hit[59]	=	(cam_hit0[59] & cam_hit1[59]) & valid_bit[59];
		new_valid[59]	=	valid_bit[59] & ~( cam_hit[59] & inval_mask[59]);


		cam_hit0[60]	=	( wr_data[12:0] == addr_array_60[12:0] );
		cam_hit1[60]	=	(( wr_data[13] == addr_bit4[60] ) | force_hit);
		cam_hit[60]	=	(cam_hit0[60] & cam_hit1[60]) & valid_bit[60];
		new_valid[60]	=	valid_bit[60] & ~( cam_hit[60] & inval_mask[60]);


		cam_hit0[61]	=	( wr_data[12:0] == addr_array_61[12:0] );
		cam_hit1[61]	=	(( wr_data[13] == addr_bit4[61] ) | force_hit);
		cam_hit[61]	=	(cam_hit0[61] & cam_hit1[61]) & valid_bit[61];
		new_valid[61]	=	valid_bit[61] & ~( cam_hit[61] & inval_mask[61]);


		cam_hit0[62]	=	( wr_data[12:0] == addr_array_62[12:0] );
		cam_hit1[62]	=	(( wr_data[13] == addr_bit4[62] ) | force_hit);
		cam_hit[62]	=	(cam_hit0[62] & cam_hit1[62]) & valid_bit[62];
		new_valid[62]	=	valid_bit[62] & ~( cam_hit[62] & inval_mask[62]);


		cam_hit0[63]	=	( wr_data[12:0] == addr_array_63[12:0] );
		cam_hit1[63]	=	(( wr_data[13] == addr_bit4[63] ) | force_hit);
		cam_hit[63]	=	(cam_hit0[63] & cam_hit1[63]) & valid_bit[63];
		new_valid[63]	=	valid_bit[63] & ~( cam_hit[63] & inval_mask[63]);



		lkup_hit <= cam_hit; // RACE FIX


	end

	else if(l2clk)
	begin	
			lkup_hit <= 64'b0; // RACE FIX
			new_valid = valid_bit;
	end

end


////////////////////////////////////////////////////////////
// READ/WRITE  OPERATION
// Phase 1 RD
////////////////////////////////////////////////////////////

//initial 
//begin
//       addr_bit4 = 64'b0;
//end

always @(l2clk or write_disable or rd_en or wr_en or cam_en or bypass or valid or rst_warm or wr_data )
begin
	if (bypass)        
		rd_data[15:0] <= wr_data[15:0];
	else if ((rst_warm & ~write_disable)) 
	begin
		rd_data[15:0] <= 16'b0;
		valid[63:0] <= 64'b0;
	end
	else if ((rst_warm & write_disable)) 
	begin
		rd_data[15:0] <= 16'b0;
	end
	if(l2clk & rd_en & ~write_disable & ~bypass & ~rst_warm) // RD
	begin
		if(wr_en) 
		begin
			rd_data <= 16'bx;
// should put in <fire -active wr_en -message "L2_DIR_ERR: read and write conflict"
		end
		else
		begin
			rd_data <= { valid[rw_addr], parity[rw_addr], addr_bit4[rw_addr], addr_array[rw_addr] };
		end	
	end // of if rd_en

	if(l2clk & wr_en & ~write_disable & ~bypass & ~rst_warm & ~cam_en) // WR 
	begin
		if(rd_en) // RESET
		begin
			rd_data <= 16'bx; 
			addr_array[rw_addr] <=  13'bx;
			addr_bit4[rw_addr]  <=  1'bx;
			parity[rw_addr]  <=  1'bx;
        		valid[rw_addr]  <=  1'bx;
		end
		else
		begin
	        	addr_array[rw_addr] <=  wr_data[12:0] ; // BS and SR 11/18/03 Reverse Directory change
	        	addr_bit4[rw_addr]  <=  wr_data[13] ; // BS and SR 11/18/03 Reverse Directory change
	        	parity[rw_addr]  <=  wr_data[14] ; // BS and SR 11/18/03 Reverse Directory change
	        	valid[rw_addr]  <=  wr_data[15] ; // BS and SR 11/18/03 Reverse Directory change
// should put in <fire -active cam_en -message "L2_DIR_ERR : cam/wr conflict"
		end
	end
//        if(~l2clk & cam_en & ~write_disable) // CAM 
        if(~l2clk & ~write_disable) // CAM 
	begin
		if (lkup_hit[0])  valid[0]  <= new_valid[0];
		if (lkup_hit[1])  valid[1]  <= new_valid[1];
		if (lkup_hit[2])  valid[2]  <= new_valid[2];
		if (lkup_hit[3])  valid[3]  <= new_valid[3];
		if (lkup_hit[4])  valid[4]  <= new_valid[4];
		if (lkup_hit[5])  valid[5]  <= new_valid[5];
		if (lkup_hit[6])  valid[6]  <= new_valid[6];
		if (lkup_hit[7])  valid[7]  <= new_valid[7];
		if (lkup_hit[8])  valid[8]  <= new_valid[8];
		if (lkup_hit[9])  valid[9]  <= new_valid[9];
		if (lkup_hit[10]) valid[10] <= new_valid[10];
		if (lkup_hit[11]) valid[11] <= new_valid[11];
		if (lkup_hit[12]) valid[12] <= new_valid[12];
		if (lkup_hit[13]) valid[13] <= new_valid[13];
		if (lkup_hit[14]) valid[14] <= new_valid[14];
		if (lkup_hit[15]) valid[15] <= new_valid[15];
		if (lkup_hit[16]) valid[16] <= new_valid[16];
		if (lkup_hit[17]) valid[17] <= new_valid[17];
		if (lkup_hit[18]) valid[18] <= new_valid[18];
		if (lkup_hit[19]) valid[19] <= new_valid[19];
		if (lkup_hit[20]) valid[20] <= new_valid[20];
		if (lkup_hit[21]) valid[21] <= new_valid[21];
		if (lkup_hit[22]) valid[22] <= new_valid[22];
		if (lkup_hit[23]) valid[23] <= new_valid[23];
		if (lkup_hit[24]) valid[24] <= new_valid[24];
		if (lkup_hit[25]) valid[25] <= new_valid[25];
		if (lkup_hit[26]) valid[26] <= new_valid[26];
		if (lkup_hit[27]) valid[27] <= new_valid[27];
		if (lkup_hit[28]) valid[28] <= new_valid[28];
		if (lkup_hit[29]) valid[29] <= new_valid[29];
		if (lkup_hit[30]) valid[30] <= new_valid[30];
		if (lkup_hit[31]) valid[31] <= new_valid[31];
		if (lkup_hit[32]) valid[32] <= new_valid[32];
		if (lkup_hit[33]) valid[33] <= new_valid[33];
		if (lkup_hit[34]) valid[34] <= new_valid[34];
		if (lkup_hit[35]) valid[35] <= new_valid[35];
		if (lkup_hit[36]) valid[36] <= new_valid[36];
		if (lkup_hit[37]) valid[37] <= new_valid[37];
		if (lkup_hit[38]) valid[38] <= new_valid[38];
		if (lkup_hit[39]) valid[39] <= new_valid[39];
		if (lkup_hit[40]) valid[40] <= new_valid[40];
		if (lkup_hit[41]) valid[41] <= new_valid[41];
		if (lkup_hit[42]) valid[42] <= new_valid[42];
		if (lkup_hit[43]) valid[43] <= new_valid[43];
		if (lkup_hit[44]) valid[44] <= new_valid[44];
		if (lkup_hit[45]) valid[45] <= new_valid[45];
		if (lkup_hit[46]) valid[46] <= new_valid[46];
		if (lkup_hit[47]) valid[47] <= new_valid[47];
		if (lkup_hit[48]) valid[48] <= new_valid[48];
		if (lkup_hit[49]) valid[49] <= new_valid[49];
		if (lkup_hit[50]) valid[50] <= new_valid[50];
		if (lkup_hit[51]) valid[51] <= new_valid[51];
		if (lkup_hit[52]) valid[52] <= new_valid[52];
		if (lkup_hit[53]) valid[53] <= new_valid[53];
		if (lkup_hit[54]) valid[54] <= new_valid[54];
		if (lkup_hit[55]) valid[55] <= new_valid[55];
		if (lkup_hit[56]) valid[56] <= new_valid[56];
		if (lkup_hit[57]) valid[57] <= new_valid[57];
		if (lkup_hit[58]) valid[58] <= new_valid[58];
		if (lkup_hit[59]) valid[59] <= new_valid[59];
		if (lkup_hit[60]) valid[60] <= new_valid[60];
		if (lkup_hit[61]) valid[61] <= new_valid[61];
		if (lkup_hit[62]) valid[62] <= new_valid[62];
		if (lkup_hit[63]) valid[63] <= new_valid[63];
	end
end

endmodule


//////////////////////////////////////////
////// n2_com_cm_8x40_cust      
//////////////////////////////////////////

module n2_com_cm_8x40_cust_array (
  l1clk, 
  l2clk, 
  l1clk_mat, 
  wr_en, 
  rd_en, 
  write_disable, 
  key, 
  wr_addr, 
  rd_addr, 
  din, 
  lookup_en, 
  bypass, 
  dout, 
  match_p, 
  match_idx_p);

input l1clk;
input l2clk;
input l1clk_mat;
input wr_en;
input rd_en;
input write_disable;
input [39:7] key;
input [7:0] wr_addr;
input [7:0] rd_addr;
input [39:0] din;
input lookup_en;
input bypass;
output [39:0] dout;
output [7:0] match_p;
output [7:0] match_idx_p;


reg     [39:0]  mb_cam_data[7:0] ; // BS and SR 8 deep change 3/3/04
reg     [39:0]  dout;
reg     [39:7]  key_d1;
reg             lookup_en_d1 ;
reg     [39:0]  tmp_addr ;
reg     [39:0]  tmp_addr0 ;
reg     [39:0]  tmp_addr1 ;
reg     [39:0]  tmp_addr2 ;
reg     [39:0]  tmp_addr3 ;
reg     [39:0]  tmp_addr4 ;
reg     [39:0]  tmp_addr5 ;
reg     [39:0]  tmp_addr6 ;
reg     [39:0]  tmp_addr7 ;
reg     [39:0]  tmp_addr8 ;
reg     [39:0]  tmp_addr9 ;
reg     [39:0]  tmp_addr10 ;
reg     [39:0]  tmp_addr11 ;
reg     [39:0]  tmp_addr12 ;
reg     [39:0]  tmp_addr13 ;
reg     [39:0]  tmp_addr14 ;
reg     [39:0]  tmp_addr15 ;
reg     [7:0]  match_p;
reg     [7:0]  match_idx_p;

wire    [39:0] mb_cam_data_0;
wire    [39:0] mb_cam_data_1;
wire    [39:0] mb_cam_data_2;
wire    [39:0] mb_cam_data_3;
wire    [39:0] mb_cam_data_4;
wire    [39:0] mb_cam_data_5;
wire    [39:0] mb_cam_data_6;
wire    [39:0] mb_cam_data_7;

assign  mb_cam_data_0 = mb_cam_data[0];
assign  mb_cam_data_1 = mb_cam_data[1];
assign  mb_cam_data_2 = mb_cam_data[2];
assign  mb_cam_data_3 = mb_cam_data[3];
assign  mb_cam_data_4 = mb_cam_data[4];
assign  mb_cam_data_5 = mb_cam_data[5];
assign  mb_cam_data_6 = mb_cam_data[6];
assign  mb_cam_data_7 = mb_cam_data[7];
 


`ifndef NOINITMEM
///////////////////////////////////////
// Initialize the cam/arrays.        //
///////////////////////////////////////
integer n;
initial begin
        for (n = 0; n < 8; n = n + 1) begin
                mb_cam_data[n] = {40 {1'b0}};
        end
end
`endif


// CAM OPERATION



always  @(l1clk_mat or l2clk or write_disable or bypass or lookup_en or key) begin

	if (l1clk_mat) begin
        	lookup_en_d1 <= lookup_en ;
        	key_d1 <= key;
		end

        if  (~l1clk_mat & ~l2clk & lookup_en_d1 & ~(write_disable|bypass) ) begin

		tmp_addr0 = mb_cam_data[0];
                match_p[0] =  ( tmp_addr0[39:7] == key_d1[39:7] ) ;
                match_idx_p[0] = ( tmp_addr0[17:9] == key_d1[17:9] ) ;

                tmp_addr1 = mb_cam_data[1];
                match_p[1] =  ( tmp_addr1[39:7] == key_d1[39:7] ) ;
                match_idx_p[1] = ( tmp_addr1[17:9] == key_d1[17:9] ) ;

                tmp_addr2 = mb_cam_data[2];
                match_p[2] =  ( tmp_addr2[39:7] == key_d1[39:7] ) ;
                match_idx_p[2] = ( tmp_addr2[17:9] == key_d1[17:9] ) ;

                tmp_addr3 = mb_cam_data[3];
                match_p[3] =  ( tmp_addr3[39:7] == key_d1[39:7] ) ;
                match_idx_p[3] = ( tmp_addr3[17:9] == key_d1[17:9] ) ;

                tmp_addr4 = mb_cam_data[4];
                match_p[4] =  ( tmp_addr4[39:7] == key_d1[39:7] ) ;
                match_idx_p[4] = ( tmp_addr4[17:9] == key_d1[17:9] ) ;

                tmp_addr5 = mb_cam_data[5];
                match_p[5] =  ( tmp_addr5[39:7] == key_d1[39:7] ) ;
                match_idx_p[5] = ( tmp_addr5[17:9] == key_d1[17:9] ) ;

                tmp_addr6 = mb_cam_data[6];
                match_p[6] =  ( tmp_addr6[39:7] == key_d1[39:7] ) ;
                match_idx_p[6] = ( tmp_addr6[17:9] == key_d1[17:9] ) ;

                 tmp_addr7 = mb_cam_data[7];
                match_p[7] =  ( tmp_addr7[39:7] == key_d1[39:7] ) ;
                match_idx_p[7] = ( tmp_addr7[17:9] == key_d1[17:9] ) ;
	end
        else if (~l1clk_mat & ~l2clk & (~lookup_en_d1 |write_disable|bypass) ) begin
                match_p = 8'b0;
                match_idx_p = 8'b0;
        end
	if (l1clk_mat & l2clk) begin
                match_p = 8'b0;
                match_idx_p = 8'b0;
        end

end

// READ AND WRITE HAPPEN in Phase 1.

// write_disable_d1 & reset_l_d1 are part of the
// list because we want to enter the following
// always block under the following condition:
// - wr_addr , din , wr_en remain the same across the
// rising edge of the clock
// - write_disable or reset_l change across the rising edge of the
// clock from high to low.

always  @(l1clk or rd_en or rd_addr or l2clk or wr_addr or din or wr_en  or write_disable or bypass ) begin
  begin
    if (l1clk & l2clk & wr_en  & ~(write_disable|bypass)) 
	begin
        case(wr_addr )
          8'b0000_0000: ;  // do nothing
          8'b0000_0001: mb_cam_data[0] = din ;
          8'b0000_0010: mb_cam_data[1] = din ;
          8'b0000_0100: mb_cam_data[2] = din ;
          8'b0000_1000: mb_cam_data[3] = din ;
          8'b0001_0000: mb_cam_data[4] = din;
          8'b0010_0000: mb_cam_data[5] = din ;
          8'b0100_0000: mb_cam_data[6] = din ;
          8'b1000_0000: mb_cam_data[7] = din ;
          //8'b1111_1111:
            //    begin
                    //    mb_cam_data[7] = din ;
                    //    mb_cam_data[6] = din ;
                    //    mb_cam_data[5] = din ;
                    //    mb_cam_data[4] = din ;
                    //    mb_cam_data[3] = din ;
                    //    mb_cam_data[2] = din ;
                    //    mb_cam_data[1] = din ;
                    //    mb_cam_data[0] = din ;
               // end
          default: begin
		// 0in <fire -message "FATAL ERROR: incorrect write wordline" -group mbist_mode
		   end
        endcase
	if(rd_en & (rd_addr == wr_addr))
         begin
		// 0in < known_driven -var rd_addr -message "read pointer write pointer conflict" -group mbist_mode
      	 end
      end
  end

end



// reset_l_d1 has purely been added so that we enter the always
// block when the wordline/wr_en does not change across clk cycles
// but the reset_l does.
// Notice reset_l_d1 is not used in any of the "if" statements.
// Notice that the renable is qualified with l1clk to take
// care that we do not read from the array if reset_l goes high
// during the negative phase of l1clk.
//

always  @( /*memory or*/ rd_addr or wr_addr or l1clk or l2clk
          or rd_en or wr_en or write_disable or
          mb_cam_data_0 or mb_cam_data_1 or mb_cam_data_2 or mb_cam_data_3
          or mb_cam_data_4 or mb_cam_data_5 or mb_cam_data_6 or mb_cam_data_7
	  or din or bypass) begin
  if (bypass) begin
     dout <= din;
  end
  else if (rd_en & l1clk & write_disable ) begin
//                dout <= 40'hff_ffff_ffff ;
  end
  else if (rd_en & l1clk & ~write_disable) begin
    if ((wr_en) && (rd_addr == wr_addr) )
      begin
             dout <= 40'bx ;
// 0in < known_driven -var rd_addr -message "read pointer write pointer conflict" -group mbist_mode
      end
    else
      begin
        case(rd_addr)
          // match sense amp ckt behavior when no read wl is selected
          8'b0000_0000: dout <= 40'hff_ffff_ffff ;
          8'b0000_0001: dout <= mb_cam_data_0  ;
          8'b0000_0010: dout <= mb_cam_data_1  ;
          8'b0000_0100: dout <= mb_cam_data_2  ;
          8'b0000_1000: dout <= mb_cam_data_3  ;
          8'b0001_0000: dout <= mb_cam_data_4  ;
          8'b0010_0000: dout <= mb_cam_data_5  ;
          8'b0100_0000: dout <= mb_cam_data_6  ;
          8'b1000_0000: dout <= mb_cam_data_7  ;
          default: begin
		// 0in <fire -message "FATAL ERROR: incorrect read wordline" -group mbist_mode
		end
        endcase
      end

        end // of else if
end
endmodule


//////////////////////////////////////////
////// n2_l2t_dp_16x160_cust     
//////////////////////////////////////////

module n2_l2t_dp_16x160_cust_array (
  l1clk, 
  wr_en, 
  rd_en, 
  tcu_array_wr_inhibit, 
  word_wen, 
  wr_addr, 
  rd_addr, 
  din, 
  byte_wen, 
  dout);
wire write_disable;


input		l1clk;
input 		wr_en;
input 		rd_en;
input 		tcu_array_wr_inhibit;
input [3:0] 	word_wen;
input [3:0] 	wr_addr;
input [3:0] 	rd_addr;
input [159:0] 	din;
input [19:0] 	byte_wen;

output [159:0] 	dout;


assign write_disable = tcu_array_wr_inhibit;


wire reset_l;
assign reset_l = 1'b1;











 
// memory array
reg [159:0]  inq_ary [15:0];

integer     rd_i; 
integer     wr_i; 
integer	    rd_j; 
integer     wr_j;

reg [159:0] dout;
reg [159:0] data_in;
reg [159:0] temp;
reg [159:0] tmp_dout;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
  for (i=0; i<16; i=i+1) begin
   inq_ary[i] = {160{1'b0}};
  end
end
`endif


// Moved into always block for AXIs
//   assign tmp_dout = inq_ary[rd_addr] ;
//   assign temp = inq_ary[wr_addr];

//////////////////////////////////////////////////////////////////////
//
// 			Read Operation
//
//////////////////////////////////////////////////////////////////////

always @( byte_wen or rd_addr or rd_en or reset_l or write_disable  
	  or word_wen or wr_en or wr_addr or l1clk)


    #0

begin
          if ((rd_en==1'b1) & l1clk & ~write_disable)
            begin
              rd_j = 0;
	      tmp_dout = inq_ary[rd_addr] ;
              for (rd_i=0; rd_i<= 159; rd_i=rd_i+8)
                begin
                  if (rd_addr == wr_addr)
                    begin
                      dout[rd_i]   = (wr_en & word_wen[0] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i] ;
                      dout[rd_i+1] = (wr_en & word_wen[1] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+1] ;
                      dout[rd_i+2] = (wr_en & word_wen[2] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+2] ;
                      dout[rd_i+3] = (wr_en & word_wen[3] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+3] ;
                      dout[rd_i+4] = (wr_en & word_wen[0] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+4] ;
                      dout[rd_i+5] = (wr_en & word_wen[1] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+5] ;
                      dout[rd_i+6] = (wr_en & word_wen[2] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+6] ;
                      dout[rd_i+7] = (wr_en & word_wen[3] & byte_wen[rd_j] & ~write_disable) ?
                                      1'bx : tmp_dout[rd_i+7] ;
                      rd_j = rd_j+1;
                    end
                  else
                    begin
                      dout[rd_i]   = tmp_dout[rd_i] ;
                      dout[rd_i+1] = tmp_dout[rd_i+1] ;
                      dout[rd_i+2] = tmp_dout[rd_i+2] ;
                      dout[rd_i+3] = tmp_dout[rd_i+3] ;
                      dout[rd_i+4] = tmp_dout[rd_i+4] ;
                      dout[rd_i+5] = tmp_dout[rd_i+5] ;
                      dout[rd_i+6] = tmp_dout[rd_i+6] ;
                      dout[rd_i+7] = tmp_dout[rd_i+7] ;
                    end
                end
            end
      else 
		dout[159:0] = dout[159:0];
  end 



//////////////////////////////////////////////////////////////////////
//
// 			Write Operation
//
//////////////////////////////////////////////////////////////////////

always @ (byte_wen or reset_l or write_disable or word_wen 
	  or wr_en or din or wr_addr or l1clk)


    #0

begin
//if (reset_l)
//  begin
    if (wr_en & ~write_disable & ~l1clk)
    begin
        wr_j = 0;
	temp = inq_ary[wr_addr];
        for (wr_i=0; wr_i<=159; wr_i=wr_i+8)
             begin // for
             data_in[wr_i]   = (wr_en & word_wen[0] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i]   : temp[wr_i] ;
             data_in[wr_i+1] = (wr_en & word_wen[1] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+1] : temp[wr_i+1] ;
             data_in[wr_i+2] = (wr_en & word_wen[2] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+2] : temp[wr_i+2] ;
             data_in[wr_i+3] = (wr_en & word_wen[3] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+3] : temp[wr_i+3] ;
             data_in[wr_i+4] = (wr_en & word_wen[0] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+4] : temp[wr_i+4] ;
             data_in[wr_i+5] = (wr_en & word_wen[1] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+5] : temp[wr_i+5] ;
             data_in[wr_i+6] = (wr_en & word_wen[2] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+6] : temp[wr_i+6] ;
             data_in[wr_i+7] = (wr_en & word_wen[3] & byte_wen[wr_j] & ~write_disable) ?
                              din[wr_i+7] : temp[wr_i+7] ;
             wr_j = wr_j+1;
             end // for
             	inq_ary[wr_addr] = data_in ;
        end  // if(wr_en.....
   //end // if reset
end  // always


endmodule


//////////////////////////////////////////
////// n2_l2t_dp_32x160_cust      
//////////////////////////////////////////


module n2_l2t_dp_32x160_cust_array (
  l1clk, 
  wr_en, 
  rd_en, 
  tcu_array_wr_inhibit, 
  word_wen, 
  wr_addr, 
  rd_addr, 
  din, 
  dout);
wire write_disable;


input 		l1clk;
input 		wr_en;
input 		rd_en;
input 		tcu_array_wr_inhibit;
input [3:0] 	word_wen;
input [4:0] 	wr_addr;
input [4:0] 	rd_addr;
input [159:0] 	din;
output [159:0] 	dout;


assign write_disable = tcu_array_wr_inhibit;
//assign read_disable = tcu_array_wr_inhibit;












// local signals
reg [159:0] dout;
// memory array
reg [159:0]  inq_ary [31:0];

// internal variable

integer      rd_i;
integer      wr_i;

reg [159:0]  temp, tmp_dout;
reg [159:0]   data_in;



`ifndef NOINITMEM
// Emulate reset
integer j1;
initial begin
  for (j1=0; j1<32; j1=j1+1) begin
   inq_ary [j1] = {160{1'b0}};
  end
end
`endif


/////////////////////////////////////////////////////////////////////////////////
// Read Operation
/////////////////////////////////////////////////////////////////////////////////

always @(rd_addr or rd_en or tmp_dout or write_disable or word_wen or wr_en or wr_addr or l1clk)
begin
    if(l1clk) begin

     if (rd_en & ~write_disable)
        begin
	 for(rd_i=0; rd_i< 160; rd_i=rd_i+4) 
	
	 begin
		tmp_dout =  inq_ary[rd_addr] ;

		if((rd_addr == wr_addr)) begin
	 		dout[rd_i] =   ( word_wen[0] & wr_en & ~write_disable )? 
					1'bx : tmp_dout[rd_i] ;
	 		dout[rd_i+1] = ( word_wen[1] & wr_en & ~write_disable )? 
                                               1'bx : tmp_dout[rd_i+1] ;
	 		dout[rd_i+2] = ( word_wen[2] & wr_en & ~write_disable )? 
                                               1'bx : tmp_dout[rd_i+2] ;
	 		dout[rd_i+3] = ( word_wen[3] & wr_en & ~write_disable )? 
                                               1'bx : tmp_dout[rd_i+3] ;
		end

		else begin
			dout[rd_i]   = tmp_dout[rd_i] ;
			dout[rd_i+1] = tmp_dout[rd_i+1] ;
			dout[rd_i+2] = tmp_dout[rd_i+2] ;
			dout[rd_i+3] = tmp_dout[rd_i+3] ;
		end
	 end  // for
        end   // rd_en if
       else 
	 dout  = 160'h0;
    end // l1clk if
end  // always




/////////////////////////////////////////////////////////////////////////////////
// Write Operation
/////////////////////////////////////////////////////////////////////////////////

always @(write_disable or word_wen or wr_en or din or wr_addr or temp or l1clk)
begin
	if(wr_en & ~write_disable & ~l1clk)   
		begin
		temp 	   =  inq_ary[wr_addr];
		for (wr_i=0; wr_i<160; wr_i=wr_i+4) 
			begin
			data_in[wr_i] = ( word_wen[0] & wr_en & ~write_disable ) ? 
						din[wr_i] : temp[wr_i] ;
			data_in[wr_i+1] = ( word_wen[1] & wr_en & ~write_disable ) ? 
						din[wr_i+1] : temp[wr_i+1] ;
			data_in[wr_i+2] = ( word_wen[2] & wr_en & ~write_disable ) ? 
						din[wr_i+2] : temp[wr_i+2] ;
			data_in[wr_i+3] = ( word_wen[3] & wr_en & ~write_disable ) ? 
							din[wr_i+3] : temp[wr_i+3] ;
     			end
     			inq_ary[wr_addr] = data_in ;
		end
end // always @ (...



endmodule // rf_32x160


//////////////////////////////////////////
////// n2_mcu_32x72async_dp_cust       
//////////////////////////////////////////

module n2_mcu_32x72async_dp_cust_n2_com_array_macro__rows_32__width_72__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[72-1:0]	din;
output	[72-1:0]	dout; 



reg	[72-1:0]	mem[32-1:0];
reg	[72-1:0]	local_dout;

`ifndef NOINITMEM
// Emulate reset
integer i;
initial begin
 for (i=0; i<32; i=i+1) begin
   mem[i] = 72'b0;
 end
 local_dout = 72'b0;
end
`endif
//////////////////////
// Read/write array
//////////////////////
always @(negedge wclk) begin
   if (wr_en) begin
       mem[wr_adr] <= din;


   end
end
always @(rclk or rd_en or wr_en or rd_adr or wr_adr) begin
   if (rclk) begin
     if (rd_en) begin
         if (wr_en & (wr_adr[4:0] == rd_adr[4:0]))
             local_dout[72-1:0] <= 72'hx;
         else
             local_dout[72-1:0] <= mem[rd_adr] ;
     end
     else
             local_dout[72-1:0] <= ~(72'h0);
  end
end
assign dout[72-1:0] = local_dout[72-1:0];
supply0 vss;
supply1 vdd;

endmodule


//////////////////////////////////////////
////// n2_iom_sp_devtsb_cust        
//////////////////////////////////////////

module n2_iom_sp_1024b_cust (

  clk,
  adr_r,
  adr_w,
  rd,
  wr,
  din,
  dout

);


  input		 clk;
  input	[3:0]	 adr_r;
  input	[3:0]	 adr_w;
  input          rd;
  input	 	 wr;
  input  [63:0]  din;
  output [63:0]  dout;


/* RAM Array: =16 - 1        -> 15    */

reg     [63:0]  array_ram      [0:15];
reg     [63:0]  dout;

`ifndef NOINITMEM
integer i;

initial begin
  for (i=0; i<16; i=i+1) begin
    array_ram[i] = 64'b0;
  end
dout[63:0] = 64'b0;
end
`endif


// ----------------------------------------------------------------------------
// Read/write the array, single port
// ----------------------------------------------------------------------------
always @(clk or rd or adr_r or wr or adr_w or din  ) begin
        if (clk) begin
        if (rd ) begin
        dout[63:0] <=     array_ram[adr_r[3:0]];
        end
	else begin
        dout[63:0] <=     {64{1'b0}};
	if (wr )
        array_ram[adr_w[3:0]] <= din[63:0];
	end
        end
end


endmodule       // n2_iom_sp_1024b_cust



module n2_iom_sp_2048b_cust (

  clk,
  adr_r,
  adr_w,
  rd,
  wr,
  din,
  dout,
  efu_bits

);


  input		 clk;
  input	[4:0]	 adr_r;
  input	[4:0]	 adr_w;
  input          rd;
  input	 	 wr;
  input  [63:0]  din;
  input  [3:0]   efu_bits;
  output [63:0]  dout;


/* RAM Array: =32 - 1        -> 31    */

reg     [63:0]  array_ram      [0:31];
reg     [63:0]  dout;

`ifndef NOINITMEM
integer i;

initial begin
  for (i=0; i<32; i=i+1) begin
    array_ram[i] = 64'b0;
  end
dout[63:0] = 64'b0;
end
`endif

// 0in one_hot -var efu_bits
// ----------------------------------------------------------------------------
// Read/write the array , single port
// ----------------------------------------------------------------------------
always @(clk or rd or adr_r or wr or adr_w or din or efu_bits) begin

        if (clk) begin
        if (rd) begin
                if (efu_bits[0]) begin
              dout[63:0] <=     array_ram[adr_r[4:0]];
                end
                else if (efu_bits[1]) begin
              dout[63:0] <=      array_ram[adr_r[4:0]];
                end
                else if (efu_bits[2]) begin
              dout[63:0] <=      array_ram[adr_r[4:0]];
                end
                else if (efu_bits[3]) begin
              dout[63:0] <=      array_ram[adr_r[4:0]];
                end
            end
	else begin
	dout[63:0] <= {64{1'b0}};
        if(wr ) 
        array_ram[adr_w[4:0]] <= din[63:0];
	end
        end
end


endmodule       // n2_iom_sp_2048b_cust


//////////////////////////////////////////
////// n2_dmu_dp_128x132s_cust         
//////////////////////////////////////////

module n2_dmu_dp_128x132s_cust_array	(

   // ram control
   clk,
   rd_addr_array,
   wr_addr_array,
   rd_array, 
   wr_array,
   din_array, 
   dout_array    

);




   // 
   input 		clk;				// clk 
   input [6:0]		rd_addr_array;			// read port address in
   input [6:0]		wr_addr_array;			// write port address in
   input		rd_array;			// read port enable
   input		wr_array;			// write port enable
   input [131:0] 	din_array;			// data in
   output [131:0] 	dout_array;			// data out


// ----------------------------------------------------------------------------
// Zero In Checkers
// ----------------------------------------------------------------------------
// checker to verify on accesses's that no bits are x
/* //BP 0in assert -var (((|rd_addr_array[6:0] ) == 1'bx)
                    || ((|wr_addr_array[6:0] ) == 1'bx)
                    || ((rd_en_array ) == 1'bx)
                    || ((wr_en_array ) == 1'bx)
               -active (rd_en_array )
               -module dmu_ram128x132_array
                -name dmu_ram128x132_array_x
*/
  // 0in kndr -var rd_addr_array
  // 0in kndr -var wr_addr_array
  // 0in kndr -var rd_array
  // 0in kndr -var wr_array
  // 0in kndr -var din_array -active (wr_array )


/* RAM Array: =128 - 1        -> 127    */

reg     [131:0]  array_ram      [0:127];
reg	[131:0]	dout_array;

// Initialize the array
`ifndef NOINITMEM
integer i;

initial begin
  for (i=0; i<128; i=i+1) begin
    array_ram[i] = 132'b0;
  end
end
`endif


// ----------------------------------------------------------------------------
// Read the array
// ----------------------------------------------------------------------------
//assign	dout_array[131:0] =	array_ram[rd_addr_array[6:0]];
always @(clk or rd_array or  rd_addr_array or wr_array or wr_addr_array ) begin
	if (clk) begin
	if (rd_array) begin
                if (wr_array  & (rd_addr_array == wr_addr_array)) begin
                dout_array[131:0] <= {132{1'bx}}; //0in <fire -severity 1 -message " got x's in dmu/dou" -group mbist_mode
                end
        	else begin
		dout_array[131:0] <=     array_ram[rd_addr_array[6:0]];
		end
	end
	else begin
		dout_array[131:0] <=     {132{1'b0}};
	end
	end
end



// ----------------------------------------------------------------------------
// Write the array, note: it is written when the clock is low
// ----------------------------------------------------------------------------
always @(wr_array or  wr_addr_array or clk or din_array ) begin
	if(~clk) begin
	if(wr_array ) begin
	array_ram[wr_addr_array[6:0]] <= din_array[131:0];
	end
	end
end



endmodule	// n2_dmu_dp_128x132s_cust_array


//////////////////////////////////////////
////// n2_dmu_dp_144x149s_cust          
//////////////////////////////////////////

module n2_dmu_dp_144x149s_cust_array	(

   // ram control
   clk,
   rd_addr_array,
   wr_addr_array,
   rd_array, 
   wr_array,
   din_array, 
   dout_array    

);




   // 
   input 		clk;				// clk 
   input [7:0]		rd_addr_array;			// read port address in
   input [7:0]		wr_addr_array;			// write port address in
   input		rd_array;			// read port enable
   input		wr_array;			// write port enable
   input [148:0] 	din_array;			// data in
   output [148:0] 	dout_array;			// data out


// ----------------------------------------------------------------------------
// Zero In Checkers
// ----------------------------------------------------------------------------
// checker to verify on accesses's that no bits are x
/* //BP0in assert -var (((|rd_addr_array[7:0] ) == 1'bx)
                    || ((|wr_addr_array[7:0] ) == 1'bx)
                    || ((rd_en_array ) == 1'bx)
                    || ((wr_en_array ) == 1'bx)
               -active (rd_en_array )
               -module dmu_ram144x149_array
                -name dmu_ram144x149_array_x
*/
  // 0in kndr -var rd_addr_array
  // 0in kndr -var wr_addr_array
  // 0in kndr -var rd_array
  // 0in kndr -var wr_array
  // 0in kndr -var din_array -active (wr_array )




/* RAM Array: =144 - 1        -> 143    */

reg     [148:0]  array_ram      [0:143];
//reg     [148:0]  array_ram      [0:191];
reg	[148:0]	dout_array;

// Initialize the array
`ifndef NOINITMEM
integer i;

initial begin
  for (i=0; i<144; i=i+1) begin
    array_ram[i] = 149'b0;
  end
end
`endif

// ----------------------------------------------------------------------------
// Read the array
// ----------------------------------------------------------------------------
//assign	dout_array[148:0] =	array_ram[rd_addr_array[7:0]];
always @(clk or rd_array or  rd_addr_array or wr_array or wr_addr_array ) begin
        if (clk) begin
        if (rd_array) begin
		if ( (wr_array  & (rd_addr_array == wr_addr_array)) ||
			(rd_addr_array >= 144) ) begin
		dout_array[148:0] <= {149{1'bx}}; //0in <fire -severity 1 -message " got x's in dmu/dou" -group mbist_mode
		end
        	else begin
		dout_array[148:0] <=     array_ram[rd_addr_array[7:0]];
        	end
        end
	else begin
		dout_array[148:0] <=     {149{1'b1}};
	end
        end
end




// ----------------------------------------------------------------------------
// Write the array, note: it is written when the clock is low
// ----------------------------------------------------------------------------
always @(wr_array or  wr_addr_array or clk or din_array  ) begin
	if(~clk) begin
	if(wr_array ) begin
	array_ram[wr_addr_array[7:0]] <= din_array[148:0];
	end
	end
end



endmodule	// n2_dmu_dp_144x149s_cust_array


//////////////////////////////////////////
////// n2_dmu_dp_512x60s_cust           
//////////////////////////////////////////

module n2_dmu_dp_512x60s_cust_array	(

   // ram control
   clk,
   rd_addr_array,
   wr_addr_array,
   rd_array, 
   wr_array,
   din_array, 
   dout_array    

);




   // 
   input 		clk;				// clk 
   input [8:0]		rd_addr_array;			// read port address in
   input [8:0]		wr_addr_array;			// write port address in
   input		rd_array;			// read port enable
   input		wr_array;			// write port enable
   input [59:0] 	din_array;			// data in
   output [59:0] 	dout_array;			// data out


// ----------------------------------------------------------------------------
// Zero In Checkers
// ----------------------------------------------------------------------------
// checker to verify on accesses's that no bits are x
/* //BP 0in assert -var (((|rd_addr_array[8:0] ) == 1'bx)
                    || ((|wr_addr_array[8:0] ) == 1'bx)
                    || ((rd_en_array ) == 1'bx)
                    || ((wr_en_array ) == 1'bx)
               -active (rd_en_array )
               -module dmu_ram512x36_array
                -name dmu_ram512x36_array_x
*/
  // 0in kndr -var rd_addr_array
  // 0in kndr -var wr_addr_array
  // 0in kndr -var rd_array
  // 0in kndr -var wr_array
  // 0in kndr -var din_array -active (wr_array )


/* RAM Array: =512 - 1        -> 511    */

reg     [59:0]  array_ram      [0:511];
reg	[59:0]	dout_array;

`ifndef NOINITMEM
integer	i;

initial begin
  for (i=0; i<512; i=i+1) begin
    array_ram[i] = 60'b0;
  end
  dout_array = 60'b0;
end
`endif


// ----------------------------------------------------------------------------
// Read the array
// ----------------------------------------------------------------------------
//assign	dout_array[35:0] =	array_ram[rd_addr_array[8:0]];
always @(clk or rd_array or  rd_addr_array or wr_addr_array or wr_array ) begin
	if (clk) begin
        if (rd_array) begin
		if (wr_array  & (rd_addr_array == wr_addr_array)) begin
                dout_array[59:0] <= {60{1'bx}}; //0in < fire -severity 1 -message " got x's in dmu/tdb" -group mbist_mode
                end
        	else begin
		dout_array[59:0] <=     array_ram[rd_addr_array[8:0]];
        	end
	end
	else begin
		dout_array[59:0] <=    {60{1'b0}};
	end
        end
end





// ----------------------------------------------------------------------------
// Write the array, note: it is written when the clock is low
// ----------------------------------------------------------------------------
always @(wr_array or wr_addr_array or clk or din_array  ) begin
	if(~clk) begin
	if(wr_array ) begin
	array_ram[wr_addr_array[8:0]] <= din_array[59:0];
	end
	end
end



endmodule	// n2_dmu_dp_512x60s_cust_array





