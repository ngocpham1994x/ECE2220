module lab07_e(J,K,Q,Qbar,clock,LED0,LED1,LED9);
input J,K,clock;
output Q,Qbar,LED0,LED1,LED9;

wire w1,w2,Master,Masterbar;

and b1(w1,J,Qbar);
and b2(w2,K,Q);



//master

SRlatch(w1,w2,Master,Masterbar,clock); //calling SRlatch for Master



//slave

SRlatch(Master,Masterbar,Q,Qbar,clock); //calling SRlatch for Slave



//assignment
assign LED0 = J;
assign LED1 = K;
assign LED9 = clock;


endmodule



///////////////////////////////



module SRlatch(S,R,Q,Qbar,clock);
input S,R,clock;
output Q,Qbar;

wire Rint,Sint;

and a1 (Rint,clock,R);  //1st AND gate, input: R,clock, output: Rint
and a2 (Sint,clock,S);  //2nd AND gate, input: S,clock, output: Sint
nor a3 (Q,Rint,Qbar);   //1st NOR gate, input: Rint,Qbar, output: Q
nor a4 (Qbar,Sint,Q);   //2nd NOR gate, input: Sint,Q, output: Qbar


endmodule
