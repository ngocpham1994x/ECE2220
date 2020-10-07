module lab04_2(in, out, select, LED);  // 4:1 multiplexer
	input [3:0]in;
	input [9:8]select;
	output reg out;
	output [9:0]LED;
	
// part 2: Implement circuit using AND, OR and NOT gates

	always @(in,select)
	begin
	
		out = (~select[9]&~select[8]&in[0]) | (~select[9]&select[8]&in[1]) | (select[9]&~select[8]&in[2]) | (select[9]&select[8]&in[3]);

	end
	
	// assign value of controlled elements to be represented on LED

	assign LED[0] = in[0];  // LHS has to be assigned by the RHS, not the other way around
	assign LED[1] = in[1];
	assign LED[2] = in[2];
	assign LED[3] = in[3];
	assign LED[8] = select[8];
	assign LED[9] = select[9];
	
	// assign value of output to be represented on LED
	
	assign LED[6] = out;
	
	
endmodule