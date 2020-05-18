module executor
(
	input [2:0] s,
	input e,
	output [2:0] n
);
	assign n[2] = ~s[0] & s[1] & ~s[2] & e;
	assign n[1] = s[0] & ~s[1] & ~s[2];
	assign n[0] = ~s[0] & ~s[1] & ~s[2];

endmodule