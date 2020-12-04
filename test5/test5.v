module test5(
input internal_clock,
output clock_1s,
output clock_fast,
input D,
output D_LED,
input reset_alarm,
output reset_alarm_LED,
output alarm_LED,
input stop
);


clock_converter(internal_clock,clock_1s);
clock_converter_fast(internal_clock,clock_fast);

reg test_LED;

always @ (*)
if(D)
	test_LED = clock_fast;
else
	test_LED = 0;


flipflop (test_LED, clock_1s, reset_alarm, alarm_LED, stop); 

assign D_LED = D;
assign reset_alarm_LED = reset_alarm;


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

		if (count >=25_000_000) //if the +ve edge counter >= 50 000 000 edges 

		begin 

		count <= 0;               //then reset the 25Hz +ve edge counter to 0
		clock_1s <= ~clock_1s; //and set the 1Hz clock to be 1 ( or 0, depends on previous state of 1Hz clock)
	
		end 

	end
	
endmodule

module clock_converter_fast(internal_clock,clock_1s);
input internal_clock;
output reg clock_1s;

//reg slow;
reg [27:0]count;

	always @(posedge internal_clock)

	begin 
		count <= count + 1;      //increment +ve edge counter on every positive edge iteration of the 25MHz inernal clock

		if (count >=5_000_000) //if the +ve edge counter >= 50 000 000 edges 

		begin 

		count <= 0;               //then reset the 25Hz +ve edge counter to 0
		clock_1s <= ~clock_1s; //and set the 1Hz clock to be 1 ( or 0, depends on previous state of 1Hz clock)
	
		end 

	end
	
endmodule


module flipflop (D, clock, Resetn, Q, stop); 
input D, clock, Resetn,stop; 
output reg Q;
//
always @(posedge Resetn, posedge stop, posedge clock) 
	begin
	Q <= D; 

	if (Resetn) 
		Q <= 0;
	if (stop)
		Q <= 0;
		
	end

endmodule

