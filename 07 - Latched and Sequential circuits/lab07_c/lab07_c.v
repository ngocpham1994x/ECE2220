module lab07_c(D,q,qbar,clock, LED0,LED9);
input D,clock;
output q,qbar,LED0,LED9;


assign LED0 = D;
assign LED9 = clock;


SRlatch Dlatch(D,~D,q,qbar,clock);  //calling SRlatch module


//assign LED1 = ~D;
//assign LED3 = q;
//assign LED4 = qbar;

endmodule





module SRlatch(S,R,Q,Qbar,clock);
input S,R,clock;
output Q,Qbar;

wire Rint,Sint;

and a1 (Rint,clock,R);  //1st AND gate, input: R,clock, output: Rint
and a2 (Sint,clock,S);  //2nd AND gate, input: S,clock, output: Sint
nor a3 (Q,Rint,Qbar);   //1st NOR gate, input: Rint,Qbar, output: Q
nor a4 (Qbar,Sint,Q);   //2nd NOR gate, input: Sint,Q, output: Qbar


endmodule
