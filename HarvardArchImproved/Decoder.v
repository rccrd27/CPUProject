module Decoder
(
	input [3:0] state,
	input [3:0] inst,
	input eq,
	output [1:0] jump_mux,
	output WrEn,
	output pc_load,
	output pc_inc,
	output acc_load,
	output e,
	output m,
	output push,
	output pop,
	output data_mux,
	output load_mux,
	output reg_mux
);
	wire lda, sta, jmp, stp, jms, bbl, ldr, str, mul, jeq, jmc;
	wire fetch, exec1, exec2, exec3;
	
	assign sta = ~inst[3] & ~inst[2] & ~inst[1] & ~inst[0];
	assign jmp = ~inst[3] & ~inst[2] & ~inst[1] & inst[0];
	assign stp = ~inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign lda = ~inst[3] & ~inst[2] & inst[1] & inst[0];
	assign jms = ~inst[3] & inst[2] & ~inst[1] & ~inst[0];
	assign bbl = ~inst[3] & inst[2] & ~inst[1] & inst[0];
	assign ldr = inst[3] & inst[2] & inst[1] & ~inst[0];
	assign str = inst[3] & inst[2] & inst[1] & inst[0];
	assign mul = inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jeq = ~inst[3] & inst[2] & inst[1] & ~inst[0];
	assign jmc = ~inst[3] & inst[2] & inst[1] & inst[0];
	
	assign fetch = state[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	assign exec3 = state[3];
	
	assign e = lda | ldr | mul;
	assign m = mul;
	assign WrEn = exec1 & (sta | str);
	assign pc_load = exec1 & (stp | jmp | jeq & ~eq | bbl | jms);
	assign pc_inc = exec1 & ~stp; // fetch | (exec1 & ~e) | (exec2 & ~m) | exec3;
	assign acc_load = exec2 & (lda | ldr);
	assign jump_mux[0] = bbl;
	assign jump_mux[1] = jmc;
	assign push = jms & exec1;
	assign pop = bbl & exec1;
	assign data_mux = ldr;
	assign load_mux = bbl;
	assign reg_mux = str;

endmodule

