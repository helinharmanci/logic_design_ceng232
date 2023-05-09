`timescale 1ns / 1ps

module ab(input A, input B, input clk, output reg Q);

    initial Q = 0;

    // You can implement your code here
    always@(posedge clk)
    begin
    	if (~A&&~B) Q<=Q;
    	else if (~A&&B) Q<=1;
    	else if (A&& ~B) Q<=0;
    	else Q<=~Q;
    end
    	

endmodule

module ic1337(input I0,input I1,input I2, input clk, output Q0, output Q1, output Z);

    // You can implement your code here
    // ...
    assign A1= (~(~I1 | I0) & ~I2);
    assign B1= I2;
    assign A0 = ~I2; 
    assign B0 = (~(~I1 | I2) ~^ I0);
    ab ab_1(A1,B1,clk, Q0);
    ab ab_0(A0,B0,clk, Q1);
    assign Z = (Q1 ^ Q0);	

endmodule