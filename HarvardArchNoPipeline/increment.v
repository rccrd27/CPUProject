module increment
(
  input [10:0] x,
  output [10:0] y
);

  assign y = x + {11'b00000000001};

endmodule 