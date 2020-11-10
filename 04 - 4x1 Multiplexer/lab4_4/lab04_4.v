module lab04_4( LED, in, select, out ); // 4:1 multiplexer
	input [3:0]in; 		 // inputs 0 to 3
	input [9:8]select;    // selector 8 & 9
	output[9:0]LED;       // LED representations of inputs, selector & output 
	output reg out;       // output acts as register
	
	
//part 4: using one-liner if statement


	always @ (select)
	begin
		out = (select[9]) ? (select[8] ? in[3] : in[2]) : (select[8] ? in[1] : in[0]);

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
