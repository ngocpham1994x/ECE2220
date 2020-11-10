// 7-segment display with error

module lab03(SSD,sw);
	input [3:0]sw;
	output [6:0]SSD;
	reg [6:0] SSD;


	
// part b: using &, |, ~ to display 7 SSD: 0-9, greater than 9 shows E (error)


//	always @ (sw)
//	begin
//// a	
//	SSD[0] = (~sw[3]&~sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&~sw[1]&~sw[0]);
//
//// b
//	SSD[1] = (~sw[3]&sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&sw[1]&~sw[0]) | (sw[3]&sw[2]) | (sw[3]&sw[1]);
//
//// c
//	SSD[2] = (~sw[3]&~sw[2]&sw[1]&~sw[0]) | (sw[3]&sw[2]) | (sw[3]&sw[1]);
//
//// d
//	SSD[3] = (~sw[3]&~sw[2]&~sw[1]&sw[0]) | (~sw[3]&sw[2]&~sw[1]&~sw[0]) | (~sw[3]&sw[2]&sw[1]&sw[0]);
//	
//// e
//	SSD[4] = (~sw[3]&sw[0]) | (~sw[3]&sw[2]&~sw[1]&~sw[0]) | (sw[3]&~sw[2]&~sw[1]&sw[0]);
//	
//// f
//	SSD[5] = (~sw[3]&~sw[2]&sw[0]) | (~sw[3]&~sw[2]&sw[1]) | (~sw[3]&sw[1]&sw[0]);
//	 
//// g
//	SSD[6] = (~sw[3]&~sw[2]&~sw[1]) | (~sw[3]&sw[2]&sw[1]&sw[0]);
//	end


	
// part c: using case statement to display 7 SSD: 0-9, greater than 9 shows E (error)


//	reg [6:0]SSD;
	
//	always @ (sw)
//		case(sw)
//								//    a  b  c  d  e  f  g
//		0: SSD=7'h40; //binary  0	0  0  0  0  0  1 // 0
//		1: SSD=7'h79; //binary  1  0  0  1  1  1  1 // 1
//		2: SSD=7'h24; //binary  0  0  1  0  0  1  0 // 2
//		3: SSD=7'h30; //binary  0  0  0  0  1  1  0 // 3
//		4: SSD=7'h19; //binary  1  0  0  1  1  0  0 // 4
//		5: SSD=7'h12; //binary  0  1  0  0  1  0  0 // 5
//		6: SSD=7'h02; //binary  0  1  0  0  0  0  0 // 6
//		7: SSD=7'h78; //binary  0  0  0  1  1  1  1 // 7
//		8: SSD=7'h00; //binary  0  0  0  0  0  0  0 // 8
//		9: SSD=7'h18; //binary  0  0  0  0  1  0  0 // 9
//		
//		
//// Error cases                 a  b  c  d  e  f  g
//		10: SSD=7'h06; //binary  0  1  1  0  0  0  0  // E
//		11: SSD=7'h06; //binary  0  1  1  0  0  0  0  // E
//		12: SSD=7'h06; //binary  0  1  1  0  0  0  0  // E
//		13: SSD=7'h06; //binary  0  1  1  0  0  0  0  // E
//		14: SSD=7'h06; //binary  0  1  1  0  0  0  0  // E
//		15: SSD=7'h06; //binary  0  1  1  0  0  0  0  // E
//		
//		endcase
//
//	


	
// part d: using case statement to display 7 SSD: 0-9, a-f


//	reg [6:0]SSD;
//	
	always @ (sw)
		case(sw)
								//    a  b  c  d  e  f  g
		0: SSD=7'h40; //binary  0	0  0  0  0  0  1 
		1: SSD=7'h79; //binary  1  0  0  1  1  1  1
		2: SSD=7'h24; //binary  0  0  1  0  0  1  0 
		3: SSD=7'h30; //binary  0  0  0  0  1  1  0 
		4: SSD=7'h19; //binary  1  0  0  1  1  0  0 
		5: SSD=7'h12; //binary  0  1  0  0  1  0  0 
		6: SSD=7'h02; //binary  0  1  0  0  0  0  0 
		7: SSD=7'h78; //binary  0  0  0  1  1  1  1 
		8: SSD=7'h00; //binary  0  0  0  0  0  0  0 
		9: SSD=7'h18; //binary  0  0  0  0  1  0  0 
		
		
// Letter cases                a  b  c  d  e  f  g
		10: SSD=7'h20; //binary  0  0  0  0  0  1  0 //a
		11: SSD=7'h03; //binary  1  1  0  0  0  0  0 //b
		12: SSD=7'h46; //binary  0  1  1  0  0  0  1 //c
		13: SSD=7'h21; //binary  1  0  0  0  0  1  0 //d
		14: SSD=7'h06; //binary  0  1  1  0  0  0  0 //e
		15: SSD=7'h0E; //binary  0  1  1  1  0  0  0 //f
		
		endcase




endmodule