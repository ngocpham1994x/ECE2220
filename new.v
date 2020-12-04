module new (internal_clock,clock_1s);
input internal_clock;
output clock_1s;

clock_converter(internal_clock,clock_1s);

endmodule


module clock_converter(internal_clock_25Hz,clock_1Hz);
input internal_clock_25Hz;
output reg clock_1Hz;

//reg slow;
reg [27:0]count;

	always @(posedge internal_clock_25Hz)

	begin 
		count = count + 1;      //increment +ve edge counter on every positive edge iteration of the 25MHz inernal clock

		if (count >=50000000) //if the +ve edge counter >= 50 000 000 edges 

		begin 

		count =0;               //then reset the 25Hz +ve edge counter to 0
		clock_1Hz = ~clock_1Hz; //and set the 1Hz clock to be 1 ( or 0, depends on previous state of 1Hz clock)
	
		end 

	end
	
endmodule

