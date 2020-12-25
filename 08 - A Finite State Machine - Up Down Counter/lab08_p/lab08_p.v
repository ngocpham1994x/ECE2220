module lab08_p(clock,w,reset,clock_1Hz, SSD,reset_LED,w_LED);
input clock,w,reset;
output reg [6:0]SSD; 

output reset_LED,w_LED;  //LEDs to be shown on the board

output clock_1Hz;
wire [3:0]Dbar;
reg [3:0]d;
reg [3:0]D;


assign w_LED = w;
assign reset_LED = reset;
//assign clock_LED = clock_1Hz;


//converting internal clock to slower clock
clock_converter(clock,clock_1Hz);



//combinational circuit 1  
always@(posedge clock_1Hz) 

begin 
		if(reset == 1'b1)    //if reset is true
			D = 0;
		else 
		
		begin
		
		if(w == 1'b0)  //if counting up
						begin
							case(d)          //STATE
							0: D = 1;   //b
							1: D = 2;   //c
							2: D = 3;   //d
							3: D = 4;   //e
							4: D = 5;   //f
							5: D = 6;   //g
							6: D = 7;   //h
							7: D = 8;   //i
							8: D = 9;   //j
							9: D = 10;  //k
							10: D = 11; //l 
							11: D = 12; //m
							12: D = 13; //n
							13: D = 14; //o
							14: D = 15; //p
							15: D = 0;  //a
							endcase
						end

					 
		if(w == 1'b1) //if counting down
						begin
							case(d)          //STATE
							0: D = 15;  //p
							1: D = 0;   //a
							2: D = 1;   //b
							3: D = 2;   //c
							4: D = 3;   //d
							5: D = 4;   //e
							6: D = 5;   //f
							7: D = 6;   //g
							8: D = 7;   //h
							9: D = 8;   //i
							10: D = 9;  //j
							11: D = 10; //k
							12: D = 11; //l
							13: D = 12; //m
							14: D = 13; //n
							15: D = 14; //o
							endcase
						end 
		end
		
	d = D;
	
	//7 SSD display
		case(D)
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
end
	


	
	



endmodule






//submodules
/////////////////////////////////////////////////////
module clock_converter(internal_clock_25Hz,clock_1Hz);
input internal_clock_25Hz;
output reg clock_1Hz;

//reg slow;
reg [27:0]count;

	always @(posedge internal_clock_25Hz)

	begin 
		count = count + 1;      //increment +ve edge counter on every positive edge iteration of the 25MHz inernal clock

		if (count >=25_000_000) //if the +ve edge counter >= 50 000 000 edges 

		begin 

		count =0;               //then reset the 25Hz +ve edge counter to 0
		clock_1Hz = ~clock_1Hz; //and set the 1Hz clock to be 1 ( or 0, depends on previous state of 1Hz clock)
	
		end 

	end
	
endmodule



