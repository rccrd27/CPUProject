module executor
(
	input [1:0] s,
	input e,
	output [1:0] n
);
	assign n[1] = s[0] & ~s[1] & e;
	assign n[0] = ~s[0] | ~s[1] & ~e;

endmodule