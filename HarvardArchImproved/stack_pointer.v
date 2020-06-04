module stack_pointer
(
  input [2:0] s,
  input push,
  input pop,
  output [2:0] n
);

  // assign n = s + {2'b00, push} + {2'b11, ~pop} + {3'b001};
  assign n[0] = s[0] & ~push & ~pop | ~s[0] & push | ~s[0] & pop;
  assign n[1] = s[1] & s[0] & ~push | s[1] & ~s[0] & ~pop + ~s[1] & s[0] & push | ~s[1] & ~s[0] & pop;
  assign n[2] = ~s[2] & s[1] & s[0] & push | s[2] & ~s[1] & ~s[0] & ~pop | s[2] & s[1] | s[2] & s[0];

endmodule 