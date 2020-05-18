module arm_alu
(
	input [15:0] rd_data,
	input [15:0] rs_data,
	input [15:0] inst,
	input [2:0] state,
	output [15:0] d_out,
	output wen,
	output ldr,
	output reg_mux
);
	wire arm, cin;
	wire exec1, exec2;
	reg [15:0] sum;

	assign arm = inst[15];
	assign cin = inst[11];
	assign exec1 = state[1];
	assign exec2 = state[2];

	always @(*)
		begin
			case (inst[14:12])
				3'b000 : sum = rd_data + rs_data + cin; // add
				3'b001 : sum = rd_data + ~rs_data + cin; // sub
				3'b010 : sum = rs_data + cin; // mov
				3'b011 : sum = rs_data + 16'hFFFF; // dec
				default : sum = rd_data;
			endcase;
		end

	// assign values to outputs
   assign ldr = inst[15] & inst[14] & ~inst[13] & inst[12];
	assign wen = exec1 & arm | ldr & exec2;
	assign d_out = sum[15:0];
	assign reg_mux = ~inst[15] & ~inst[14] & ~inst[13];

endmodule

	
	