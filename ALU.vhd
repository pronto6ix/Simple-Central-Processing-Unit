library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_unit is
port(Clk:in std_logic;
A,B : in unsigned(7 downto 0);
OP : in unsigned(7 downto 0);
Neg : out std_logic;
R1: out unsigned(3 downto 0);
R2: out unsigned(3 downto 0));
end ALU_unit;
architecture calculation of ALU_unit is
signal Reg1,Reg2,Result : unsigned(7 downto 0);
begin	
Reg1 <= A;
Reg2 <= B;
process(Clk,OP)
	begin	
	if(rising_edge(Clk)) THEN 
		case OP is
		   
			WHEN "00000001" => -- Addition for Reg1 and Reg2 
			Result <= Reg1 + Reg2;

			WHEN "00000010" => -- Subtraction, Neg bit if required
					if (Reg1 < Reg2) then
					Neg <= '1';
					Result <= (Reg2 - Reg1);
					else
					Neg <= '0';
					Result <= (Reg1 - Reg2);
					end if;
			WHEN "00000100" => -- Inverse of A
			Neg <= '0';
				Result <= NOT(Reg1);
										

			WHEN "00001000" => -- Boolean NAND gate
			Neg <= '0';
				Result <= (Reg1 NAND Reg2);

			WHEN "00010000" => -- Boolean NOR gate
			Neg <= '0';
				Result <= (Reg1 NOR Reg2);
	
			WHEN "00100000" => -- Boolean AND gate
			Neg <= '0';
				Result <= (Reg1 AND Reg2);
											

			WHEN "01000000" => -- Boolean XOR gate
			Neg <= '0';
				Result <= (Reg1 XOR Reg2);

			WHEN "10000000" => -- Boolean OR gate
			Result <= Reg1 OR Reg2;
				
			WHEN OTHERS => 				-- Don't care, do nothing			
			end case;
		end if;
	end process;
	
R1 <= Result(3 downto	 0); -- Since the output is 7 segments, but the result is 8-bits
R2 <= Result(7 downto 4); -- Split two of the output into two 4-bits 
end calculation;
