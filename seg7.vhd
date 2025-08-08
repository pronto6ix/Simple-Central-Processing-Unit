LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY seg7mod IS
PORT ( bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
leds1 : OUT STD_LOGIC_VECTOR(0 TO 6);
leds2 : OUT STD_LOGIC_VECTOR(0 TO 6);
sign : IN STD_LOGIC) ;

END seg7mod ;


ARCHITECTURE Behavior OF seg7mod IS
BEGIN

PROCESS (sign)
BEGIN
If(sign = '1') then
leds1<= "1111110";
Else
leds1 <= "1111111";
End if;
END process;

PROCESS (bcd)
BEGIN
CASE bcd IS -- abcdefg
WHEN "0000" =>leds2 <="1101010" ;
WHEN "0001" =>leds2 <="1000100" ;





WHEN OTHERS =>leds2 <="-------" ;
END CASE;
END PROCESS;
END Behavior;
