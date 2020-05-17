module decoder
(
	input [2:0] state,
	input [3:0] inst,
	input eq_bar,
	input mi,
	output e,
	output mux1,
	output WrEn,
	output pc_load,
	output pc_inc,
	output acc_load,
	output acc_shift,
	output mux3,
	output alu,
	output ldi
	
);
	wire lda, sta, add, sub,  jmp, jeq, jmi, stp,  lsl, lsr;
	wire fetch, exec1, exec2;
	
	assign lda = ~inst[3] & ~inst[2] & ~inst[1] & ~inst[0];
	assign sta = ~inst[3] & ~inst[2] & ~inst[1] & inst[0];
	assign add = ~inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign sub = ~inst[3] & ~inst[2] & inst[1] & inst[0];
	assign jmp = ~inst[3] & inst[2] & ~inst[1] & ~inst[0];
	assign jmi = ~inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jeq = ~inst[3] & inst[2] & inst[1] & ~inst[0];
	assign stp = ~inst[3] & inst[2] & inst[1] & inst[0];
	assign ldi = inst[3] & ~inst[2] & ~inst[1] & ~inst[0];
	assign lsl = inst[3] & ~inst[2] & ~inst[1] & inst[0];
	assign lsr = inst[3] & ~inst[2] & inst[1] & ~inst[0];
	
	assign fetch = state[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	
	assign e = lda | add | sub;
	assign mux1 = ~fetch & (lda | sta | add | sub);
	assign WrEn = ~fetch & sta;
	assign pc_load = exec1 & (jmp | (jmi & mi) | (jeq & ~eq_bar));
	assign pc_inc = exec1 & ~(stp | jmp | (jmi & mi) | (jeq & ~eq_bar));
	assign acc_load = (exec1 & ldi) | (exec2 & (lda | add | sub));
	assign acc_shift = exec1 & lsr;
	assign mux3 = add | sub;
	assign alu = add;

endmodule
