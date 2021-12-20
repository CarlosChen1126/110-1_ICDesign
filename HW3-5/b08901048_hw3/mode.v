	`timescale 1ns/1ps
module EN_fast (e, b1, b2);
	input b1, b2;
	output e;
	wire and1, and2, n_b1, n_b2;
	EO eo(l1, b1, b2);
	IV iv(e, l1);

endmodule
module OR_S4(out, a1, a2, a3, a4);
	input a1, a2, a3, a4;
	output out;
	wire l1, l2;
	wire na1, na2, na3, na4;
	NR2 nr1(l1, a1,a2);
	NR2 nr2(l2,a3,a4);
	ND2 nd(out, l1,l2);
endmodule
module OR_S5(out, a1, a2, a3, a4, a5);
	input a1, a2, a3, a4, a5;
	output out;
	wire l1, l2;
	wire na1, na2, na3, na4 ,na5;

	NR2 nd(l1, a1, a2);
	NR3 nd1(l2, a3, a4, a5);
	ND2 nd2(out, l1, l2);
endmodule
module ND_S5(out, a1, a2, a3, a4, a5);
	input a1, a2, a3, a4, a5;
	output out;
	wire l1, l2;
	AN2 u1(l1, a1,a2);
	AN2 u2(l2, a3,a4);
	ND3 nd2(out, l1, l2,a5);
endmodule
module NOR_S10(out, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
	input a1, a2, a3, a4, a5, a6, a7, a8, a9, a10;
	output out;
	wire l1, l2, l3;
	wire na1, na2, na3, na4 ,na5;
	NR4 nr1(l1, a1, a2, a3, a4);
	NR4 nr2(l2, a5, a6, a7, a8);
	NR2 nr3(l3, a9, a10);
	AN3 nd2(out, l1, l2, l3);
endmodule
module OR_S6(out, a1, a2, a3, a4, a5, a6);
	input a1, a2, a3, a4, a5, a6;
	output out;
	wire l1, l2;
	wire na1, na2, na3;
	NR2 nr1(l1, a1, a2);
	NR2 nr3(l3, a3, a4);
	NR2 nr2(l2, a5, a6);
	ND3 nd(out, l1, l2, l3);
endmodule
module AN_S7(out, a1, a2, a3, a4, a5, a6, a7);
	input a1, a2, a3, a4, a5, a6, a7;
	output out;
	wire l1, l2, l3, l4;
	IV iv(na7, a7);
	ND2 nd(l1, a1, a2);
	ND2 nd1(l2, a3, a4);
	ND2 nd2(l3, a5, a6);
	NR4 nr4(out, l1, l2, l3,na7);

endmodule
module AN_S5(out, a1, a2, a3, a4, a5);
	input a1, a2, a3, a4, a5;
	output out;
	wire l1, l2, l3, l4, l5;

	ND3 nd(l1, a1, a2, a3);
	ND2 nd1(l2, a4, a5);
	NR2 ndd(out, l1, l2);
endmodule
//if b>a => lg=1
module lg_lt_than (eq, lg, lt, a, b);
	input [3:0] a, b;
	output eq, lg, lt;
	wire na_3, nb_3, a3, b3, eq3;
	wire r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;
	wire l1, l2, l3;
	EN_fast en1(l3, a[3], b[3]);
	EN_fast en2(l2, a[2], b[2]);
	EN_fast en3(l1, a[1], b[1]);
	IV IV_a3(na_3,a[3]);
	IV IV_b3(nb_3,b[3]);
	HA1 and_b3_na3(a3,r1,na_3,b[3]);
	HA1 and_a3_nb3(b3,r2,nb_3,a[3]);
	EO eq_3(eq3,a[3],b[3]);

	wire na_2, nb_2, a2, b2, eq2;
	IV IV_a2(na_2,a[2]);
	IV IV_b2(nb_2,b[2]);
	HA1 and_b2_na2(a2,r3,na_2,b[2]);
	HA1 and_a2_nb2(b2,r4,nb_2,a[2]);
	EO eq_2(eq2,a[2],b[2]);

	wire na_1, nb_1, a1, b1, eq1;
	IV IV_a1(na_1,a[1]);
	IV IV_b1(nb_1,b[1]);
	HA1 and_b1_na1(a1,r5,na_1,b[1]);
	HA1 and_a1_nb1(b1,r6,nb_1,a[1]);
	EO eq_1(eq1,a[1],b[1]);

	wire na_0, nb_0, a0, b0, eq0;
	IV IV_a0(na_0,a[0]);
	IV IV_b0(nb_0,b[0]);
	HA1 and_b0_na0(a0,r7,na_0,b[0]);
	HA1 and_a0_nb0(b0,r8,nb_0,a[0]);
	EO eq_0(eq0,a[0],b[0]);

	wire and1, and2, and3, and4, and5, and6, and7, and8;
	ND4 nd1(and1, b0, l1, l2, l3);
	ND3 nd2(and2, b1, l2, l3);
	ND2 nd3(and3, b2, l3); 
	ND2 nd4(and4, a[3], nb_3);
	ND4 nd5(and5, a0, l1, l2, l3);
	ND3 nd6(and6, a1, l2, l3);
	ND2 nd7(and7, a2, l3); 
	ND2 nd8(and8, na_3, b[3]);
	ND4 or1(lt, and1, and2, and3, and4);
	ND4 or2(lg, and5, and6, and7, and8);
	NR4 andd(eq, eq0, eq1, eq2, eq3);


endmodule
module final_mux (out, mode0, mode1, mode2, mode3, mode4, i0, i1, i2, i3, i4);
	wire l1, l2, l3, l4, l5, ll1;
	input i0, i1, i2, i3, i4;
	input mode0, mode1, mode2, mode3, mode4;
	wire r1,r2,r3,r4,r5;
	output out;
	ND2 ff1(l1,mode0,i0);
	ND2 ff2(l2,mode1,i1);
	ND2 ff3(l3,mode2,i2);
	ND2 ff4(l4,mode3,i3);
	ND2 ff5(l5,mode4,i4);
	ND_S5 ff6(out, l1, l2, l3, l4, l5);
	
endmodule

module mode_max(mode, i0, i1, i2, i3, i4);
//DO NOT CHANGE!
	input  [3:0] i0, i1, i2, i3, i4;
	output [3:0] mode;
//---------------------------------------------------
	wire e01,e02,e03,e04,e12,e13,e14,e23,e24,e34;


	wire lg01, lg02, lg03, lg04, lg12, lg13, lg14, lg23, lg24, lg34;
	wire lt01, lt02, lt03, lt04, lt12, lt13, lt14, lt23, lt24, lt34;
	lg_lt_than l01(e01, lg01, lt01, i0, i1);
	lg_lt_than l02(e02, lg02, lt02, i0, i2);
	lg_lt_than l03(e03, lg03, lt03, i0, i3);
	lg_lt_than l04(e04, lg04, lt04, i0, i4);
	lg_lt_than l12(e12, lg12, lt12, i1, i2);
	lg_lt_than l13(e13, lg13, lt13, i1, i3);
	lg_lt_than l14(e14, lg14, lt14, i1, i4);
	lg_lt_than l23(e23, lg23, lt23, i2, i3);
	lg_lt_than l24(e24, lg24, lt24, i2, i4);
	lg_lt_than l34(e34, lg34, lt34, i3, i4);
	IV neq01(ne01, e01);
	IV neq02(ne02, e02);
	IV neq03(ne03, e03);
	IV neq04(ne04, e04);
	IV neq12(ne12, e12);
	IV neq13(ne13, e13);
	IV neq14(ne14, e14);
	IV neq23(ne23, e23);
	IV neq24(ne24, e24);
	IV neq34(ne34, e34);

	//1,1,1,1,1
	wire all_different;
	wire cc1, cc2, cc3, cc4, cc5;
	wire mode0_case0, mode1_case0, mode2_case0, mode3_case0, mode4_case0;

	NOR_S10 ce1(cc1, e01, e02, e03, e04, e12, e13, e14, e23, e24, e34);
	AN_S5 t1(mode0_case0, cc1, lt01, lt02, lt03, lt04);
	AN_S5 t2(mode1_case0, cc1,lg01, lt12, lt13, lt14);
	AN_S5 t3(mode2_case0, cc1, lg02, lg12, lt23, lt24);
	AN_S5 t4(mode3_case0, cc1, lg03, lg13, lg23, lt34);
	AN_S5 t5(mode4_case0, cc1, lg04, lg14, lg24, lg34);	


	//2,1,1,1
	wire mode0_case1, mode1_case1, mode2_case1, mode3_case1, mode4_case1;
	wire and0_1,and0_2,and0_3,and0_4,and1_2,and1_3,and1_4,and2_3,and2_4,and3_4;
	AN_S7 aa01(and0_1, e01, ne02, ne03, ne04, ne23, ne24, ne34);
	AN_S7 aa02(and0_2, ne01, e02, ne03, ne04, ne13, ne14, ne34);
	AN_S7 aa03(and0_3, ne01, ne02, e03, ne04, ne12, ne14, ne24);
	AN_S7 aa04(and0_4, ne01, ne02, ne03, e04, ne12, ne13, ne23);
	AN_S7 aa12(and1_2, ne01, ne03, ne04, e12, ne13, ne14, ne34);
	AN_S7 aa13(and1_3, ne01, ne02, ne04, ne12, e13, ne14, ne24);
	AN_S7 aa14(and1_4, ne01, ne02, ne03, ne12, ne13, e14, ne23);
	AN_S7 aa23(and2_3, ne01, ne02, ne04, ne12, ne14, e23, ne24);
	AN_S7 aa24(and2_4, ne01, ne02, ne03, ne12, ne13, ne23, e24);
	AN_S7 aa34(and3_4, ne01, ne02, ne03, ne12, ne13, ne23, e34);
	OR2 aaa0(mode0_case1, and0_1, and0_2);
	OR2 aaa1(mode1_case1, and1_2, and1_3);
	OR2 aaa2(mode2_case1, and2_3, and2_4);
	OR2 aaa3(mode3_case1, and0_3, and3_4);
	OR2 aaa4(mode4_case1, and0_4, and1_4);


	//3
	wire and0_1_2, and0_1_3, and0_1_4, and0_2_3, and0_2_4, and0_3_4, and1_2_3, and1_2_4, and1_3_4, and2_3_4;
	wire mode0_case2,mode1_case2, mode2_case2, mode3_case2, mode4_case2;
	AN3 aa012(and0_1_2, e01, e02, e12);
	AN3 aa013(and0_1_3, e01, e03, e13);
	AN3 aa014(and0_1_4, e01, e04, e14);
	AN3 aa023(and0_2_3, e02, e03, e23);
	AN3 aa024(and0_2_4, e02, e04, e24);
	AN3 aa034(and0_3_4, e03, e04, e34);
	AN3 aa123(and1_2_3, e12, e13, e23);
	AN3 aa124(and1_2_4, e12, e14, e24);
	AN3 aa134(and1_3_4, e13, e14, e34);
	AN3 aa234(and2_3_4, e23, e24, e34);
	wire r0, r1, r2, r3, r4;

	OR2 y1(mode0_case2, and0_1_2, and0_1_3);
	OR2 y2(mode1_case2, and0_1_4, and1_2_3);
	OR2 y3(mode2_case2, and0_2_3, and0_2_4);
	OR2 y4(mode3_case2, and0_3_4, and1_3_4);
	OR2 y5(mode4_case2, and1_2_4, and2_3_4);


	//2,2,1
	
	//0=1 2=3 4
	wire f0_0, f0_1, f0_2, f0_3, f1_0, f1_1, f1_2, f1_3, f1_4, f2_0, f2_1, f2_2, f2_3, f2_4, f2_5, f2_6, f3_0, f3_1, f3_2, f3_3, f3_4, f3_5, f4_0, f4_1, f4_2, f4_3;
	wire f0_4, f0_5, f0_6, f0_7;
	wire mode0_case3, mode1_case3, mode2_case3, mode3_case3, mode4_case3;
	AN_S5 aaaaa0(f2_0, e01, ne04, e23, ne24, lg02);
	AN_S5 aaaaa1(f0_0, e01, ne04, e23, ne24, lt02);

	//0=1 2=4 3
	AN_S5 aaaaa2(f2_1, e01, ne03, ne23, e24, lg02);
	AN_S5 aaaaa3(f0_1, e01, ne03, ne23, e24, lt02);

	//0=2 1=3 4
	AN_S5 aaaaa4(f1_0, e02, ne04, e13, ne14, lg01);
	AN_S5 aaaaa5(f0_2, e02, ne04, e13, ne14, lt01);
	//0=2 1=4 3
	AN_S5 aaaaa6(f1_1, e02, ne03, ne13, e14, lg01);
	AN_S5 aaaaa7(f0_3, e02, ne03, ne13, e14, lt01);
	
	//0=3 1=2 4
	AN_S5 aaaaa8(f1_2, e03, ne04, e12, ne14, lg01);
	AN_S5 aaaaa9(f3_0, e03, ne04, e12, ne14, lt01);
	//0=3 1=4 2
	AN_S5 aaaaa10(f1_3, ne02, e03, ne12, e14, lg01);
	AN_S5 aaaaa11(f3_1, ne02, e03, ne12, e14, lt01);
	//0=4 1=2 3
	AN_S5 aaaaa12(f2_2, ne03, e04, e12, ne13, lg01);
	AN_S5 aaaaa13(f4_0, ne03, e04, e12, ne13, lt01);
	//0=4 1=3 2
	AN_S5 aaaaa14(f3_2, ne02, e04, ne12, e13, lg01);
	AN_S5 aaaaa15(f4_1, ne02, e04, ne12, e13, lt01);
	//0 1=2 3=4
	AN_S5 aaaaa16(f4_2, ne01, ne03, e12, e34, lg13);
	AN_S5 aaaaa17(f2_3, ne01, ne03, e12, e34, lt13);
	//0 1=3 2=4
	AN_S5 aaaaa18(f4_3, ne01, ne02, e13, e24, lg12);
	AN_S5 aaaaa19(f3_3, ne01, ne02, e13, e24, lt12);
	//0 1=4 2=3
	AN_S5 aaaaa20(f2_4, ne01, ne02, e14, e23, lg12);
	AN_S5 aaaaa21(f1_4, ne01, ne02, e14, e23, lt12);
	//1 0=2 3=4
	AN_S5 aaaaa22(f3_4, ne01, e02, ne13, e34, lg03);
	AN_S5 aaaaa23(f0_4, ne01, e02, ne13, e34, lt03);	
	//1 0=3 2=4
	AN_S5 aaaaa24(f2_5, ne01, e03, ne12, e24, lg02);
	AN_S5 aaaaa25(f0_5, ne01, e03, ne12, e24, lt02);	
	//1 0=4 2=3
	AN_S5 aaaaa26(f2_6, ne01, e04, ne12, e23, lg02);
	AN_S5 aaaaa27(f0_6, ne01, e04, ne12, e23, lt02);	
	//2 0=1 3=4
	AN_S5 aaaaa28(f3_5, e01, ne02, ne24, e34, lg03);
	AN_S5 aaaaa29(f0_7, e01, ne02, ne24, e34, lt03);		

	OR_S6 s0(mode0_case3, f0_0, f0_1, f0_2, f0_3, f3_0, f3_1);
	OR_S6 s1(mode1_case3, f1_0, f1_1, f1_2, f2_2, f3_2, f0_7);
	OR_S6 s2(mode2_case3, f2_0, f2_1, f2_3, f4_3, f0_4, f2_5);
	OR_S6 s3(mode3_case3, f3_3, f2_4, f3_4, f0_5, f2_6, f3_5);
	OR_S6 s4(mode4_case3, f1_3, f4_0, f4_1, f4_2, f1_4, f0_6);


	wire mode0,mode1,mode2,mode3,mode4;
	OR_S4 fi0(mode0, mode0_case0, mode0_case1, mode0_case2, mode0_case3);
	OR_S4 fi1(mode1, mode1_case0, mode1_case1, mode1_case2, mode1_case3);
	OR_S4 fi2(mode2, mode2_case0, mode2_case1, mode2_case2, mode2_case3);
	OR_S4 fi3(mode3, mode3_case0, mode3_case1, mode3_case2, mode3_case3);
	OR_S4 fi4(mode4, mode4_case0, mode4_case1, mode4_case2, mode4_case3);

	final_mux fm1(mode[0], mode0, mode1, mode2, mode3, mode4, i0[0], i1[0], i2[0], i3[0], i4[0]);
	final_mux fm2(mode[1], mode0, mode1, mode2, mode3, mode4, i0[1], i1[1], i2[1], i3[1], i4[1]);
	final_mux fm3(mode[2], mode0, mode1, mode2, mode3, mode4, i0[2], i1[2], i2[2], i3[2], i4[2]);
	final_mux fm4(mode[3], mode0, mode1, mode2, mode3, mode4, i0[3], i1[3], i2[3], i3[3], i4[3]);

endmodule
