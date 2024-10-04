module hex-to-sseg-test 
( 
input wire clk, 
input wire [7:01 sw, 
output wire C3:Ol an, 
output wire C7:Ol sseg 
1; 
// signal declaration 
wire [7:01 inc; 
wire [7: 01 led0 , led1 , led2, led3 ; 
// increment input 
assign inc = sw + 1; 
// instantiate four instances of hex decoders 
// instance for 4 LSBs of input 
hex-to-sseg sseg-unit-0 
(.hex(sw[3:0]), 
.dp(lJbO), .sseg(ledO)); 
// instance for 4 MSBs of input 
hex-to-sseg sseg-unit-I 
(.hex(sw[7:41), .dp(lJbO), .sseg(ledl)); 
// instance for 4 LSBs of incrernented value 
hex-to-sseg sseg-unit-2 
(.hex(inc[3:0]), 
.dp(l'bl), .sseg(led2)); 
// instance for 4 MSBs of incrernented value 
hex-to-sseg sseg-unit-3 
(.hex(inc[7:4]), 
.dp(l'bl), .sseg(led3)); 
// instantiate 7-seg LED display time-multiplexing module 
disp-mux disp-unit
