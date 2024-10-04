module hex-to-sseg 
( 
input wire [3:01 hex, 
input wire dp, 
output reg [7:0] sseg // output active low 
1; 
always Q* 
begin 
case (hex) 
4'hO: sseg [6: 01 = 7'b0000001; 
4'hl: sseg[6:0] = 7'b1001111; 
4'h2: sseg [6:0] = 7'b0010010; 
4'h3: sseg [6:01 = 7'b0000110; 
4'h4: sseg[6:0] = 7'b1001100; 
4'h5: sseg [6:0] = 7'b0100100; 
4'h6: sseg [6:01 = 7'b0100000; 
4'h7: sseg[6:0] = 7'bOOOlill; 
4'h8 : sseg C6: 01 = 7' b0000000 ; 
4'h9 : sseg [6: 01 = 7'b0000100 ; 
4'ha: sseg [6:01 = 7'b0001000; 
4'hb: sseg [6:0] = 7'b1100000; 
4'hc: sseg[6:0] = 7'b0110001; 
4'hd: sseg [6:01 = 7'blOOOOlO; 
4'he: sseg C6:Ol = 7'b0110000; 
default: sseg [6:01 = 7'b0111000; //4 'hf 
endcase 
sseg [71 = dp;
