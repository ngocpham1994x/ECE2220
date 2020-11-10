module lab07_b(S,R,Q,Qbar, LED0,LED1,LED9,clock);
input S,R,clock;
output Q,Qbar,LED0,LED1,LED9;

wire Rint,Sint;

and a1 (Rint,clock,R);  //1st AND gate, input: R,clock, output: Rint
and a2 (Sint,clock,S);  //2nd AND gate, input: S,clock, output: Sint
nor a3 (Q,Rint,Qbar);   //1st NOR gate, input: Rint,Qbar, output: Q
nor a4 (Qbar,Sint,Q);   //2nd NOR gate, input: Sint,Q, output: Qbar

assign LED0 = S;
assign LED1 = R;
assign LED9 = clock;

endmodule