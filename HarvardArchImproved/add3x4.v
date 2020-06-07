module add3x4
(
	input [3:0] ps0,
	input [3:0] ps1,
	input [3:0] ps2,
	output [7:0] sum
);
	assign sum = ps0 + ps1 + ps2;

endmodule 