library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU2 is
port(Clk:in std_logic;
A,B : in unsigned(7 downto 0);
OP : in unsigned(7 downto 0);
neg : out std_logic;
R1: out unsigned(3 downto 0);
R2: out unsigned(3 downto 0));
end ALU2;
architecture calculation of ALU2 is
signal Reg1,Reg2,Result : unsigned(7 downto 0);
begin	

process(Clk,OP)
	begin	
	if(rising_edge(Clk)) THEN 
	Reg1 <= A;
	Reg2 <= B;
		case OP is
		   	when "00000001" =>
					Result <= "11" & Reg1(7 downto 2);  -- Ensure correct type for 1
				-- Shift A right by two bits, input bit = 1
				when "00000010" =>
					if (Reg1 < Reg2) then
					neg <= '1';
					Result <= (Reg2 - Reg1);
					else
					neg <= '0';
					Result <= (Reg1 - Reg2);
					end if;

					Result <= Result + to_unsigned(4, 8);  -- Convert 4 to unsigned
					-- Find the difference between A and B and add 4
				when "00000100" =>
				neg <= '0';
					if Reg1 > Reg2 then
						Result <= Reg1;
					else
						Result <= Reg2;
					end if;
				-- Find the greater of A and B and output the result
				when "00001000" =>
				neg <= '0';
					Result <= Reg2(3 downto 0) & Reg1(3 downto 0);
					Reg1 <= Reg2(3 downto 0) & Reg1(3 downto 0);
					Reg2 <= Reg2(7 downto 4) & Reg1(7 downto 4);
				-- Swap the four upper bits of A with the four lower bits of B
				when "00010000" =>
				neg <= '0';
					Result <= Reg1 + to_unsigned(1, 8);  -- Increment A by 1
				when "00100000" =>
				neg <= '0';
					Result <= Reg1 AND Reg2;
				-- Do Boolean AND
				when "01000000" =>
				neg <= '0';
					Result <= not(Reg1(7 downto 4)) & Reg1(3 downto 0);
				-- Invert the four upper bits of A
				when "10000000" =>
				neg <= '0';
					Result <= Reg2(2 downto 0) & Reg2(7 downto 3);
				-- Rotate B to the left by 3 bits
				when others =>
					Result <= (others => '0');
				-- Don’t care, do nothing
		
			end case;
		end if;
	end process;
	
R1 <= Result(3 downto 0); -- Since the output is 7 segments, but the result is 8-bits
R2 <= Result(7 downto 4); -- Split two of the output into two 4-bits 
end calculation;
