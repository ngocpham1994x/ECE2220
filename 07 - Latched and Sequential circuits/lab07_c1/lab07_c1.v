module lab07_c1(D,clock,Q,Qbar,LED0,LED9);
input D,clock;
output Q,Qbar,LED0,LED9;

wire out1,out2;


nand a1(out1,D,clock);
nand a2(out2,~D,clock);
nand a3(Q,Qbar,out1);
nand a4(Qbar,Q,out2);

assign LED0 = D;
assign LED9 = clock;


endmodule
