// A 4-Bit Binary to Seven-Segment Decoder

module lab01extraSSD (B, S);
input [3:0] B;      // declare a set of 4 inputs wires
output [6:0] S;
reg[6:0] S;         // declare 7bit output register to drive seven segment LED

// Binary output from the truth table

always@(B)
	case(B)
						//        S6 S5 S4 S3 S2 S1 S0
		0: S=7'h40; //binary  1	 0  0  0  0  0  0 
		1: S=7'h79; //binary  1  1  1  1  0  0  1
		2: S=7'h24; //binary  0  1  0  0  1  0  0 
		3: S=7'h30;
		4: S=7'h19;
		5: S=7'h12;
		6: S=7'h02;
		7: S=7'h78;
		8: S=7'h00;
		9: S=7'h18;
		10: S=7'h08;
		11: S=7'h03;
		12: S=7'h46;
		13: S=7'h21;
		14: S=7'h06; 
		15: S=7'h0E;
	endcase
endmodule
