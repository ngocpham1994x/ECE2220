//top module

module lab05(x,y, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 );
	input [3:0] x,y;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;

	wire [3:1] cout; 
	wire [4:0] sum; 
	wire overflow;

//adder module for all 4 bits

	bitwise_adder bit0(0,x[0],y[0],cout[1],sum[0]);
	bitwise_adder bit1(cout[1],x[1],y[1],cout[2],sum[1]);
	bitwise_adder bit2(cout[2],x[2],y[2],cout[3],sum[2]);
	bitwise_adder bit3(cout[3],x[3],y[3],overflow,sum[3]);
	
	assign overflow = sum[4];
	
	
	display (x, HEX0, HEX1); //Binary to decimal decoder module  (Binary Code Decimal)
	display (y, HEX2, HEX3);
	display (sum, HEX4, HEX5);
	
	
endmodule





//bitwise full adder module

module bitwise_adder(cin, x_bit, y_bit, cout, sum);
	input cin, x_bit, y_bit;
	output cout, sum;
	
	
	assign cout = (x_bit & y_bit) | (x_bit & cin) | (y_bit & cin); 
	assign sum =  x_bit ^ y_bit ^ cin;

endmodule





//display decimal on Seven Segment Display module

module display(binary_sw, SSD0, SSD1);
	input [4:0] binary_sw;             // declare a set of 5-bit inputs wires: 4-bit X, 4-bit Y, 5-bit SUM. Maximum value of the 5-bit SUM is 31 (binary: 0001 1111)
	output [6:0] SSD0,SSD1 ;
	reg [6:0] SSD0,SSD1;         // declare two 7bit output register to drive two seven segment LEDs

// Binary to ssd display

always@(binary_sw)
	case(binary_sw)
			
		00: begin SSD1=7'h7f;SSD0=7'h40; end //binary  0  0  0  0  0  0  1 // 0
		01: begin SSD1=7'h7f;SSD0=7'h79; end //binary  1  0  0  1  1  1  1 // 1
		02: begin SSD1=7'h7f;SSD0=7'h24; end //binary  0  0  1  0  0  1  0 // 2
		03: begin SSD1=7'h7f;SSD0=7'h30; end //binary  0  0  0  0  1  1  0 // 3
		04: begin SSD1=7'h7f;SSD0=7'h19; end //binary  1  0  0  1  1  0  0 // 4
		05: begin SSD1=7'h7f;SSD0=7'h12; end //binary  0  1  0  0  1  0  0 // 5
		06: begin SSD1=7'h7f;SSD0=7'h02; end //binary  0  1  0  0  0  0  0 // 6
		07: begin SSD1=7'h7f;SSD0=7'h78; end //binary  0  0  0  1  1  1  1 // 7
		08: begin SSD1=7'h7f;SSD0=7'h00; end //binary  0  0  0  0  0  0  0 // 8
		09: begin SSD1=7'h7f;SSD0=7'h18; end //binary  0  0  0  0  1  0  0 // 9
		
		
// range of 10-19:                                     a  b  c  d  e  f  g  | a  b  c  d  e  f  g

		10: begin SSD1=7'h79 ; SSD0=7'h40; end //binary  0  1  1  0  0  0  0  | 0  0  0  0  0  0  1  // 10
		11: begin SSD1=7'h79 ; SSD0=7'h79; end //binary  0  1  1  0  0  0  0  | 1  0  0  1  1  1  1  // 11
		12: begin SSD1=7'h79 ; SSD0=7'h24; end //binary  0  1  1  0  0  0  0  | 0  0  1  0  0  1  0  // 12
		13: begin SSD1=7'h79 ; SSD0=7'h30; end //binary  0  1  1  0  0  0  0  | 0  0  0  0  1  1  0  // 13
		14: begin SSD1=7'h79 ; SSD0=7'h19; end //binary  0  1  1  0  0  0  0  | 1  0  0  1  1  0  0  // 14
		15: begin SSD1=7'h79 ; SSD0=7'h12; end //binary  0  1  1  0  0  0  0  | 0  1  0  0  1  0  0  // 15
		16: begin SSD1=7'h79 ; SSD0=7'h02; end //binary  0  1  1  0  0  0  0  | 0  1  0  0  0  0  0  // 16
		17: begin SSD1=7'h79 ; SSD0=7'h78; end //binary  0  1  1  0  0  0  0  | 0  0  0  1  1  1  1  // 17
		18: begin SSD1=7'h79 ; SSD0=7'h00; end //binary  0  1  1  0  0  0  0  | 0  0  0  0  0  0  0  // 18
		19: begin SSD1=7'h79 ; SSD0=7'h18; end //binary  0  1  1  0  0  0  0  | 0  0  0  0  1  0  0  // 19

		
// range of 20-29:                                     a  b  c  d  e  f  g  | a  b  c  d  e  f  g
		
		20: begin SSD1=7'h24 ; SSD0=7'h40; end //binary  0  0  1  0  0  1  0  | 0  0  0  0  0  0  1  // 20
		21: begin SSD1=7'h24 ; SSD0=7'h79; end //binary  0  0  1  0  0  1  0  | 1  0  0  1  1  1  1  // 21
		22: begin SSD1=7'h24 ; SSD0=7'h24; end //binary  0  0  1  0  0  1  0  | 0  0  1  0  0  1  0  // 22
		23: begin SSD1=7'h24 ; SSD0=7'h30; end //binary  0  0  1  0  0  1  0  | 0  0  0  0  1  1  0  // 23
		24: begin SSD1=7'h24 ; SSD0=7'h19; end //binary  0  0  1  0  0  1  0  | 1  0  0  1  1  0  0  // 24
		25: begin SSD1=7'h24 ; SSD0=7'h12; end //binary  0  0  1  0  0  1  0  | 0  1  0  0  1  0  0  // 25
		26: begin SSD1=7'h24 ; SSD0=7'h02; end //binary  0  0  1  0  0  1  0  | 0  1  0  0  0  0  0  // 26
		27: begin SSD1=7'h24 ; SSD0=7'h78; end //binary  0  0  1  0  0  1  0  | 0  0  0  1  1  1  1  // 27
		28: begin SSD1=7'h24 ; SSD0=7'h00; end //binary  0  0  1  0  0  1  0  | 0  0  0  0  0  0  0  // 28
		29: begin SSD1=7'h24 ; SSD0=7'h18; end //binary  0  0  1  0  0  1  0  | 0  0  0  0  1  0  0  // 29
		



// range of 30-32:                                     a  b  c  d  e  f  g  | a  b  c  d  e  f  g
		
		30: begin SSD1=7'h30 ; SSD0=7'h40; end //binary  0  0  0  0  1  1  0  | 0  0  0  0  0  0  1  // 30

		
//		31: begin SSD1=7'h30 ; SSD0=7'h79; end //binary  0  0  0  0  1  1  0  | 1  0  0  1  1  1  1  // 31
//		32: begin SSD1=7'h30 ; SSD0=7'h29; end //binary  0  0  0  0  1  1  0  | 0  0  1  0  0  1  0  // 32


		
	endcase

endmodule