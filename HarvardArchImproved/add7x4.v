module add7x4
(
	input [3:0] ps0,
	input [3:0] ps1,
	input [3:0] ps2,
	input [3:0] ps3,
	input [3:0] ps4,
	input [3:0] ps5,
	input [3:0] ps6,
	input [3:0] ps7,
	output [3:0] sum
);
	assign sum = ps0 + ps1 + ps2 + ps3 + ps4 + ps5 + ps6 + ps7;

endmodule 