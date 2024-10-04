if (mag-a > mag-b) 
begin 
max = mag-a; 
min = mag-b; 
sign-sum = sign-a; 
end 
else 
begin 
max = mag-b; 
min = mag-a; 
sign-sum = sign-b; 
end 
// add/sub magnitude 
if (sign-a==sign-b) 
mag-sum = max + min; 
e 1 s e 
mag-sum = max - min; 
// form output 
sum = (sign-sum, mag-sum); 
end 
endmodule 
