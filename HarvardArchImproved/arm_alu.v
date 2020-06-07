module arm_alu
(
	input [15:0] rd_data,
	input [15:0] rs_data,
	input [4:0] inst,
	input [3:0] state,
	input [15:0] data_b,
	input [15:0] mult,
	output [15:0] d_out,
	output wen
);
	wire arm, cin, mul, ldr;
	wire exec1, exec2, exec3;
	reg [15:0] sum;

	assign arm = inst[4];
	assign cin = inst[0];
	assign exec1 = state[1];
	assign exec2 = state[2];
	assign exec3 = state[3];

	always @(*)
		begin
			case (inst[3:1])
				3'b000 : sum = rd_data + rs_data; // add
				3'b001 : sum = rd_data + ~rs_data + {16'h0001}; // sub
				3'b010 : sum = rs_data + cin; // mov
				3'b011 : sum = {1'b0,rs_data[15:1]}; // lsr
				3'b100 : sum = rs_data + 16'hFFFF; // dec
				3'b101 : sum = mult; // mul
				3'b110 : sum = data_b; // ldr
				default : sum = rd_data;
			endcase;
		end

	// assign values to outputs
   assign ldr = inst[4] & inst[3] & inst[2] & ~inst[1];
	assign mul = inst[4] & inst[3] & ~inst[2] & inst[1];
	assign wen = (exec1 & arm & ~ldr & ~mul) | (exec2 & ldr) | (exec3 & mul);
	assign d_out = sum[15:0];

endmodule 