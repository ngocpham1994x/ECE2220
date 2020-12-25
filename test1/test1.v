module test1(  					//alarm clock project
input internal_clock,         //internal clock, 50MHz
input switch_screen,          //switching screen between real-time clock and alarm setup screen
input reset,                  //push button #4: reset button for resetting clock 
input hour_button,            //push button #3: increasing hour button (real-time screen or alarm screen
input min_button,             //push button #2: increasing minute button (real-time screen or alarm screen
input [7:0] second_display,   //displaying second via 7 LEDs
output [6:0] seg,             //output of next state in finite-state-machine, setting the next second
output [3:0] enable,          //enable the SSD
output clock_1Hz              //real-time clock, 1-sec clock
);


//local variables
wire [3:0] seccond1,second0,minute1,minute0,hour1,hour0; //SSD display for H1H0:M1M0
reg hour_up, min_up;

wire hour_button_debounced_led, min_button_debounced_led, reset_button_debounced_led;
reg hour_button_store, min_button_store, reset_button_store;



//converting internal clock to 1-sec clock
clock_converter(internal_clock,clock_1Hz);


//debouncing buttons
debounce reset_db(clock_1Hz,reset,reset_button_debounced_led);
debounce hour_db(clock_1Hz,hour_button,hour_button_debounced_led);
debounce min_db(clock_1Hz,min_button,min_button_debounced_led);


//
clock_SSD(
clock_1Hz,      //desired clock
reset,          //reset button
hour1,    //decimal value H1 in H1H0:M1M0
hour0,    //decimal value H0 in H1H0:M1M0
minute1,  //decimal value M1 in H1H0:M1M0
minute0,  //decimal value M0 in H1H0:M1M0
seg, //next output in finite state machine
enable        //
);



//
real_time_clock(
clock_1Hz,
switch_screen,          //enable the clock screen
reset_button_debounced_led,           //clock reset button to 00:00
hour_up,     //button for set hour increment 
minute_up,    //button for set minute increment
second1,  //decimal values of second
second0,  //decimal values of second
minute1,  //decimal values of minute
minute0,  //decimal values of minute
hour1,    //decimal values of hour
hour0     //decimal values of hour
);



//

always @ (posedge clock_1Hz)
	begin
	hour_button_store <= hour_button_debounced_led; 
	min_button_store <= min_button_debounced_led;
	if(hour_button_store == 1'b0 && hour_button_debounced_led == 1'b1)
		hour_up <= 1;
	else 
		hour_up <= 0;
		
	if(min_button_store == 1'b0 && min_button_debounced_led == 1'b1)
		min_up <= 1;
	else 
		min_up <= 0;
	end


//
assign second_display[3:0] = second0;
assign second_display[7:3] = second1;



endmodule



//submodules
/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////1-SEC CLOCK/////////////////////////////////////////////////
module clock_converter(internal_clock,clock_1Hz,reset);
input internal_clock,reset;
output reg clock_1Hz;

//reg slow;
reg [27:0]count;

	always @(posedge internal_clock)

	if(reset == 1'b1)
		count <= 0;
		
	else
	
	begin 
		count = count + 1;      //increment +ve edge counter on every positive edge iteration of the 25MHz (or 50MHz) inernal clock

		if (count >= 50000000) //if the +ve edge counter >= 50 000 000 edges 

		begin 

		count <= 0;               //then reset the 25Hz (ot 50Hz) +ve edge counter to 0
		clock_1Hz = ~clock_1Hz; //and set the 1Hz clock to be 1 ( or 0, depends on previous state of 1Hz clock)
	
		end 

	end
	
endmodule


/////////////////////////////D FLIP FLOP//////////////////////////////////////////
module D_flipflop (clock_in, D, Q, Qbar);
input clock_in; //1Hz clock
input D;    //push button
output reg Q, Qbar;

always @ (posedge clock_in)
	begin
	Q <= D;
	Qbar <= !Q;
	end
	
endmodule

/////////////////////////////DEBOUNCE PUSH BUTTON//////////////////////////////////////////
module debounce(
input push_button, clock_in,
output led 
);

wire Q1, Q2, Q2bar;

D_flipflop (clock_in, push_button, Q1);
D_flipflop (clock_in, Q1, Q2);

assign Q2bar = ~Q2;
assign led =  Q1 & Q2bar;

endmodule


/////////////////////////////BCD CONVERTER/////////////////////////////////////////////////
module binaryToDecimal(
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



/////////////////////////////REAL-TIME CLOCK MODULE/////////////////////////////////////////////////
module real_time_clock(
input clock_1Hz,
input enable,          //enable the clock screen
input reset,           //clock reset button to 00:00
input hour_button,     //button for set hour increment 
input minute_button,    //button for set minute increment
output [3:0] second1,  //decimal values of second
output [3:0] second0,  //decimal values of second
output [3:0] minute1,  //decimal values of minute
output [3:0] minute0,  //decimal values of minute
output [3:0] hour1,    //decimal values of hour
output [3:0] hour0     //decimal values of hour
);

//local variables
reg [5:0] hour=0, min=0, sec=0;  //binary 11111 = 63 to account for 60 minutes and 60 seconds, 24 hours

always @ (posedge clock_1Hz)

	if(reset == 1)    //if reset is true
		begin
		hour <= 0;
		min <= 0;
		sec <= 0;
		end
	
	//incrementing the real-time clock 
	else if (enable)
		begin
			if(sec == 59)
			begin
				sec <= 0;
				if(min == 59)
				begin
					min <= 0;
					if(hour == 23)
					begin 
						hour <= 0;
					else
						hour <= hour +1;
					end
				else
					min <= min +1;
				end
			else
				sec <= sec + 1;
			end
		end
		
							
//		sec <= (sec == 60) ? (0) : (sec + 1);
//		min <= (sec == 60) ? (min + 1) : (min) ;
//		min <= (min == 60) ? (0) : (min);
//		hour <= (min == 60) ? (hour + 1) :(hour) ;
//		hour <= (hour == 24) ? (0) : (hour);
	
	
	//setting the clock from push buttons
	else if (hour_button)    //if hour_button is pressed(hold) to set hour value 
		hour <= (hour == 23) ? (hour <= 0) : (hour <= hour + 1);    //if hour == 23 , reset hour value to 0, else incrementing hour value 
	else if (minute_button)
		min <= (min == 59) ? (min <= 0) : (min <= min + 1);
		



binaryToDecimal  seconds(sec, , ,second1, second0);
binaryToDecimal  minutes(min, , ,minute1, minute0);
binaryToDecimal  hours(hour, , ,hour1, hour0);




endmodule	


/////////////////////////////CONVERT A DECIMAL (4-BIT BINARY) ONTO 7-SEGMENT DISPLAY///////////////////////////////////
/////////////////////////////NOTE THAT 4-BIT BINARY HERE ONLY FROM 0-9/////////////////////////////////////////////////
/////////////////////////////SETTING SINGLE DIGIT FROM HH:MM AS SINGLE SEVEN SEGMENT DISPLAY ON THE BOARD/////////////
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


/////////////////////////////SETTING 4 DECIMAL NUMBERS TO 4 SSD TO DISPLAY HH:MMON BOARD///////////
/////////////////////////////FINITE STATE MACHINE/////////////////////////////////////////////////
module clock_SSD(
input clock_1Hz,      //desired clock
input reset,          //reset button
input [3:0] hour1,    //decimal value H1 in H1H0:M1M0
input [3:0] hour0,    //decimal value H0 in H1H0:M1M0
input [3:0] minute1,  //decimal value M1 in H1H0:M1M0
input [3:0] minute0,  //decimal value M0 in H1H0:M1M0
output reg [6:0] seg, //next output in finite state machine
output reg [3:0] enable        //
);

wire [6:0] segment1, segment2, segment3, segment4;
reg [12:0] segclock;   //for turning segment displays one by one on the board

//finite state machine
localparam LEFT = 2'b00, MIDLEFT = 2'b01, MIDRIGHT = 2'b10, RIGHT = 2'b11;
reg [1:0] state = LEFT; 

always @ (posedge clock_1Hz)
	segclock <= segclock + 1;
	
	always @ (posedge segclock[12] or posedge reset)
		begin
		
		if (reset == 1)        //if reset button is pressed
			begin
			seg <= 7'b0000000; 
			enable <= 4'b0000;
			state <= LEFT;
			end
		else                  //if reset button is NOT pressed, then run the state machine for next output of "seg"
			begin
			case (state)
				LEFT: 
					begin
					seg <= segment1;
					enable <= 4'b0111;
					state <= MIDLEFT; 
					end
				MIDLEFT:
					begin
					seg <= segment2;
					enable <= 4'b1011;
					state <= MIDRIGHT;
					end
				MIDRIGHT:
					begin
					seg <= segment3;
					enable <= 4'b1101;
					state <= RIGHT;
					end
				RIGHT:
					begin
					seg <= segment4;
					enable <= 4'b1110;
					state <= LEFT;
					end

			endcase
			end
			
		end


SSD_converter sethour1(hour1, segment1);      //convert decimal value of hour onto SSD
SSD_converter sethour0(hour0, segment2);      //convert decimal value of hour onto SSD
SSD_converter setminute1(minute1, segment3);  //convert decimal value of minute onto SSD
SSD_converter setminute0(minute0, segment4);  //convert decimal value of minute onto SSD


		
endmodule


