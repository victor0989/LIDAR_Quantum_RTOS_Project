module barrel_shifter_stage 
( 
input wire [7:01 a, 
input wire [2:01 amt, 
output wire [7:0] y 
); 
// signal declaration 
wire [7:01 SO, sl; 
// body 
// stage 0, shift 0 or 1 bit 
assign SO = amt [O] ? Ca[O], a[7:1]) : a; 
// stage 1, shift 0 or 2 bits 
assign sl = amt [ll ? CsO[l:O] , sO[7:211 : SO; 
// stage 2, shift 0 or 4 bits 
assign y = amt [2] ? {s1[3:01, sl[7:41) : sl; 
endmodule
