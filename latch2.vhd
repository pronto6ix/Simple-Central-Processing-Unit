LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY latch2 IS
	port ( B : in std_logic_vector(7 downto 0) ; -- 8-bit A input
		res, clk : in std_logic ;
			Q : out std_logic_vector(7 downto 0)); -- 8-bit output
end latch2;

architecture behavior of latch2 is
begin
	process (res, clk)
	begin
		if res = '1' then
			Q <= "00000000" ;
		elsif (clk'EVENT AND clk = '1') then
			Q <= B ;
		end if ;
	end process ;
end behavior ;
