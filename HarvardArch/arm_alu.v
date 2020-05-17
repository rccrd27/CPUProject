module arm_alu
(
	input [15:0] rd_data,
	input [15:0] rs_data,
	input [15:0] inst,
	input exec1,
	output [15:0] d_out,
	output wen
);
	wire arm, cin;
	reg [15:0] sum;

	assign arm = inst[15];
	
	assign cin = inst[11];

	always @(*)
		begin
			case (inst[14:12])
				3'b000 : sum = rd_data + rs_data + cin; // add
				3'b001 : sum = rd_data + ~rs_data + cin; // sub
				3'b010 : sum = rs_data + cin; // mov
				3'b011 : sum = rs_data + 16'hFFFF; // dec
			endcase;
		end

	// assign values to outputs
	assign wen = exec1 & arm;
	assign d_out = sum[15:0];

endmodule

	
	