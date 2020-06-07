module mult_p2
(
  input [15:0] ps0,
  input [15:0] ps1,
  input [15:0] ps2,
  input [15:0] ps3,
  output [15:0] p
);

  assign p = ps0 + ps1 + ps2 + ps3;

endmodule 