module sel_inc
(
  input [10:0] x,
  input en,
  output [10:0] y
);

  assign y = x + {10'b0000000000, en};

endmodule 