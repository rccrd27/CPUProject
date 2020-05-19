module arm_alu
(
	input [15:0] rd_data,
	input [15:0] rs_data,
	input [15:0] inst,
	input skip_status,
	input cy_status,
	input exec1,
	output [15:0] d_out,
	output wen,
	output skip_out,
	output skip_en,
	output cy_out,
	output cy_en,
	output [16:0] sum_test
);
	wire arm, s, cin;
	reg [16:0] sum;

	assign arm = inst[15] & inst[14];
	assign s = inst[7];
	
	assign cin = (~inst[13] & inst[12]) | (inst[13] & ~inst[12] & cy_status) | (inst[13] & inst[12] & rs_data[15]);

	always @(*)
		begin
			case (inst[6:4])
				3'b000 : sum = {1'b0, rd_data} + {1'b0, rs_data} + cin; // add
				3'b001 : sum = {1'b0, rd_data} + {1'b0, ~rs_data} + cin; // sub
				3'b010 : sum = {1'b0, rs_data} + cin; // mov
				3'b011 : sum = {rs_data[0], cin, rs_data[15:1]}; // xsr
				3'b100 : sum = {1'b0, rs_data} + 17'h0FFFF; // dec
				3'b101 : sum = {1'b0, rs_data} & {1'b0, rd_data}; // and
				3'b110 : sum = {1'b0, rs_data} | {1'b0, rd_data}; // orr
				3'b111 : sum = {1'b0, rs_data} ^ {1'b0, rd_data}; // xor
			endcase;
		end

	// assign values to outputs
	assign wen = exec1 & arm;
	assign d_out = sum[15:0];
	assign cy_out = sum[16];
	assign cy_en = exec1 & arm & s;
	assign skip_out = ((~inst[9] & inst[8]) | (inst[9] & ~inst[8] & ~sum[16]) | (inst[9] & inst[8] & sum[16])) & arm;
	assign skip_en = exec1;
	assign sum_test = sum[16:0];

endmodule

	
	