module stack_pointer
(
  input [4:0] s,
  input push,
  input pop,
  output [4:0] n
);

  assign n = s + {4'b0000, push} + {4'b1111, ~pop} + {5'b00001};

  /*
  assign n[0] = s[0] & ~push & ~pop | ~s[0] & push | ~s[0] & pop;
  assign n[1] = s[1] & s[0] & ~push | s[1] & ~s[0] & ~pop | ~s[1] & s[0] & push | ~s[1] & ~s[0] & pop;
  assign n[2] = s[2] & s[1] & s[0] & ~push | s[2] & s[1] & ~s[0] | s[2] & ~s[1] & s[0] | s[2] & ~s[1] & ~s[0] & ~pop | ~s[2] & s[1] & s[0] & push | ~s[2] & ~s[1] & ~s[0] & pop;
  assign n[3] = s[3] & s[2] & s[1] & s[0] & ~push | s[3] & s[2] & ~s[1] | s[3] & ~s[2] & s[0] | s[3] & s[1] & ~s[0] | s[3] & ~s[2] & ~s[1] & ~s[0] & ~pop | ~s[3] & s[2] & s[1] & s[0] & push | ~s[3] & ~s[2] & ~s[1] & ~s[0] & pop;
  assign n[4] = s[4] & s[3] & s[2] & s[1] & s[0] & ~push | s[4] & ~s[3] & s[0] | s[4] & s[1] & ~s[0] | s[4] & s[2] & ~s[1] | s[4] & s[3] & ~s[2] | s[4] & ~s[3] & ~s[2] & ~s[1] & ~s[0] & ~pop |
                ~s[4] & s[3] & s[2] & s[1] & s[0] & push | ~s[4] & ~s[3] & ~s[2] & ~s[1] & ~s[0] & pop;
  */

endmodule 