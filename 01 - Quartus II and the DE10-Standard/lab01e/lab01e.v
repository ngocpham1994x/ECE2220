// 2-bit full adder

module lab01e(a,b,cin,sum,cout,f);

	input a, b, cin;
	output sum, cout;
	output [6:0] f;  // f is a 7-bit variable, assigned to 7 segment display on DE10 board
	reg [6:0] f;     // purpose: in always block, signal  on left hand side must be a reg type

	
	wire w0,w1,w2;
	xor u0(w0,a,b);
	xor u1(sum,w0,cin);
	and u2(w1,cin,w0);
	and u3(w2,b,a);
	or u4(cout,w1,w2);

// Method 1: if block
	
//	always @ (sum,cout)
//	begin
//		if(cout == 0 && sum == 0) f = 7'b1000000; //0
//		if(cout == 0 && sum == 1) f = 7'b1111001; //1
//		if(cout == 1 && sum == 0) f = 7'b0100100; //2
//		if(cout == 1 && sum == 1) f = 7'b0110000;	//3
//	end



// Method 2: case block

	always @ (sum,cout)
	begin
			case({cout , sum})  // 2-bit binary: first bit = count, second bit = sum
				0: f = 7'h40; //7'b1000000 //0 = 00
				1: f = 7'h79; //7'b1111001 //1 = 01
				2: f = 7'h24; //7'b0100100 //2 = 10
				3: f = 7'h30; //7'b0110000 //3 = 11
			endcase
	end

	
endmodule
