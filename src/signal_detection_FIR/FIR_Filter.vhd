library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIR_Filter is
    Port ( a    : in  STD_LOGIC;
           b    : in  STD_LOGIC;
           cin  : in  STD_LOGIC;
           cout : out STD_LOGIC );
end FIR_Filter;

architecture Behavioral of FIR_Filter is
    -- Declaración de registros o señales internas para el filtro FIR
    signal shift_reg : std_logic_vector(2 downto 0); -- 3 bits para almacenar valores
    signal sum_int   : std_logic; -- Señal interna para la suma (anteriormente 'sum')

    -- Coeficientes de ejemplo para el FIR (puedes ajustarlos según tu diseño)
    signal coeff : std_logic_vector(2 downto 0); -- Coeficientes del filtro
begin
    coeff <= "001"; -- Ejemplo de coeficientes

    process(a, b, cin)
    begin
        -- Realizando el cálculo FIR simple
        shift_reg <= shift_reg(1 downto 0) & a; -- Desplazar el registro y cargar el nuevo valor
        
        -- Sumar según coeficientes
        sum_int <= (shift_reg(0) and coeff(0)) or (shift_reg(1) and coeff(1)) or (shift_reg(2) and coeff(2));
        
        -- Asignar la salida 'cout' con la señal interna 'sum_int'
        cout <= sum_int; -- Esto ahora está bien porque 'sum_int' es una señal interna
    end process;

end Behavioral;

