module test3(select,SSD);
input select;
//input [3:0] decimal_input1, decimal_input2;  //decimal number comes in
output [6:0]SSD;        //SSD comes out as output


//wire decimal_input1 =4'b0101;
//wire decimal_input2 =4'b1001;


SSD_converter2(select, 9, 4,SSD);


endmodule




module SSD_converter2(select, decimal_input1, decimal_input2,SSD);
input select;
input [3:0] decimal_input1, decimal_input2;  //decimal number comes in
output reg [6:0]SSD;        //SSD comes out as output

wire [3:0]value_in;

assign value_in = (select) ? decimal_input1 : decimal_input2;

always @ (select, value_in)

begin
			//7 SSD display
			case(value_in)
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
			endcase
end

endmodule