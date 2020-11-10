//2e 
module lab7 (q,qbar,J,K,key,clkind,a,b); //RS Latch
input key,J,K;
output q,qbar,clkind;

wire s,r,Rint,clk,clk1,Sint,S1,R1,R1int,S1int;

output wire a,b;

assign clkind=clk;   //for led output 
assign clk= ~key;    //clk inout for RS latch slave
assign clk1= key;    //clk input for RS latch Master

and (r,J,qbar);
and (s,K,q);

and a1 (Rint,r,clk1);   //Master RS latch
and a2 (Sint,s,clk1);
nor a3 (R1,Rint,S1);
nor a4 (S1,Sint,R1);

and a5 (R1int,R1,clk);   //Slave Rs Latch
and a6 (S1int,S1,clk);
nor a7 (q,R1int,qbar);
nor a8 (qbar,S1int,q);

assign a=J;      //for led output
assign b=K;      //for led output 


endmodule 





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//2d
//module lab7 (J,K,Qbar,Q,key,clkind,Jind,Kind); //JK latch
//
//input J,K,key;
//output Q,Qbar,clkind,Jind,Kind;
//
//wire D1,D2,D3, clk;
//
//and(D2,Q,~K);   //implementing function obtained from solving the Kmap
//and(D3,Qbar,J);
//or(D1,D2,D3);
//
//
//
//assign clkind = clk; //assigning for led output
//assign clk= ~key;
//assign Jind=J;
//assign Kind=K;
//
//Dlat(D1,Qbar,Q,clk);  //calling the module Dlat i.e Dlatch and feeding it the values obtained in Jk latch
//endmodule
//
//
//
//
//module rslatch(s,r,q,qbar,key); //rslatch
//
//input r,s,key;
//output q,qbar;
//
//wire Rint,clk,Sint;
//
//
//assign clk= key;
//and a1 (Rint,r,clk);  
//and a2 (Sint,s,clk);
//nor a3 (q,Rint,qbar);
//nor a4 (qbar,Sint,q);
//endmodule 
//
//
//
//module Dlat (D,Qbar,Q,key,clkind,dind); //dlatch
//
//input D,key;
//output Q,Qbar,clkind,dind;
//
//wire clk;
//
//assign clkind = clk;
//assign clk= ~key;
//assign dind=D;
//
//rslatch(D,~D,Q,Qbar,clk);
//endmodule






/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//2c
//module rslatch(s,r,q,qbar,key); 
//input r,s,key;
//output q,qbar;
//
//wire Rint,clk,Sint;
//
//
//assign clk= key;
//and a1 (Rint,r,clk);    //using gate primitives to output qbar and q at the end
//and a2 (Sint,s,clk);
//nor a3 (q,Rint,qbar);   
//nor a4 (qbar,Sint,q);
//
//
//endmodule 
//
//
//module lab7 (D,Qbar,Q,key,clkind,dind); //dlatch
//
//input D,key;
//output Q,Qbar,clkind,dind;
//
//wire clk;
//
//assign clkind = clk;
//assign clk= ~key;
//assign dind=D;             //assigning for led output
//
//rslatch(D,~D,Q,Qbar,clk);  //calling the module RS latch and feeding it the values obtained in the dlatch 
//
//endmodule








////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//2b
//module lab7 (s,r,q,qbar,key,a,b,c); 
//input r,s,key;
//output q,qbar;
//
//wire Rint,clk,Sint; 
//
//output wire a,b,c;
//
//assign clk= ~key;
//and a1 (Rint,r,clk);  //using gate primitives to output qbar and q at the end
//and a2 (Sint,s,clk);
//nor a3 (q,Rint,qbar);
//nor a4 (qbar,Sint,q);
//
//assign a=r;        //using for led output
//assign b=s;
//assign c=clk;
//
//endmodule 









////////////////////////////////////////////////////////////////////////////////////////////////////////





//2a
//module lab7 (s,r,q,qbar,a,b); 
//input s,r;
//output q,qbar;
//
//output wire a,b;
//nor a1 (q,r,qbar);  //nor gate used for basic flip flop
//nor a2 (qbar,s,q);  //taking s and q as inputs and qbar is output
//
//assign a=r;         //assigning for leds
//assign b=s;
//
//
//endmodule 
//
////nand (q,s,qbar);   //nand bar used for same code that included nand instead of nor
////nand (qbar,r,q);

