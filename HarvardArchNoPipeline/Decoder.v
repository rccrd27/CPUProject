module Decoder
(
	input [2:0] state,
	input [3:0] inst,
	input eq,
	output acc_load,
	output e,
	output WrEn,
	output pc_load,
	output pc_inc
);
	wire lda, sta, jmp, stp, jms, bbl, ldr, jeq;
	wire fetch, exec1, exec2;
	
	assign sta = ~inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign jmp = ~inst[3] & ~inst[2] & inst[1] & inst[0];
	assign stp = ~inst[3] & inst[2] & ~inst[1] & ~inst[0];
	assign lda = ~inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jms = ~inst[3] & inst[2] & inst[1] & ~inst[0];
	assign bbl = ~inst[3] & inst[2] & inst[1] & inst[0];
	assign ldr = inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jeq = ~inst[3] & ~inst[2] & ~inst[1];
	
	assign fetch = state[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	
	assign e = lda |ldr;
	assign WrEn = exec1 & sta;
	assign pc_load = exec1 & (jmp | jeq & ~eq);
	assign pc_inc = exec1 & ~(stp | (jmp | jeq & ~eq));
	assign acc_load = exec2 & (lda |ldr);

endmodule

