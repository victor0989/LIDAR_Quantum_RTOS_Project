module compare_no_defult 
( 
input wire a, b, 
output reg gt, eq 
1; 
// - use @* to include all inputs in sensitivity list 
// - else branch cannot be omitted 
// - all outputs must be assigned in all branches 
always O* 
if (a > b) 
begin 
gt = l'bl; 
eq = lJbO; 
end 
else if (a == b) 
begin 
gt = lJbO; 
eq = l'bl; 
end 
else 
// else branch cannot be omitted 
begin 
gt = lJbO; 
eq = lJbO; 
end 
endmodule
