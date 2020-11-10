module lab07_d1(J,K,clock,Q,Qbar,LED0,LED1,LED9);
input J,K,clock;
output Q,Qbar,LED0,LED1,LED9;

wire r,s,Rint,Sint;

and a1(r,Qbar,J);
and a2(s,Q,~K);


and a3(Rint,r,clock);
and a4(Sint,s,clock);
nor a5(Q,Qbar,Rint);
nor a6(Qbar,Q,Sint);


//and a1(out1,J,Qbar,clock);
//and a2(out2,K,Q,clock);
//nor a3(Q,Qbar,out1);
//nor a4(Qbar,Q,out2);


assign LED0 = J;
assign LED1 = K;
assign LED9 = clock;


endmodule
