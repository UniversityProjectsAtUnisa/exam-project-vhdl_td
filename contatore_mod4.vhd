----------------------------------------------------------------------------------
-- Create Date:    19:49:36 12/23/2018 
-- Module Name:    contatore_mod4 - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
----------------------------------------------------------------------------------

entity contatore_mod4 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (1 downto 0));
end contatore_mod4;

architecture Behavioral of contatore_mod4 is
--Dichiaro un segnale per utilizzare la retroazione evitando così di adottare 
--le simili, ma meno leggibili, funzioni di un segnale di tipo INOUT
signal counter_up : std_logic_vector(1 downto 0);

begin
process(clk,rst)
		begin
		if rising_edge(clk) then 
				if rst='1' then
					counter_up <= "00";
				else
					counter_up<=counter_up+"01";
				end if;
		end if;
end process;

count<=counter_up;

end Behavioral;

