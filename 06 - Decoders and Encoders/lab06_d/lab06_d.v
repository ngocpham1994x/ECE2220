module lab06_d(in, out,z);
input [7:0]in;
output[2:0]out;
output reg z;
reg[2:0]out;

//part d: 8:3 priority encoder using "casex" statement

always @ (in)
	begin
		if (in==0)
			begin
				z=0;
				out = 0;
			end
			
		else
			z = 1;
			casex (in)
	
				8'b00000001:out = 3'b000;
				8'b0000001x:out = 3'b001;
				8'b000001xx:out = 3'b010;
				8'b00001xxx:out = 3'b011;
				8'b0001xxxx:out = 3'b100;
				8'b001xxxxx:out = 3'b101;
				8'b01xxxxxx:out = 3'b110;
				8'b1xxxxxxx:out = 3'b111;
	
			endcase
	end
endmodule
