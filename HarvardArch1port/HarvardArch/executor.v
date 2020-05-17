module executor
(
	input [2:0] s,
	input e,
	input p,
	output [2:0] n
);
	assign n[2] = 0;
	assign n[1] = s[0] & ~s[1] & ~s[2] & e;
	assign n[0] = ~s[0] & ~s[1] & ~s[2] | s[0] & ~s[1] & ~s[2] & ~e & p | ~s[0] & s[1] & ~s[2] & p;

endmodule