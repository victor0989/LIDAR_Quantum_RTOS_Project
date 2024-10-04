module sm-add-test 
( 
input wire clk, 
input wire [1:0] btn, 
input wire [7:01 sw, 
output wire [3:01 an, 
output wire [7:01 sseg 
); 
// signal declaration 
wire 13: 01 sum, mout , oct ; 
wire C7: 01 led3, led2, ledl , led0 ; 
// instantiate adder 
sign-mag-add #( . N (4) ) sm-adder-unit 
(.a(sw[3:Ol>, .b(sw[7:41), 
// 
.sum(sum)); 
magnitude displayed on rightmost 7-seg LED 
assign mout = (btn==2'b00) ? sw [3:0] : 
(btn==2 ' b0l) ? sw [7:41 : 
sum ; 
assign oct = {l'bO, mout [2:01); 
// instantiate hex decoder 
hex-to-sseg sseg-unit 
(.hex(oct), .dp(lJbO), .sseg(ledO)); 
// sign displayed on 2nd 7-seg LED 
// middle LED bar on for negative number 
assign ledl = mout [3] ? 8'b11111110 : 8'bllllllll; 
// blank two other LEDs 
assign led2 = 8'bllllllll; 
assign led3 = 8'b11111111; 
73 
// instantiate 7-seg LED display time-multiplexing module 
disp-mux disp-unit 
(.clk(clk), .reset(iJbO), .inO(ledO), .inl(ledl), 
. in2 (led2), . in3 (led31, . an(an), . sseg(sseg)) ; 
endmodule 
