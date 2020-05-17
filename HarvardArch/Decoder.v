module Decoder
(
	input [2:0] state,
	input [3:0] inst,
	output acc_load,
	output mux3,
	output e,
	output WrEn,
	output pc_load,
	output pc_inc,
	output p
	
);
	wire lda, sta, add, jmp, stp, ldi, jms, bbl, arm;
	wire fetch, exec1, exec2;
	
	assign ldi = ~inst[3] & ~inst[2] & ~inst[1] & ~inst[0];
	assign sta = ~inst[3] & ~inst[2] & ~inst[1] & inst[0];
	assign add = ~inst[3] & ~inst[2] & inst[1] & ~inst[0];
	assign jmp = ~inst[3] & ~inst[2] & inst[1] & inst[0];
	assign stp = ~inst[3] & inst[2] & ~inst[1] & ~inst[0];
	assign lda = ~inst[3] & inst[2] & ~inst[1] & inst[0];
	assign jms =  ~inst[3] & inst[2] & inst[1] & ~inst[0];
	assign bbl =  ~inst[3] & inst[2] & inst[1] & inst[0];
	assign arm = inst[3];
	
	assign fetch = state[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	
	assign p = 0; //~fetch & (lda | ldi | jmp)
	assign e = lda | add;
	assign WrEn = exec1 & sta;
	assign pc_load = exec1 & jmp;
	assign pc_inc = exec1 & ~(stp | jmp);
	assign acc_load = (exec1 & ldi) | (exec2 & (lda | add));
	assign mux3 = add;

endmodule

