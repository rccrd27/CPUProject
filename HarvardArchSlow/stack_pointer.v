module stack_pointer
(
  input [2:0] s,
  input push,
  input pop,
  output [2:0] n
);

  assign n = s + {2'b00, push} + ~{2'b00, pop} + {3'b001};

endmodule 