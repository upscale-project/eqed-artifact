module spc_checker_bind;
   

   bind spc_wrapper.spc.exu0.irf.irf_array  spc_checker chk0 (.clk(clk),
                                       .rst(1'b0),
                                       .ena(1'b1),
                                       .reg0 (active_window[0]),
                                       .reg1 (active_window[1]),
                                       .reg2 (active_window[2]),
                                       .reg3 (active_window[3]),
                                       .reg4 (active_window[4]),
                                       .reg5 (active_window[5]),
                                       .reg6 (active_window[6]),
                                       .reg7 (active_window[7]),
                                       .reg8 (active_window[8]),
                                       .reg9 (active_window[9]),
                                       .reg10(active_window[10]),
                                       .reg11(active_window[11]),
                                       .reg12(active_window[12]),
                                       .reg13(active_window[13]),
                                       .reg14(active_window[14]),
                                       .reg15(active_window[15]),
                                       .reg16(active_window[16]),
                                       .reg17(active_window[17]),
                                       .reg18(active_window[18]),
                                       .reg19(active_window[19]),
                                       .reg20(active_window[20]),
                                       .reg21(active_window[21]),
                                       .reg22(active_window[22]),
                                       .reg23(active_window[23]),
                                       .reg24(active_window[24]),
                                       .reg25(active_window[25]),
                                       .reg26(active_window[26]),
                                       .reg27(active_window[27]),
                                       .reg28(active_window[28]),
                                       .reg29(active_window[29]),
                                       .reg30(active_window[30]),
                                       .reg31(active_window[31]));

endmodule // spc_checker_bind

   