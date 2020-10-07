module lab02 (motor,pwr,door,water_level,flow_lim,e_stop,e_pressed,LED);

	input pwr,door,water_level,flow_lim; // 4 physical sensors (switches)
	input e_stop;  		// physical e_stop (push button)  // think about this like a clock
	output motor;  		// physical motor output (LED[9])
	
	output [3:0] LED;  	// 4 physical LEDs [0:3] represent states of 4 physical switches
	reg e_pressed = 0;   // register represents state of emergency 
								// e_stop push button pressed once, e_pressed = active; e_stop pressed second time, e_pressed = reset
	output e_pressed;    // physical LED[5] represents state of emergency
	
	assign motor = pwr & door & water_level & ~flow_lim & ~e_pressed ;
	
	assign LED[0] = pwr;
	assign LED[1] = door;
	assign LED[2] = water_level;
	assign LED[3] = flow_lim;
	
	
		always @ (negedge e_stop)      // triggered by negative edge
		
			e_pressed = ~e_pressed;  // whenever the negative edge is triggered by e_stop push button, switching state of emergency between active and reset
				
endmodule
