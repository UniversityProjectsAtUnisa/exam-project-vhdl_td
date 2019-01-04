----------------------------------------------------------------------------------
-- Create Date:    21:39:15 12/26/2018 
-- Module Name:    counter2_VHDL - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
----------------------------------------------------------------------------------

--Source:
--	https://en.wikibooks.org/wiki/VHDL_for_FPGA_Design/4-Bit_BCD_Counter_with_Clock_Enable

entity counter2_VHDL is
    Port ( En : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (0 to 1));
end counter2_VHDL;

architecture Behavioral of counter2_VHDL is
--Dichiaro un segnale per utilizzare la retroazione evitando così di adottare 
--le simili, ma meno leggibili, funzioni di un segnale di tipo INOUT
signal temp: std_logic_vector(0 to 1);

begin
sync_process: process(clk)
		begin
		if rising_edge(clk) then
				if rst='1' then
					temp<="00";
				elsif En='1' then
						if temp="10" then
								temp<="00";
						else
								temp <= temp + 1;
						end if;
				end if;
		end if;
end process sync_process;

O<=temp;

end Behavioral;

