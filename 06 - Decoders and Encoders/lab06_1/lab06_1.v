module lab06_1(in, out);
input [2:0]in;
output [7:0]out;

// part a: decoder behaviorally using only primitives (AND, OR, NOT etc.), or their symbols ($, |, ~ etc.)

assign out [0] = ~in[2] & ~in[1] & ~in[0];
assign out [1] = ~in[2] & ~in[1] &  in[0];
assign out [2] = ~in[2] &  in[1] & ~in[0];
assign out [3] = ~in[2] &  in[1] &  in[0];
assign out [4] =  in[2] & ~in[1] & ~in[0];
assign out [5] =  in[2] & ~in[1] &  in[0];
assign out [6] =  in[2] &  in[1] & ~in[0];
assign out [7] =  in[2] &  in[1] &  in[0];

endmodule
