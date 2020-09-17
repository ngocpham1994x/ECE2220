module lab01(x,y,f1,f2,f3);
	input x,y;
	output f1,f2,f3;
	
	and(f1,x,y);
	or(f2,x,y);
	xor(f3,x,y);
	
endmodule
