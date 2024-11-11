library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIR_PulseDetector is
    Port ( a    : in  STD_LOGIC;                -- Entrada del filtro FIR
           b    : in  STD_LOGIC;                -- Entrada adicional
           cin  : in  STD_LOGIC;                -- Entrada de acarreo (cin)
           cout : out STD_LOGIC;                -- Salida de acarreo (cout)
           pulse_detected : out STD_LOGIC;       -- Detecta si el pulso se ha producido
           pulse_event : out STD_LOGIC           -- Evento inusual en el patrón temporal
           );
end FIR_PulseDetector;

architecture Behavioral of FIR_PulseDetector is
    -- Declaración de registros o señales internas para el filtro FIR
    signal shift_reg : std_logic_vector(2 downto 0);  -- Registro de desplazamiento (3 bits)
    signal sum_int   : std_logic;  -- Señal interna para la suma (anteriormente 'sum')
    signal pulse_count   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  -- Contador de tiempo entre pulsos
    signal pulse_last    : STD_LOGIC := '0';  -- Último valor de la señal de pulso
    signal pulse_event_internal : STD_LOGIC := '0';  -- Indicador interno de evento inusual
    signal time_between_pulses : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  -- Tiempo entre pulsos
    
    constant TIME_THRESHOLD : STD_LOGIC_VECTOR(15 downto 0) := "1000000000000000"; -- Umbral para el tiempo entre pulsos (en ciclos de reloj)
    
    -- Coeficientes de ejemplo para el FIR (puedes ajustarlos según tu diseño)
    signal coeff : std_logic_vector(2 downto 0);  -- Coeficientes del filtro FIR
begin
    coeff <= "001";  -- Ejemplo de coeficientes para FIR (ajústalos según tu diseño)

    -- Filtro FIR y detección de pulsos con temporización
    process(a, b, cin)
    begin
        -- Desplazar el registro y cargar el nuevo valor
        shift_reg <= shift_reg(1 downto 0) & a;

        -- Realizar la suma de acuerdo a los coeficientes
        sum_int <= (shift_reg(0) and coeff(0)) or (shift_reg(1) and coeff(1)) or (shift_reg(2) and coeff(2));

        -- Asignar la salida 'cout' con la señal interna 'sum_int'
        cout <= sum_int;

        -- Detectar el flanco de subida del pulso
        if (a = '1' and pulse_last = '0') then
            pulse_detected <= '1';  -- Señal de pulso detectado
            time_between_pulses <= pulse_count;  -- Guardar el tiempo entre pulsos
            pulse_count <= (others => '0');  -- Reseteamos el contador de tiempo después de un pulso
        else
            pulse_detected <= '0';  -- No se ha detectado pulso
            pulse_count <= pulse_count + 1;  -- Contamos el tiempo entre pulsos
        end if;

        -- Actualizamos el último valor de la señal 'a' para detectar el flanco de subida
        pulse_last <= a;
    end process;

    -- Detección de variaciones inusuales en el patrón temporal
    process(time_between_pulses)
    begin
        if time_between_pulses > TIME_THRESHOLD then
            pulse_event_internal <= '1';  -- Evento inusual (pulsos demasiado espaciados)
        else
            pulse_event_internal <= '0';  -- No es un evento inusual
        end if;
    end process;

    -- Asignar el evento de variación inusual a la salida
    pulse_event <= pulse_event_internal;

end Behavioral;

