module lab07_a(S,R,Q,Qbar, LED0, LED1);
input  S,R;
output Q,Qbar,LED0, LED1;


//basic latch: NOR
 
nor a1 (Q,R,Qbar);  //1st NOR gate, input: R,Qbar, output: Q
nor a2 (Qbar,S,Q);  //2nd NOR gate, input: S,Q, output: Qbar

assign LED0 = S;    //making LEDs ON when switches ON
assign LED1 = R;


//basic latch: NAND

//nand a3 (Q,S,Qbar);  //1st NAND gate, input: S,Qbar, output: Q
//nand a4 (Qbar,R,Q);  //2nd NAND gate, input: R,Q, output: Qbar



endmodule
