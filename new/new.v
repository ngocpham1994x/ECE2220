
///////////////////////////////////////////////////////////////////////////
//
//COURSE: ECE 2220
//TERM: FALL 2020
//TEAM:
//TEAM MEMBERS & CREDITS:
//*NGOC PHAM (Student# 7891063) : Programming & Troubleshooting
//*MIN YOOK KIM: 
//*DAN:
//*ZANDER:
//
//
//TOPMODULES//
//4 slide switches: 
//		*clock time reset:
//			-location: SW[9] 
//			-reset time to 00:00:00. 
//			-Works when screen is on clock time only
//		*alarm time reset: 
//			-location: SW[8] 
//			-on alarm screen, if slided, reset alarm time to 00:00
//			-on clock screen, if slided up then back (simulate pulse signal), alarm LED will stop flashing. 
//				-->This represents snoozing until passing 1 minute
//		*alarm - stop snoozing:
//			-location: SW[7]
//			-on clock screen, if slided and stay HI position until passing 1 minute, alarm LED will be turned off entire 1 minute. 
//				-->This represents stop the snoozing.
//		*switch screen slider: SW[0]
// 		-select between clock screen or alarm screen
//
//2 push buttons: This applies on both screens
//		*minute set:
//			-location: KEY[0]
//		*hour set:
//			-location: KEY[1]
//
//9 LEDs : see below assignments 
///////////////////////////////////////////////////////////////////////////


module new (
input internal_clock,
input switch_screen_slideswitch,  //slide switch SW[0]
input stop_snooze,        //slide switch SW[7]
input reset_alarm,        //slide switch SW[8]
input reset_clock,        //slide switch SW[9]
input hour_button,        //push button [0]
input minute_button,      //push button [1]
output clock_1s,   		  //LED[0]
output minute_button_LED, //LED[1]
output hour_button_LED,   //LED[2]
output alarm_LED,     	  //LED[3]
output alarm_LED2,		  //LED[4]
output alarm_LED3,        //LED[5]
output alarm_LED4,        //LED[6]
output stop_snooze_LED,	  //LED[7]
output reset_alarm_LED,   //LED[8]  
output reset_clock_LED,   //LED[9]
output [6:0]second1_SSD,
output [6:0]second0_SSD,
output [6:0]minute1_SSD,
output [6:0]minute0_SSD,
output [6:0]hour1_SSD,
output [6:0]hour0_SSD
);

//set up local params
wire [3:0] second1, second0, minute1, minute0, hour1, hour0 ;
wire [3:0] alarm_minute1, alarm_minute0, alarm_hour1, alarm_hour0;
wire clock_fast;
reg alarm_data;

//LED assignments from switches and alarms
assign reset_clock_LED = reset_clock;      //slide switch SW[9] & LED[9]
assign reset_alarm_LED = reset_alarm;      //slide switch SW[8] & LED[8]
assign stop_snooze_LED = stop_snooze;		 //slide switch SW[7] & LED[7]
assign hour_button_LED = ~hour_button;     //push button LED[1]
assign minute_button_LED = ~minute_button; //push button LED[2]

//clocks
clock_converter(internal_clock,clock_1s);			  //real-time clock
clock_converter_fast(internal_clock,clock_fast);  //fast clock for pulsing effect for alarm

clock_counter (
clock_fast,
clock_1s,
reset_clock,           //clock reset button to 00:00:00
reset_alarm,
switch_screen_slideswitch,   //button for switching to alarm screen 
hour_button,
minute_button,
second1,  //tenth values of second
second0,  //oneth values of second
minute1,  //tenth values of minute
minute0,  //oneth values of minute
hour1,    //tenth values of hour
hour0,     //oneth values of hour);
alarm_minute1,
alarm_minute0,
alarm_hour1,
alarm_hour0
);

//7 SSD display
SSD_converter second1_display(second1,second1_SSD);
SSD_converter second0_display(second0,second0_SSD);
//depends on switch screen to select the clock time or alarm time will be displayed
SSD_converter2 minute1_display(switch_screen_slideswitch,alarm_minute1,minute1,minute1_SSD);
SSD_converter2 minute0_display(switch_screen_slideswitch,alarm_minute0,minute0,minute0_SSD);
SSD_converter2 hour1_display(switch_screen_slideswitch,alarm_hour1,hour1,hour1_SSD);
SSD_converter2 hour0_display(switch_screen_slideswitch,alarm_hour0,hour0,hour0_SSD);



///////////////////////////////////////////////////////////////////////////
//alarm control module (D-flipflop with reset slide switches as snooze and stop snoozing)



always @ (*)
	if( {alarm_minute1,alarm_minute0,alarm_hour1,alarm_hour0} == {minute1,minute0,hour1,hour0} )
		alarm_data = clock_fast;
	else
		alarm_data = 0;

alarmControl (alarm_data, clock_1s, reset_alarm, stop_snooze, alarm_LED, alarm_LED2, alarm_LED3, alarm_LED4); 

	

	
endmodule



///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
//ALL SUBMODULES//
///////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
//Clock counting, alarm counting//
///////////////////////////////////////////////////////////////////////////
module clock_counter(
input clock_fast,
input clock_1s,
input reset_clock,           //clock reset button to 00:00
input reset_alarm,
input switch_screen_slideswitch,   //button for switching to setting screen 
input hour_button,
input minute_button,
output [3:0] second1,  //decimal values of second
output [3:0] second0,  //decimal values of second
output [3:0] minute1,  //decimal values of minute
output [3:0] minute0,  //decimal values of minute
output [3:0] hour1,    //decimal values of hour
output [3:0] hour0,     //decimal values of hour)
output [3:0] alarm_minute1,
output [3:0] alarm_minute0,
output [3:0] alarm_hour1,
output [3:0] alarm_hour0
);




//local variables
reg [5:0] hour=0, min=0, sec=0;  //binary 11111 = 63 to account for 60 minutes and 60 seconds, 24 hours
reg [5:0] alarm_hour = 0, alarm_min = 0, alarm_sec = 0;
reg [27:0] count;



	
always @ (posedge clock_1s)

	if(reset_clock == 1'b1)   
		begin
		hour <= 0;
		min <= 0;
		sec <= 0;
		end
	
	//incrementing the real-time clock 
	else if(reset_clock == 0)   
		
		begin
			if(sec == 6'd59)
			begin
				sec <= 0;
				if(min == 6'd59)
				begin
				
					min <= 0;
					if(hour == 6'd23)
						hour <= 0;
					else
						hour <= hour + 1'b1;
				end
				
				else
					min <= min +1'b1;
			end
				
			else
				sec <= sec + 1'b1;
			
		 if (!hour_button && switch_screen_slideswitch == 0)    //if hour_button is pressed(hold) to set hour value 
			hour <= (hour == 6'd23) ? (0) : (hour + 1'b1);    //if hour == 23 , reset hour value to 0, else incrementing hour value
		 if (!minute_button && switch_screen_slideswitch == 0)  //if minute_button is pressed(hold) to set hour value
			min <= (min == 6'd59) ? (0) : (min + 1'b1);       //if minute == 59 , reset minute value to 0, else incrementing minute value
		end
		
		
							

							
always @ (posedge clock_fast)  //for fast pressing on hour push button & minute push button
		
	//setting the clock from push buttons
	if (switch_screen_slideswitch == 1'b1)
		begin
			if(reset_alarm == 1)
				begin
					alarm_hour <= 0;
					alarm_min <= 0;
					alarm_sec <= 0;
				end
			else
				begin
					if (!hour_button)    //if hour_button is pressed(hold) to set hour value 
						alarm_hour <= (alarm_hour == 6'd23) ? (0) : (alarm_hour + 1'b1);    //if hour == 23 , reset hour value to 0, else incrementing hour value
					if (!minute_button)  //if minute_button is pressed(hold) to set hour value
						alarm_min <= (alarm_min == 6'd59) ? (0) : (alarm_min + 1'b1);       //if minute == 59 , reset minute value to 0, else incrementing minute value
				end
		end

				
		
//decimal numbers of second, minute, hour (such as 25 seconds, 50 minutes, 21 hours, etc) are converted to tenth and oneth positions
BCD  seconds(sec, , ,second1, second0);
BCD  minutes(min, , ,minute1, minute0);
BCD  hours(hour, , ,hour1, hour0);

BCD  alarm_minutes(alarm_min, , ,alarm_minute1, alarm_minute0);
BCD  alarm_hours(alarm_hour, , ,alarm_hour1, alarm_hour0);

endmodule




///////////////////////////////////////////////////////////////////////////
//BCD: Extracting digit of hours, minutes, seconds//
///////////////////////////////////////////////////////////////////////////
module BCD(
input [11:0] number_in,   //12-bit binary comes in, 12-bit for extra digits to account for thoudsandth position. Example: binary 1111 1111 1111 = decimal 4093
output reg [3:0] thousandth,
output reg [3:0] hundredth,
output reg [3:0] tenth,
output reg [3:0] oneth
);

reg [11:0] number_local = 0;

always @ (number_in)
	begin
	
	number_local = number_in;
	thousandth = number_local/1000;
	number_local = number_local%1000;
	hundredth =	number_local/100;
	number_local = number_local%100;
	tenth = number_local/10;
	oneth = number_local%10;
	
	end

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


///////////////////////////////////////////////////////////////////////////
//Clock converter: slowing down internal clock (faster than the other clock for pulsing effect)//
///////////////////////////////////////////////////////////////////////////
module clock_converter_fast(internal_clock,clock_fast);
input internal_clock;
output reg clock_fast;

//reg slow;
reg [27:0]count;

	always @(posedge internal_clock)

	begin 
		count <= count + 1;      //increment +ve edge counter on every positive edge iteration of the 25MHz inernal clock

		if (count >=5_000_000) //if the +ve edge counter >= 50 000 000 edges 

		begin 

		count <= 0;               //then reset the 25Hz +ve edge counter to 0
		clock_fast <= ~clock_fast; //and set the 1Hz clock to be 1 ( or 0, depends on previous state of 1Hz clock)
	
		end 

	end
	
endmodule

///////////////////////////////////////////////////////////////////////////
//Clock display HH:MM:SS on multiple 7-segment displays//
///////////////////////////////////////////////////////////////////////////
module SSD_converter(decimal_input,SSD);
input [3:0] decimal_input;  //decimal number comes in
output reg [6:0]SSD;        //SSD comes out as output

always @ (decimal_input)

begin
			//7 SSD display
			case(decimal_input)
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



///////////////////////////////////////////////////////////////////////////
//Clock display HH:MM:SS vs Alarm display HH:MM on multiple 7-segment displays//
//2:1 multiplexer application//
///////////////////////////////////////////////////////////////////////////
module SSD_converter2(select, decimal_input1, decimal_input2,SSD);
input select;
input [3:0] decimal_input1, decimal_input2;  //decimal number comes in
output reg [6:0]SSD;        //SSD comes out as output

wire [3:0]value_in;

assign value_in = (select) ? decimal_input1 : decimal_input2;    //select clock time or alarm time to display. using selector (the switch scren slider)

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


///////////////////////////////////////////////////////////////////////////
//D-flipflop with reset switches//
///////////////////////////////////////////////////////////////////////////
module alarmControl (alarm_data, clock_1s, reset_alarm, stop_snooze, alarm_LED, alarm_LED2, alarm_LED3, alarm_LED4); 
input alarm_data, clock_1s, reset_alarm, stop_snooze; 
output reg alarm_LED, alarm_LED2, alarm_LED3, alarm_LED4;
//
always @(posedge reset_alarm, posedge stop_snooze, posedge clock_1s) 
	begin
	alarm_LED <= alarm_data; 
	alarm_LED2 <= alarm_data; 
	alarm_LED3 <= alarm_data; 
	alarm_LED4 <= alarm_data; 

	if (reset_alarm) 
		begin alarm_LED <= 0; alarm_LED2 <= 0; alarm_LED3 <= 0; alarm_LED4 <= 0; end
	if (stop_snooze)
		begin alarm_LED <= 0; alarm_LED2 <= 0; alarm_LED3 <= 0; alarm_LED4 <= 0; end
		
	end

endmodule