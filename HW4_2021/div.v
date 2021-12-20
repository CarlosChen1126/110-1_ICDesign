module div (
	input  clk,
	input  rst_n,
	input  i_in_valid,
	input  [7:0] i_a,
	input  [4:0] i_b,
	output [7:0] o_q,
	output [4:0] o_r,
	output       o_out_valid,
	output [50:0] number
);
FD2 fd2(o_out_valid, 1, clk, rst_n, 8);


endmodule

//BW-bit FD2
module REGP#(
	parameter BW = 2
)(
	input clk,
	input rst_n,
	output [BW-1:0] Q,
	input [BW-1:0] D,
	output [50:0] number
);

wire [50:0] numbers [0:BW-1];

genvar i;
generate
	for (i=0; i<BW; i=i+1) begin
		FD2 f0(Q[i], D[i], clk, rst_n, numbers[i]);
	end
endgenerate

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<BW; j=j+1) begin 
		sum = sum + numbers[j];
	end
end

assign number = sum;

endmodule

module PU (r, cout, cin, s, a, b);
	output r, cout;
	input a, b, s, cin;
	wire in_b, st;
	IV inv1(in_b, b);
	FA1 fa1(cout, st, a, in_b, cin, 1);
	MUX1 muxfinal(r, s, st, a);
	
endmodule
module MUX1 (out, s, a, b);
	output out;
	input s, a, b;
	wire in_s, sa, in_sb;
	IV iv1(in_s, s);
	ND2 nd1(sa, s, a);
	ND2 nd2(in_sb, in_s, b);
	ND2 nd3(out, sa, in_sb);
endmodule