module Decoder
(
	input [2:0] state,
	input [3:0] inst,
	input eq,
	output acc_load,
	output e,
	output WrEn,
	output pc_load,
	output pc_inc,
	output p,
	output prog_mux,
	output ld_mux
	
);
	wire lda, sta, add, jmp, stp, ldi, jms, bbl, ldr, jeq;
	wire fetch, exec1, exec2;
	
	assign ldi = ~inst[3] & ~inst[2] & ~inst[1] & ~inst[0];
	assign sta = ~inst[3] & ~inst[2] & ~inst[1] & inst[0];
	assign add = ~inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign jmp = ~inst[3] & ~inst[2] & inst[1] & inst[0];
	assign stp = ~inst[3] & inst[2] & ~inst[1] & ~inst[0];
	assign lda = ~inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jms = ~inst[3] & inst[2] & inst[1] & ~inst[0];
	assign bbl = ~inst[3] & inst[2] & inst[1] & inst[0];
	assign ldr = inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jeq = inst[3] & inst[2] & inst[1] & ~inst[0];
	
	assign fetch = state[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	
	assign p = 0; //~fetch & (lda | ldi | jmp)
	assign e = lda | add | ldr;
	assign WrEn = exec1 & sta;
	assign pc_load = exec1 & (jmp | jeq & ~eq);
	assign pc_inc = exec1 & ~(stp | (jmp | jeq & ~eq));
	assign acc_load = (exec1 & ldi) | (exec2 & (lda | add | ldr));
	assign prog_mux = 0;
	assign ld_mux = ldi;

endmodule

