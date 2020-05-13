module bus_en
(
	input [15:0] a,
	input en,
	output [15:0] y
);
	assign y[15:12] = a[15:12] & {~en, ~en, ~en, ~en};
	assign y[11:0] = a[11:0];

endmodule
