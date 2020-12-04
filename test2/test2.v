module test2(
input internal_clock,
output clock_1s,
input D,
input reset_alarm,
output alarm_LED
);


clock_converter(internal_clock,clock_1s);
flipflop (D, clock_1s, reset_alarm, alarm_LED); 


endmodule




///////////////////////////////////////////////////////////////////////////
//Clock converter: slowing down internal clock//
///////////////////////////////////////////////////////////////////////////
module clock_converter(internal_clock,clock_1s);
input internal_clock;
output reg clock_1s;

//reg slow;
reg [27:0]count;

	always @(posedge internal_clock)

	begin 
		count <= count + 1;      //increment +ve edge counter on every positive edge iteration of the 25MHz inernal clock

		if (count >=2) //if the +ve edge counter >= 50 000 000 edges 

		begin 

		count <= 0;               //then reset the 25Hz +ve edge counter to 0
		clock_1s <= ~clock_1s; //and set the 1Hz clock to be 1 ( or 0, depends on previous state of 1Hz clock)
	
		end 

	end
	
endmodule




module flipflop (D, clock, Resetn, Q); 
input D, clock, Resetn; 
output reg Q;
//
always @(negedge Resetn, posedge clock) 
	begin
	
	if (!Resetn) 
		Q <= 0;
	else 
		Q <= D; 

	end
	
endmodule
