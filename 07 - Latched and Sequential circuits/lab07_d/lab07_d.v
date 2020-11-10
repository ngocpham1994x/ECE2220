module lab07_d(J,K,Q,Qbar,clock,LED0,LED1,LED9);
input J,K,clock;
output Q,Qbar,LED0,LED1,LED9;

wire D,a,b;

//implementing the function obtained from solving the Kmap
and (a,J,Qbar);
and(b,~K,Q);
or(D,a,b);


//feeding J,K,Q as D to Dlatch module
Dlatch(D,Q,Qbar,clock);


assign LED0 = J;
assign LED1 = K;
assign LED9 = clock;

endmodule

	

//////////////////////////


module Dlatch(D,Q,Qbar,clock);
input D,clock;
output Q,Qbar;


SRlatch(D,~D,Q,Qbar,clock);  //calling the SRlatch module


endmodule


/////////////////////////


module SRlatch(S,R,Q,Qbar,clock);
input S,R,clock;
output Q,Qbar;

wire Rint,Sint;

and a1 (Rint,clock,R);  //1st AND gate, input: R,clock, output: Rint
and a2 (Sint,clock,S);  //2nd AND gate, input: S,clock, output: Sint
nor a3 (Q,Rint,Qbar);   //1st NOR gate, input: Rint,Qbar, output: Q
nor a4 (Qbar,Sint,Q);   //2nd NOR gate, input: Sint,Q, output: Qbar


endmodule
