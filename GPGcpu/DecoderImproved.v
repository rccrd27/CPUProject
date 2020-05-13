module DecoderImproved
(
	input [2:0] state,
	input [3:0] inst,
	input [2:0] jmp_flags,
	output [5:0] data_ctrl,
	output e,
	output mux1,
	output WrEn,
	output pc_load,
	output pc_inc,
	output s
	
);
	wire acc_load, acc_shift, mux3, alu, acc_shiftin, cy_en;
	wire eq_bar, mi, cy;
	wire lda, sta, add, sub,  jmp, jeq, jmi, stp, ldi, lsl, lsr, asr, jcy, xch;
	wire fetch, exec1, exec2;
	
	assign eq_bar = jmp_flags[2];
	assign mi = jmp_flags[1];
	assign cy = jmp_flags[0];
	
	assign ldi = ~inst[3] & ~inst[2] & ~inst[1] & ~inst[0];
	assign sta = ~inst[3] & ~inst[2] & ~inst[1] & inst[0];
	assign add = ~inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign sub = ~inst[3] & ~inst[2] & inst[1] & inst[0];
	assign jmp = ~inst[3] & inst[2] & ~inst[1] & ~inst[0];
	assign jmi = ~inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jeq = ~inst[3] & inst[2] & inst[1] & ~inst[0];
	assign stp = ~inst[3] & inst[2] & inst[1] & inst[0];
	assign lda = inst[3] & ~inst[2] & ~inst[1] & ~inst[0];
	assign lsl = inst[3] & ~inst[2] & ~inst[1] & inst[0];
	assign lsr = inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign asr = inst[3] & ~inst[2] & inst[1] & inst[0];
	assign jcy = inst[3] & inst[2] & ~inst[1] & ~inst[0];
	assign xch = inst[3] & inst[2] & ~inst[1] & inst[0];
	
	assign fetch = state[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	
	assign e = lda | add | sub | xch;
	assign mux1 = exec1 & (lda | sta | add | sub | xch);
	assign WrEn = (exec1 & sta) | (exec2 & xch);
	assign pc_load = exec1 & (jmp | (jmi & mi) | (jeq & ~eq_bar) | (jcy & cy));
	assign pc_inc = exec1 & ~(stp | jmp | (jmi & mi) | (jeq & ~eq_bar) | (jcy & cy));
	assign acc_load = (exec1 & ldi) | (exec2 & (lda | add | sub | xch));
	assign acc_shift = exec1 & (lsr | asr);
	assign mux3 = add | sub;
	assign alu = add;
	assign acc_shiftin = asr & mi;
	assign cy_en = add | sub;
	assign s = ~(sta | stp | jmp | (jmi & mi) | (jeq & ~eq_bar) | (jcy & cy) | xch);
	
	assign data_ctrl = {cy_en, acc_shiftin, alu, mux3, acc_shift, acc_load};

endmodule
