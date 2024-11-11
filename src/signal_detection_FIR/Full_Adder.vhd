library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           cout : out STD_LOGIC);
end Full_Adder;

architecture Behavioral of Full_Adder is
component HalfAdder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           s : out STD_LOGIC;
           c : out STD_LOGIC);
end component;
signal s1,c1,c2: std_logic;
begin
HA1: Halfadder port map (a,b,s1,c1);
HA2: Halfadder port map (s1,cin,sum,c2);
cout <= c1 or c2;


end Behavioral;
