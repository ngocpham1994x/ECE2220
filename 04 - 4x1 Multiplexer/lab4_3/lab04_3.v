module lab04_3( LED, in, select, out ); // 4:1 multiplexer
	input [3:0]in; 		 // inputs 0 to 3
	input [9:8]select;    // selector 8 & 9
	output[9:0]LED;       // LED representations of inputs, selector & output 
	output reg out;       // output acts as register
	
	
//part 3: using "case" statement

	always @ (select)
	begin
		case (select)  //2-bit selector
			                      // S8 S9 out       LED[6] 
			2'b00: out = in[0];   // 0  0  input 0   LED[0]
			2'b01: out = in[1];   // 0  1  input 1   LED[1]
			2'b10: out = in[2];   // 1  0  input 2   LED[2]
			2'b11: out = in[3];   // 1  1  input 3   LED[3]
			
		endcase
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
