module Decoder
(
	input [2:0] state,
	input [4:0] inst,
	input eq,
	output stack_mux,
	output acc_load,
	output WrEn,
	output pc_load,
	output pc_inc,
	output e,
	output push,
	output pop,
	output jump_mux,
	output add_mux
);
	wire lda, sta, jmp, stp, jms, bbl, ldr, jeq, add;
	wire fetch, exec1, exec2;
	
	assign sta = ~inst[4] & ~inst[3] & ~inst[2] & ~inst[1];
	assign jmp = ~inst[4] & ~inst[3] & ~inst[2] & inst[1];
	assign stp = ~inst[4] & inst[3] & ~inst[2] & ~inst[1];
	assign lda = ~inst[4] & inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign add = ~inst[4] & inst[3] & ~inst[2] & inst[1] & inst[0];
	assign jms = ~inst[4] & inst[3] & inst[2] & ~inst[1];
	assign bbl = ~inst[4] & inst[3] & inst[2] & inst[1];
	assign ldr = inst[4] & inst[3] & inst[2] & ~inst[1];
	assign jeq = ~inst[4] & ~inst[3] & inst[2];
	
	assign fetch = state[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	
	assign e = lda |ldr | add;
	assign WrEn = exec1 & sta;
	assign pc_load = exec1 & (stp | jmp | jeq & ~eq | bbl | jms);
	assign pc_inc = fetch | exec2;
	assign acc_load = exec2 & (lda | ldr | add);
	assign stack_mux = bbl;
	assign push = jms & exec1;
	assign pop = bbl & exec1;
	assign jump_mux = exec1 & (stp | jmp | jeq & ~eq | bbl | jms);
	assign add_mux = add;
	

endmodule

