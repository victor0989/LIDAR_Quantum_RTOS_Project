module reg-template 
( 
input wire clk, reset, 
input wire en, 
5 
10 
I i 
I 
3 
input wire [7: 01 ql-next , q2-next , q3_next, 
output reg [7:01 ql-reg, q2-reg, q3-reg 
1; 
// register without reset 
............................................. 
// use nonblock assignment ( <= ) 
always Q(posedge clk) 
ql-reg <= ql-next; 
............................................. 
// register with asynchronozrs reset 
// use nonblock assignment ( <= ) 
always Q(posedge clk, posedge reset) 
if (reset) 
q2-reg <= 8'bO; 
else 
q2-reg <= q2-next; 
............................................. 
// register with enable and asynchronous reset 
............................................. 
473 
// use nonblock assignment ( <= )

always @(posedge clk, posedge reset) 
if (reset) 
q3-reg <= 8'bO; 
else if (en) 
q3-reg <= q3-next; 
endmodule
