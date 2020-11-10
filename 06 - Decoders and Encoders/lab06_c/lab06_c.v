module lab06_c(in, out, z);
input [7:0]in;
output z;
output [2:0]out;
wire [7:0]i;

//part c: 8:3 priority encoder using primitive logics

assign i [0] = ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & ~in[2] & ~in[1] & in[0];
assign i [1] = ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & ~in[2] & in[1];
assign i [2] = ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & in[2]; 
assign i [3] = ~in[7] & ~in[6] & ~in[5] & ~in[4] & in[3];
assign i [4] = ~in[7] & ~in[6] & ~in[5] & in[4];
assign i [5] = ~in[7] & ~in[6] & in[5];
assign i [6] = ~in[7] & in[6];
assign i [7] = in[7];

assign z = |in;

assign out [2] = i[4] | i[5] | i[6] | i[7];
assign out [1] = i[2] | i[3] | i[6] | i[7];
assign out [0] = i[1] | i[3] | i[5] | i[7];


endmodule
