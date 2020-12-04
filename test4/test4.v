// n shift register. 
// If dir = 0 shifting is to the left. 
module nshift(R,L,dir,w0,w1,clock,Q);
parameter n=4;
input [n-1:0]R;            //initial original n-bit value
input L,dir,w0,w1,clock;
output reg [n-1:0]Q;       //n-bit value after shifting
integer k;  					//iterator for loop

always @ (posedge clock)
	if(L)
		Q <= R;
	else
	begin
		if(dir)  //if shifting right
		begin
			for(k=0;k<n-1;k=k+1)
			Q[k] <= Q[k+1];   //right shift
			Q[n-1] <= w0;
		end
		else
		begin
			Q[0] <= w1;
			for(k=n-1;k>0;k=k-1)
				Q[k] <= Q[k-1]; //left shift
		end
	end
	
endmodule
