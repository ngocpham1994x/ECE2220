module test(
input [3:0] binary,
output [6:0]left,
output [6:0]right
);

wire [3:0] tenth,one;
BCD(binary, , ,tenth,one);

SSD_converter(tenth,left);
SSD_converter(one,right);



endmodule


module BCD(
input [11:0] binary_in,   //12-bit binary comes in, 12-bit for extra digits to account for thoudsandth position. Example: binary 1111 1111 1111 = decimal 4093
output reg [3:0] thousandth,
output reg [3:0] hundredth,
output reg [3:0] tenth,
output reg [3:0] oneth
);

reg [11:0] binary_local = 0;

always @ (binary_in)
	begin
	
	binary_local = binary_in;
	thousandth = binary_local/1000;
	binary_local = binary_local%1000;
	hundredth =	binary_local/100;
	binary_local = binary_local%100;
	tenth = binary_local/10;
	oneth = binary_local%10;
	
	end

endmodule



module SSD_converter(in, SSD);
input [3:0]in;        //decimal number comes in
output reg [6:0]SSD;  //SSD comes out as output

always @ (in)
begin
		case(in)
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
		default SSD = 7'h7F; //binary  1  1  1  1  1  1  1 
		
		endcase
end

endmodule
