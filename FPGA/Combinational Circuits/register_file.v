module reg_file 
# ( parameter B = 8, // number of bits 
W = 2 
5 
1 
( 
// number of address bits 
input wire clk, 
input wire wr-en, 
input wire [W-1:OI w-addr, r-addr, 
input wire [B-1:Ol w-data, 
output wire [B-1:Ol r-data 
); 
15 
20 
// signal declaration 
reg [B-1:Ol array-reg [2**W-1:Ol ; 
// body 
// write operation 
always @(posedge clk) 
if (wr-en) 
array-reg [w-addr] <= w-data; 
// read operation 
assign r-data = array-reg [r-addrl ;
