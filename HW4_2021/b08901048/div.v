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
	wire[50:0] num_oov;
	//OOV oov(o_out_valid, clk, rst_n, num_oov);

	//stage 0
	wire[50:0] n_pu00, n_pu01, n_pu02, n_pu03, n_pu04, n_stage0, n_ffb0, n_ffa0, n_ff0, n_ff0_01,n_pus0;
	//wire c01,c02,c03,c04,c05;
	wire[4:0] c0;
	wire[4:0] ib0;
	wire[7:0] ia0;
	wire rr0, r0;
	wire q70;
	//REGP#(5) regp01(clk, rst_n, ib0 ,i_b, n_ffb0);
	//REGP#(8) regp02(clk, rst_n, ia0 ,i_a, n_ffa0);
	//FD2 fd00 (zero ,1'd0, clk, rst_n, n_ff0_00);
	//module PU5 (r, cout, s, a, b, number);
	PU5_0 stage0(r0, c0, {1'd0, 1'd0, 1'd0, 1'd0, i_a[7]}, i_b, n_pus0);
	//n_stage0=n_pu00+n_pu01+n_pu02+n_pu03+n_pu04;
	REGP#(1) regp03(clk, rst_n, rr0 ,r0, n_ff0);
	FD2 fd01(q70 ,c0[4], clk, rst_n, n_ff0_01);
	//assign n_stage0 = n_pu00 + n_pu01 + n_pu02 + n_pu03 + n_pu04 + n_ff0+ n_ff0_01;
	assign n_stage0 = n_pus0 + n_ff0+ n_ff0_01;

	//stage 1
	wire[50:0] n_pu10, n_pu11, n_pu12, n_pu13, n_pu14, n_stage1;
	wire[50:0] n_ffb1, n_ffa1, n_ff1, n_ff1_02, n_ff1_03, n_pus1;
	//wire c11,c12,c13,c14,c15;

	wire[4:0] r1, ib1,c1;
	wire[6:0] ia1;
	wire[1:0] rr1;
	wire q60, q71;
	REGP#(5) regp11(clk, rst_n, ib1 ,i_b, n_ffb1);
	REGP#(7) regp12(clk, rst_n, ia1 ,i_a[6:0], n_ffa1);
	PU5_1 stage1(r1, c1, {1'd0, 1'd0, 1'd0, rr0, ia1[6]}, ib1, n_pus1);
	REGP#(2) regp13(clk, rst_n, rr1 ,r1[1:0], n_ff1);
	FD2 fd02(q71 ,q70, clk, rst_n, n_ff1_02);
	FD2 fd03(q60 ,c1[4], clk, rst_n, n_ff1_03);
	//assign n_stage1=n_pu10+n_pu11+n_pu12+n_pu13+n_pu14+n_ffa1+n_ffb1+n_ff1+n_ff1_02+n_ff1_03;
	assign n_stage1=n_pus1+n_ffa1+n_ffb1+n_ff1+n_ff1_02+n_ff1_03;


	//stage 2
	wire[50:0] n_pu20, n_pu21, n_pu22, n_pu23, n_pu24, n_stage2;
	wire[50:0] n_ffb2, n_ffa2, n_ff2, n_ff2_02, n_ff2_03, n_ff2_04,n_pus2;
	//wire c21,c22,c23,c24,c25;
	wire[2:0] rr2;
	wire[4:0] r2, ib2, c2;
	wire[5:0] ia2;
	wire q61, q72, q50;
	REGP#(5) regp21(clk, rst_n, ib2 ,ib1, n_ffb2);
	REGP#(6) regp22(clk, rst_n, ia2 ,ia1[5:0], n_ffa2); 
	PU5_2 stage2(r2, c2, {1'd0, 1'd0, rr1[1:0], ia2[5]}, ib2, n_pus2);
	REGP#(3) regp23(clk, rst_n, rr2 ,r2[2:0], n_ff2);
	FD2 fd04(q72 ,q71, clk, rst_n, n_ff2_02);
	FD2 fd05(q61 ,q60, clk, rst_n, n_ff2_03);
	FD2 fd06(q50 ,c2[4], clk, rst_n, n_ff2_04);
	// assign n_stage2=n_pu20+n_pu21+n_pu22+n_pu23+n_pu24+n_ffb2+n_ffa2+n_ff2+n_ff2_02+n_ff2_03+n_ff2_04;
	assign n_stage2=n_pus2+n_ffb2+n_ffa2+n_ff2+n_ff2_02+n_ff2_03+n_ff2_04;

	//stage 3
	wire[50:0] n_pu30, n_pu31, n_pu32, n_pu33, n_pu34, n_pu35, n_stage3;
	wire[50:0] n_ffb3, n_ffa3, n_ff3, n_ff3_07, n_ff3_08, n_ff3_09, n_ff3_10, n_pus3;
	//wire c31,c32,c33,c34,c35,c36;
	wire[4:0] r3, c3;
	wire[4:0] ia3, ib3;
	wire[3:0] rr3;
	wire q40, q51, q62, q73;
	REGP#(5) regp31(clk, rst_n, ib3 ,ib2, n_ffb3);
	REGP#(5) regp32(clk, rst_n, ia3 ,ia2[4:0], n_ffa3); 
	PU5_3 stage3(r3, c3, {1'd0, rr2[2:0], ia3[4]}, ib3, n_pus3);
	REGP#(4) regp33(clk, rst_n, rr3 ,r3[3:0], n_ff3);
	FD2 fd07(q73 ,q72, clk, rst_n, n_ff3_07);
	FD2 fd08(q62 ,q61, clk, rst_n, n_ff3_08);
	FD2 fd09(q51 ,q50, clk, rst_n, n_ff3_09);
	FD2 fd10(q40 ,c3[4], clk, rst_n, n_ff3_10);
	//assign n_stage3=n_pu30+n_pu31+n_pu32+n_pu33+n_pu34+n_ffb3+n_ffa3+n_ff3+n_ff3_07+n_ff3_08+n_ff3_09+n_ff3_10;
	assign n_stage3=n_pus3+n_ffb3+n_ffa3+n_ff3+n_ff3_07+n_ff3_08+n_ff3_09+n_ff3_10;

	//stage 4
	wire[50:0] n_pu40, n_pu41, n_pu42, n_pu43, n_pu44, n_pu45, n_stage4;
	wire[50:0] n_ffb4, n_ffa4, n_ff4, n_ff4_11, n_ff4_12, n_ff4_13, n_ff4_14, n_ff4_15, n_pus4;
	//wire c41,c42,c43,c44,c45,c46;
	wire q30, q41, q52, q63, q74;
	wire[4:0] r4,c4;
	wire[4:0] rr4, ib4;
	wire[3:0] ia4;
	REGP#(5) regp41(clk, rst_n, ib4 ,ib3, n_ffb4);
	REGP#(4) regp42(clk, rst_n, ia4 ,ia3[3:0], n_ffa4);
	PU5 stage4(r4, c4, {rr3[3:0], ia4[3]}, ib4, n_pus4);
	REGP#(5) regp43(clk, rst_n, rr4 ,r4, n_ff4);
	FD2 fd11(q74, q73, clk, rst_n, n_ff4_11);
	FD2 fd12(q63 ,q62, clk, rst_n, n_ff4_12);
	FD2 fd13(q52 ,q51, clk, rst_n, n_ff4_13);
	FD2 fd14(q41 ,q40, clk, rst_n, n_ff4_14);
	FD2 fd15(q30 ,c4[4], clk, rst_n, n_ff4_15);	
	//assign n_stage4=n_pu40+n_pu41+n_pu42+n_pu43+n_pu44+n_ffa4+n_ffb4+n_ff4+n_ff4_11+n_ff4_12+n_ff4_13+n_ff4_14+n_ff4_15;
	assign n_stage4=n_pus4+n_ffa4+n_ffb4+n_ff4+n_ff4_11+n_ff4_12+n_ff4_13+n_ff4_14+n_ff4_15;

	//stage 5
	wire[50:0] n_pu50, n_pu51, n_pu52, n_pu53, n_pu54, n_pu55, n_stage5;
	wire[50:0] n_ffb5, n_ffa5, n_ff5, n_ff5_16, n_ff5_17, n_ff5_18, n_ff5_19, n_ff5_20, n_ff5_21, n_pus5;
	//wire c51,c52,c53,c54,c55,c56;
	wire q20, q31, q42,q53,q64,q75;
	wire[5:0] r5,c5;
	wire[4:0] rr5, ib5;
	wire[2:0] ia5;
	REGP#(5) regp51(clk, rst_n, ib5 ,ib4, n_ffb5);
	REGP#(3) regp52(clk, rst_n, ia5 ,ia4[2:0], n_ffa5);
	PU5S stage5(r5[4:0], c5, rr4[4], {rr4[3:0], ia5[2]}, ib5, n_pus5);

	//OR2 or1(c5[5], c5[4], rr4[4], n_pu55);
	//PU pu55(r5[5], c5[5], c5[4], c5[5], rr4[4], 1'd0, n_pu55);
	REGP#(5) regp53(clk, rst_n, rr5 ,r5[4:0], n_ff5);
	FD2 fd16(q75, q74, clk, rst_n, n_ff5_16);
	FD2 fd17(q64 ,q63, clk, rst_n, n_ff5_17);
	FD2 fd18(q53 ,q52, clk, rst_n, n_ff5_18);
	FD2 fd19(q42 ,q41, clk, rst_n, n_ff5_19);
	FD2 fd20(q31 ,q30, clk, rst_n, n_ff5_20);
	FD2 fd21(q20 ,c5[5], clk, rst_n, n_ff5_21);		
	// assign n_stage5=n_pu50+n_pu51+n_pu52+n_pu53+n_pu54+n_pu55+n_ffa5+n_ffb5+n_ff5+n_ff5_16+n_ff5_17+n_ff5_18+n_ff5_19+n_ff5_20+n_ff5_21;
	assign n_stage5=n_pus5+n_ffa5+n_ffb5+n_ff5+n_ff5_16+n_ff5_17+n_ff5_18+n_ff5_19+n_ff5_20+n_ff5_21;

////////從這裡開始
	wire[50:0] n_pu60, n_pu61, n_pu62, n_pu63, n_pu64, n_pu65, n_stage6,n_ffb6,n_ffa6,n_ff6;
	wire[50:0] n_ff6_22, n_ff6_23, n_ff6_24, n_ff6_25, n_ff6_26, n_ff6_27, n_ff6_28, n_pus6;
	//wire c61,c62,c63,c64,c65,c66;
	wire[5:0] r6, c6;
	wire[4:0] rr6, ib6;
	wire[1:0] ia6;
	wire q10,q21,q32,q43,q54,q65,q76;
	REGP#(5) regp61(clk, rst_n, ib6 ,ib5, n_ffb6);
	REGP#(2) regp62(clk, rst_n, ia6 ,ia5[1:0], n_ffa6);
	PU5S stage6(r6[4:0], c6, rr5[4], {rr5[3:0], ia6[1]}, ib6, n_pus6);
	// OR2 or2(c6[5], c6[4], rr5[4], n_pu65);
	//PU pu65(r6[5], c6[5], c6[4], c6[5], rr5[4], 1'd0, n_pu65);
	REGP#(5) regp63(clk, rst_n, rr6 ,r6[4:0], n_ff6);
	FD2 fd22(q76, q75, clk, rst_n, n_ff6_22);
	FD2 fd23(q65, q64, clk, rst_n, n_ff6_23);
	FD2 fd24(q54, q53, clk, rst_n, n_ff6_24);
	FD2 fd25(q43, q42, clk, rst_n, n_ff6_25);
	FD2 fd26(q32, q31, clk, rst_n, n_ff6_26);
	FD2 fd27(q21, q20, clk, rst_n, n_ff6_27);
	FD2 fd28(q10, c6[5], clk, rst_n, n_ff6_28);		
	// assign n_stage6=n_pu60+n_pu61+n_pu62+n_pu63+n_pu64+n_pu65+n_ffa6+n_ffb6+n_ff6+n_ff6_22+n_ff6_23+n_ff6_24+n_ff6_25+n_ff6_26+n_ff6_27+n_ff6_28;
	assign n_stage6=n_pus6+n_ffa6+n_ffb6+n_ff6+n_ff6_22+n_ff6_23+n_ff6_24+n_ff6_25+n_ff6_26+n_ff6_27+n_ff6_28;
	
	
	wire[50:0] n_pu70, n_pu71, n_pu72, n_pu73, n_pu74, n_pu75, n_stage7;
	wire[50:0] n_ffa7, n_ffb7,n_fd, n_pus7;
	wire[50:0] n_ff7_29, n_ff7_30, n_ff7_31, n_ff7_32, n_ff7_33, n_ff7_34, n_ff7_35, n_ff7_36, n_ff7_37, n_ff7_38, n_ff7_39, n_ff7_40, n_ff7_41;
	//wire c71,c72,c73,c74,c75,c76;
	wire ia7,q00;
	//wire r01,r02,r03,r04,r05;
	wire[4:0] ib7;
	wire[5:0] c7,r7;
	REGP#(5) regp71(clk, rst_n, ib7 ,ib6, n_ffb7);
	FD2 regp72(ia7 , ia6[0], clk, rst_n, n_ffa7);
	PU5S stage7(r7[4:0], c7, rr6[4], {rr6[3:0], ia7}, ib7, n_pus7);
	//OR2 or3(c7[5], c7[4], rr6[4], n_pu75);
	//PU pu75(r7[5], c7[5], c7[4], c7[5], rr6[4], 1'd0, n_pu75);	
	REGP#(13) regp73(clk, rst_n, {o_q, o_r} ,{q76, q65, q54, q43, q32, q21, q10, c7[5], r7[4:0]}, n_fd);
	assign n_stage7=n_pus7+n_ffb7+n_ffa7+n_fd;

	//+n_ff7_29+n_ff7_30+n_ff7_31+n_ff7_32+n_ff7_33+n_ff7_34+n_ff7_35;
	wire[4:0] ib8;
	wire o;
	wire[50:0] num_oov1;
	// REGP#(5) regp81(clk, rst_n, ib8 ,ib7, n_ffb8);
	OR_S5 orr(o, ib7[0], ib7[1], ib7[2], ib7[3], ib7[4], num_oov1);
	FD2 fdd(o_out_valid, o, clk, rst_n, num_oov);
	assign number=n_stage0+n_stage1+n_stage2+n_stage3+n_stage4+n_stage5+n_stage6+n_stage7+num_oov+num_oov1;

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

module PU (r, cout, cin, s, a, b, number);
	output r, cout;
	output[50:0] number;
	input a, b, s, cin;
	wire in_b, st;
	wire[50:0] num1,num2,num3;
	IV inv1(in_b, b, num1);
	FA1 fa1(cout, st, a, in_b, cin, num2);
	//MUX1 muxfinal(r, s, st, a, num3);
	MUX21H mux1(r, a, st, s, num3);
	assign number = num1+num2+num3;
	
endmodule
module FAA(cout, s, a, b, cin, number);
    output cout, s;
    input a, b, cin;
    output[50:0] number;
	wire[50:0] num1,num2,num3,num4,num5;
    wire e1;
    EO eo1(e1, a, b, num1);
    AN2 an1(e2, cin, e1, num2);
    AN2 an2(e3, a, b, num3);
    EO eo2(s, e1, cin, num4);
    OR2 or1(cout, e2, e3, num5);
    assign number=num1+num2+num3+num4+num5;



endmodule
module PU5_0 (r, cout, a, b, number);
	output[4:0] cout;
	output[50:0] number;
	input[4:0] a, b;
	output r;
	wire[4:0] in_b, st;
	wire[50:0] num1, num2, num3, num4, num5;
	wire[50:0] num6, num7, num8, num9, num10;
	wire[50:0] num11, num12, num13, num14, num15;
	wire[50:0] num16, num17, num18, num19, num20;
	wire[50:0] num21, num22, num23, num24, num25;
	wire[50:0] num26, num27, num28, num29, num30;
	wire[50:0] num31, num32, num33, num34, num35;
	wire[50:0] num36, num37, num38, num39, num300;
	wire[50:0] n0, n1, n2, n3;
	assign n0=num1+num2+num3+num4+num5+num6+num7;
	assign n1=num27+num29;
	assign n3=num35+num300;
	//a[4]=a[3]=a[2]=a[1]=0
	IV iv0(in_b[0], b[0], num1);
	IV iv1(in_b[1], b[1], num2);
	IV iv2(in_b[2], b[2], num3);
	IV iv3(in_b[3], b[3], num4);
	IV iv4(in_b[4], b[4], num5);
	wire g0,g1,g2,g3,g4,p0,p1,p2,p3,p4;
	AN2 an0(g0, a[0], in_b[0], num6);
	OR2 or0(p0, a[0], in_b[0], num7);
	assign p1=in_b[1];
	assign p2=in_b[2];
	assign p3=in_b[3];
	//assign cout[0] = p0;
	wire p1g0, p1p0;
	//AN2 an5(cout[1], p1, p0, num18);
	wire p2g1, p2p1g0, p2p1p0;
	assign num21=0;
	//AN3 an8(cout[2], p2, p1, p0, num22);
	wire p3g2, p3p2g1 ,p3p2p1g0, p3p2p1p0;
	AN4 an12(cout[3], p3, p2, p1, p0, num27);
	FA1 fa1(cout[4], st[4], a[4], in_b[4], cout[3], num29);

	wire l0, l1, l2, l3, l4;
	EO e00(l0, a[0], in_b[0],num30);
	IV iv11(st[0], l0, num300);
	MUX21H mux0(r, a[0], st[0], cout[4], num35);
	assign number=n0+n1+n3;

endmodule
module PU5_1 (r, cout, a, b, number);
	output[4:0] r, cout;
	output[50:0] number;
	input[4:0] a, b;
	wire[4:0] in_b, st;
	wire[50:0] num1, num2, num3, num4, num5;
	wire[50:0] num6, num7, num8, num9, num10;
	wire[50:0] num11, num12, num13, num14, num15;
	wire[50:0] num16, num17, num18, num19, num20;
	wire[50:0] num21, num22, num23, num24, num25;
	wire[50:0] num26, num27, num28, num29, num30;
	wire[50:0] num31, num32, num33, num34, num35;
	wire[50:0] num36, num37, num38, num39, num300;
	wire[50:0] n0, n1, n2, n3;
	assign n0=num1+num2+num3+num4+num5+num6+num7+num8+num9;
	assign n1=num17+num20;
	assign n2=num21+num22+num23+num24+num25+num26+num27+num28+num29+num30;
	assign n3=num31+num35+num36+num300;
	IV iv0(in_b[0], b[0], num1);
	IV iv1(in_b[1], b[1], num2);
	IV iv2(in_b[2], b[2], num3);
	IV iv3(in_b[3], b[3], num4);
	IV iv4(in_b[4], b[4], num5);
	wire g0,g1,g2,g3,g4,p0,p1,p2,p3,p4;
	//a2=a3=a4=0
	//g2=g3=g4=0
	//p2=inb[2] p3=inb[3]
	AN2 an0(g0, a[0], in_b[0], num6);
	OR2 or0(p0, a[0], in_b[0], num7);
	AN2 an1(g1, a[1], in_b[1], num8);
	OR2 or1(p1, a[1], in_b[1], num9);


	assign cout[0] = p0;
	wire p1g0, p1p0;
	assign num17=0;
	// AN2 an5(p1p0, p1, p0, num18);
	// OR2 or5(cout[1], g1, p1p0, num19);
	wire p2g1, p2p1g0, p2p1p0;
	AN2 an6(p2g1, in_b[2], g1, num20);
	//AN3 an7(p2p1g0, p2, p1, g0, num21);
	assign num21=0;
	AN3 an8(p2p1p0, in_b[2], p1, p0, num22);
	OR2 or6(cout[2], p2g1, p2p1p0, num23);
	wire p3g2, p3p2g1 ,p3p2p1g0, p3p2p1p0;
	assign num24=0;
	AN2 an10(p3p2g1, in_b[3], p2g1, num25);
	//AN4 an11(p3p2p1g0, p3, p2, p1, g0, num26);
	assign num26=0;
	AN4 an12(p3p2p1p0, in_b[3], in_b[2], p1, p0, num27);
	OR2 or7(cout[3], p3p2g1, p3p2p1p0, num28);
	FA1 fa1(cout[4], st[4], a[4], in_b[4], cout[3], num29);

	wire l0, l1, l2, l3, l4;
	EO e00(l0, a[0], in_b[0],num30);
	IV iv11(st[0], l0, num300);
	EO3 eo1(st[1], cout[0],a[1],in_b[1],num31);
	MUX21H mux0(r[0], a[0], st[0], cout[4], num35);
	MUX21H mux1(r[1], a[1], st[1], cout[4], num36);
	assign number=n0+n1+n2+n3;

endmodule
module PU5_2 (r, cout, a, b, number);
	output[4:0] r, cout;
	output[50:0] number;
	input[4:0] a, b;
	wire[4:0] in_b, st;
	wire[50:0] num1, num2, num3, num4, num5;
	wire[50:0] num6, num7, num8, num9, num10;
	wire[50:0] num11, num12, num13, num14, num15;
	wire[50:0] num16, num17, num18, num19, num20;
	wire[50:0] num21, num22, num23, num24, num25;
	wire[50:0] num26, num27, num28, num29, num30;
	wire[50:0] num31, num32, num33, num34, num35;
	wire[50:0] num36, num37, num38, num39, num300;
	wire[50:0] n0, n1, n2, n3;
	assign n0=num1+num2+num3+num4+num5+num6+num7+num8+num9+num10;
	assign n1=num11+num18+num19+num20;
	assign n2=num21+num22+num23+num24+num25+num26+num27+num28+num29+num30;
	assign n3=num31+num32+num35+num36+num37+num300;
	IV iv0(in_b[0], b[0], num1);
	IV iv1(in_b[1], b[1], num2);
	IV iv2(in_b[2], b[2], num3);
	IV iv3(in_b[3], b[3], num4);
	IV iv4(in_b[4], b[4], num5);
	wire g0,g1,g2,g3,g4,p0,p1,p2,p3,p4;
	//a3=a4=0;
	//g3=0
	AN2 an0(g0, a[0], in_b[0], num6);
	OR2 or0(p0, a[0], in_b[0], num7);
	AN2 an1(g1, a[1], in_b[1], num8);
	OR2 or1(p1, a[1], in_b[1], num9);
	AN2 an2(g2, a[2], in_b[2], num10);
	OR2 or2(p2, a[2], in_b[2], num11);

	assign cout[0] = p0;
	wire p1g0, p1p0;
	AN2 an5(p1p0, p1, p0, num18);
	OR2 or5(cout[1], g1, p1p0, num19);
	wire p2g1, p2p1g0, p2p1p0;
	AN2 an6(p2g1, p2, g1, num20);
	//AN3 an7(p2p1g0, p2, p1, g0, num21);
	assign num21=0;
	AN3 an8(p2p1p0, p2, p1, p0, num22);
	OR3 or6(cout[2], g2, p2g1, p2p1p0, num23);
	wire p3g2, p3p2g1 ,p3p2p1g0, p3p2p1p0;
	AN2 an9(p3g2, in_b[3], g2, num24);
	AN2 an10(p3p2g1, in_b[3], p2g1, num25);
	//AN4 an11(p3p2p1g0, p3, p2, p1, g0, num26);
	assign num26=0;
	AN4 an12(p3p2p1p0, in_b[3], p2, p1, p0, num27);
	OR3 or7(cout[3], p3g2, p3p2g1, p3p2p1p0, num28);
	FA1 fa1(cout[4], st[4], a[4], in_b[4], cout[3], num29);

	wire l0, l1, l2, l3, l4;
	EO e00(l0, a[0], in_b[0],num30);
	IV iv11(st[0], l0, num300);
	EO3 eo1(st[1], cout[0],a[1],in_b[1],num31);
	EO3 eo2(st[2], cout[1],a[2],in_b[2],num32);
	// EO eo3(st[3], cout[2], in_b[3],num33);
	// EO eo4(st[4], cout[3], in_b[4],num34);
	MUX21H mux0(r[0], a[0], st[0], cout[4], num35);
	MUX21H mux1(r[1], a[1], st[1], cout[4], num36);
	MUX21H mux2(r[2], a[2], st[2], cout[4], num37);
	// AN2 mux3(r[3], st[3], cout[4], num38);
	// AN2 mux4(r[4], st[4], cout[4], num39);
	assign number=n0+n1+n2+n3;

endmodule
module PU5_3 (r, cout, a, b, number);
	output[4:0] r, cout;
	output[50:0] number;
	input[4:0] a, b;
	wire[4:0] in_b, st;
	wire[50:0] num1, num2, num3, num4, num5;
	wire[50:0] num6, num7, num8, num9, num10;
	wire[50:0] num11, num12, num13, num14, num15;
	wire[50:0] num16, num17, num18, num19, num20;
	wire[50:0] num21, num22, num23, num24, num25;
	wire[50:0] num26, num27, num28, num29, num30;
	wire[50:0] num31, num32, num33, num34, num35;
	wire[50:0] num36, num37, num38, num39, num300;
	wire[50:0] n0, n1, n2, n3;
	assign n0=num1+num2+num3+num4+num5+num6+num7+num8+num9+num10;
	assign n1=num11+num12+num13+num14+num15+num16+num17+num18+num19+num20;
	assign n2=num21+num22+num23+num24+num25+num26+num27+num28+num29+num30;
	assign n3=num31+num32+num33+num35+num36+num37+num38+num300;
	IV iv0(in_b[0], b[0], num1);
	IV iv1(in_b[1], b[1], num2);
	IV iv2(in_b[2], b[2], num3);
	IV iv3(in_b[3], b[3], num4);
	IV iv4(in_b[4], b[4], num5);
	wire g0,g1,g2,g3,g4,p0,p1,p2,p3,p4;
	AN2 an0(g0, a[0], in_b[0], num6);
	OR2 or0(p0, a[0], in_b[0], num7);
	AN2 an1(g1, a[1], in_b[1], num8);
	OR2 or1(p1, a[1], in_b[1], num9);
	AN2 an2(g2, a[2], in_b[2], num10);
	OR2 or2(p2, a[2], in_b[2], num11);
	AN2 an3(g3, a[3], in_b[3], num12);
	OR2 or3(p3, a[3], in_b[3], num13);
	assign num14=0;
	assign num15=0;

	assign num16=0;
	assign cout[0] = p0;
	wire p1g0, p1p0;
	assign num17=0;
	AN2 an5(p1p0, p1, p0, num18);
	OR2 or5(cout[1], g1, p1p0, num19);
	wire p2g1, p2p1g0, p2p1p0;
	AN2 an6(p2g1, p2, g1, num20);
	//AN3 an7(p2p1g0, p2, p1, g0, num21);
	assign num21=0;
	AN3 an8(p2p1p0, p2, p1, p0, num22);
	OR3 or6(cout[2], g2, p2g1, p2p1p0, num23);
	wire p3g2, p3p2g1 ,p3p2p1g0, p3p2p1p0;
	AN2 an9(p3g2, p3, g2, num24);
	AN2 an10(p3p2g1, p3, p2g1, num25);
	//AN4 an11(p3p2p1g0, p3, p2, p1, g0, num26);
	assign num26=0;
	AN4 an12(p3p2p1p0, p3, p2, p1, p0, num27);
	OR4 or7(cout[3], g3, p3g2, p3p2g1, p3p2p1p0, num28);
	FA1 fa1(cout[4], st[4], a[4], in_b[4], cout[3], num29);

	wire l0, l1, l2, l3, l4;
	EO e00(l0, a[0], in_b[0],num30);
	IV iv11(st[0], l0, num300);
	EO3 eo1(st[1], cout[0],a[1],in_b[1],num31);
	EO3 eo2(st[2], cout[1],a[2],in_b[2],num32);
	EO3 eo3(st[3], cout[2],a[3],in_b[3],num33);
	//EO eo4(st[4], cout[3], in_b[4],num34);
	MUX21H mux0(r[0], a[0], st[0], cout[4], num35);
	MUX21H mux1(r[1], a[1], st[1], cout[4], num36);
	MUX21H mux2(r[2], a[2], st[2], cout[4], num37);
	MUX21H mux3(r[3], a[3], st[3], cout[4], num38);
	//AN2 mux4(r[4], st[4], cout[4], num39);
	assign number=n0+n1+n2+n3;

endmodule
module PU5 (r, cout, a, b, number);
	output[4:0] r, cout;
	output[50:0] number;
	input[4:0] a, b;
	wire[4:0] in_b, st;
	wire[50:0] num1, num2, num3, num4, num5;
	wire[50:0] num6, num7, num8, num9, num10;
	wire[50:0] num11, num12, num13, num14, num15;
	wire[50:0] num16, num17, num18, num19, num20;
	wire[50:0] num21, num22, num23, num24, num25;
	wire[50:0] num26, num27, num28, num29, num30;
	wire[50:0] num31, num32, num33, num34, num35;
	wire[50:0] num36, num37, num38, num39, num300;
	wire[50:0] n0, n1, n2, n3;
	assign n0=num1+num2+num3+num4+num5+num6+num7+num8+num9+num10;
	assign n1=num11+num12+num13+num14+num15+num16+num17+num18+num19+num20;
	assign n2=num21+num22+num23+num24+num25+num26+num27+num28+num29+num30;
	assign n3=num31+num32+num33+num35+num36+num37+num38+num39+num300;
	IV iv0(in_b[0], b[0], num1);
	IV iv1(in_b[1], b[1], num2);
	IV iv2(in_b[2], b[2], num3);
	IV iv3(in_b[3], b[3], num4);
	IV iv4(in_b[4], b[4], num5);
	wire g0,g1,g2,g3,g4,p0,p1,p2,p3,p4;
	AN2 an0(g0, a[0], in_b[0], num6);
	OR2 or0(p0, a[0], in_b[0], num7);
	AN2 an1(g1, a[1], in_b[1], num8);
	OR2 or1(p1, a[1], in_b[1], num9);
	AN2 an2(g2, a[2], in_b[2], num10);
	OR2 or2(p2, a[2], in_b[2], num11);
	AN2 an3(g3, a[3], in_b[3], num12);
	OR2 or3(p3, a[3], in_b[3], num13);
	assign num14=0;
	assign num15=0;

	assign num16=0;
	assign cout[0] = p0;
	wire p1g0, p1p0;
	assign num17=0;
	AN2 an5(p1p0, p1, p0, num18);
	OR2 or5(cout[1], g1, p1p0, num19);
	wire p2g1, p2p1g0, p2p1p0;
	AN2 an6(p2g1, p2, g1, num20);
	//AN3 an7(p2p1g0, p2, p1, g0, num21);
	assign num21=0;
	AN3 an8(p2p1p0, p2, p1, p0, num22);
	OR3 or6(cout[2], g2, p2g1, p2p1p0, num23);
	wire p3g2, p3p2g1 ,p3p2p1g0, p3p2p1p0;
	AN2 an9(p3g2, p3, g2, num24);
	AN2 an10(p3p2g1, p3, p2g1, num25);
	//AN4 an11(p3p2p1g0, p3, p2, p1, g0, num26);
	assign num26=0;
	AN4 an12(p3p2p1p0, p3, p2, p1, p0, num27);
	OR4 or7(cout[3], g3, p3g2, p3p2g1, p3p2p1p0, num28);
	FA1 fa1(cout[4], st[4], a[4], in_b[4], cout[3], num29);

	wire l0, l1, l2, l3, l4;
	EO e00(l0, a[0], in_b[0],num30);
	IV iv11(st[0], l0, num300);
	EO3 eo1(st[1], cout[0],a[1],in_b[1],num31);
	EO3 eo2(st[2], cout[1],a[2],in_b[2],num32);
	EO3 eo3(st[3], cout[2],a[3],in_b[3],num33);
	//EO3 eo4(st[4], cout[3],a[4],in_b[4],num34);
	MUX21H mux0(r[0], a[0], st[0], cout[4], num35);
	MUX21H mux1(r[1], a[1], st[1], cout[4], num36);
	MUX21H mux2(r[2], a[2], st[2], cout[4], num37);
	MUX21H mux3(r[3], a[3], st[3], cout[4], num38);
	MUX21H mux4(r[4], a[4], st[4], cout[4], num39);
	assign number=n0+n1+n2+n3;

endmodule
module PU5S (r, cout, rr, a, b, number);
	output[4:0] r;
	output[5:0] cout;
	output[50:0] number;
	input[4:0] a, b;
	input rr;
	wire[4:0] in_b, st,c;
	wire[50:0] num1, num2, num3, num4, num5;
	wire[50:0] num6, num7, num8, num9, num10;
	wire[50:0] num11, num12, num13, num14, num15;
	wire[50:0] num16, num17, num18, num19, num20;
	wire[50:0] num21, num22, num23, num24, num25;
	wire[50:0] num26, num27, num28, num29, num30;
	wire[50:0] num31, num32, num33, num34, num35;
	wire[50:0] num36, num37, num38, num39, num40;
	wire[50:0] num311;
	wire[50:0] n0, n1, n2, n3;
	assign n0=num1+num2+num3+num4+num5+num6+num7+num8+num9+num10;
	assign n1=num11+num12+num13+num14+num15+num16+num17+num18+num19+num20;
	assign n2=num21+num22+num23+num24+num25+num26+num27+num28+num29+num30;
	assign n3=num31+num32+num33+num34+num36+num37+num38+num39+num40+num311;
	IV iv0(in_b[0], b[0], num1);
	IV iv1(in_b[1], b[1], num2);
	IV iv2(in_b[2], b[2], num3);
	IV iv3(in_b[3], b[3], num4);
	IV iv4(in_b[4], b[4], num5);
	wire g0,g1,g2,g3,g4,p0,p1,p2,p3,p4;
	AN2 an0(g0, a[0], in_b[0], num6);
	OR2 or0(p0, a[0], in_b[0], num7);
	AN2 an1(g1, a[1], in_b[1], num8);
	OR2 or1(p1, a[1], in_b[1], num9);
	AN2 an2(g2, a[2], in_b[2], num10);
	OR2 or2(p2, a[2], in_b[2], num11);
	AN2 an3(g3, a[3], in_b[3], num12);
	OR2 or3(p3, a[3], in_b[3], num13);
	assign num14=0;
	assign num15=0;

	//OR2 orrrr(cout[0], g0, p0, num16);
	assign num16=0;
	assign cout[0] = p0;
	wire p1g0, p1p0;
	assign num17=0;
	AN2 an5(p1p0, p1, p0, num18);
	OR2 or5(cout[1], g1, p1p0, num19);
	wire p2g1, p2p1g0, p2p1p0;
	AN2 an6(p2g1, p2, g1, num20);
	//AN3 an7(p2p1g0, p2, p1, g0, num21);
	assign num21=0;
	AN3 an8(p2p1p0, p2, p1, p0, num22);
	OR3 or6(cout[2], g2, p2g1, p2p1p0, num23);
	wire p3g2, p3p2g1 ,p3p2p1g0, p3p2p1p0;
	AN2 an9(p3g2, p3, g2, num24);
	AN3 an10(p3p2g1, p3, p2, g1, num25);
	//AN4 an11(p3p2p1g0, p3, p2, p1, g0, num26);
	assign num26=0;
	AN4 an12(p3p2p1p0, p3, p2, p1, p0, num27);
	OR4 or7(cout[3], g3, p3g2, p3p2g1, p3p2p1p0, num28);
	FA1 fa1(cout[4], st[4], a[4], in_b[4], cout[3], num29);

	OR2 ooor(cout[5], rr, cout[4], num30);
	wire l0, l1, l2, l3, l4;
	EO e00(l0, a[0], in_b[0],num31);
	IV iv11(st[0], l0, num311);
	//EO eo0(st[0], 1'b1,a[0],in_b[0],num31);
	EO3 eo1(st[1], cout[0],a[1],in_b[1],num32);
	EO3 eo2(st[2], cout[1],a[2],in_b[2],num33);
	EO3 eo3(st[3], cout[2],a[3],in_b[3],num34);
	//EO3 eo4(st[4], cout[3],a[4],in_b[4],num35);
	MUX21H mux0(r[0], a[0], st[0], cout[5], num36);
	MUX21H mux1(r[1], a[1], st[1], cout[5], num37);
	MUX21H mux2(r[2], a[2], st[2], cout[5], num38);
	MUX21H mux3(r[3], a[3], st[3], cout[5], num39);
	MUX21H mux4(r[4], a[4], st[4], cout[5], num40);
	assign number=n0+n1+n2+n3;

endmodule
module OR_S5(out, a1, a2, a3, a4, a5, number);
	input a1, a2, a3, a4, a5;
	output out;
	output [50:0] number;
	wire l1, l2;
	wire[50:0] num1, num2, num3;

	NR2 nd(l1, a1, a2,num1);
	NR3 nd1(l2, a3, a4, a5,num2);
	ND2 nd2(out, l1, l2,num3);
	assign number=num1+num2+num3;
endmodule
module OR_S6(out, a1, a2, a3, a4, a5,a6, number);
	input a1, a2, a3, a4, a5, a6;
	output out;
	output [50:0] number;
	wire l1, l2;
	wire[50:0] num1, num2, num3;

	NR2 nd(l1, a1, a2, num1);
	NR4 nd1(l2, a3, a4, a5,a6,num2);
	ND2 nd2(out, l1, l2,num3);
	assign number=num1+num2+num3;
endmodule

