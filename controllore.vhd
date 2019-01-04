----------------------------------------------------------------------------------
-- Create Date:    16:31:02 12/21/2018 
-- Module Name:    controllore - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------

entity controllore is
    Port ( clk : in std_logic;
			  rst : in  STD_LOGIC; --usato come preset nel flip-flop
           I : in  STD_LOGIC;
           O : out  STD_LOGIC);
end controllore;

architecture Behavioral of controllore is
--Dichiaro un segnale per utilizzare la retroazione evitando così di adottare 
--le simili, ma meno leggibili, funzioni di un segnale di tipo INOUT
signal q: std_logic;

begin
sync_process: process(clk)
		begin
		if rising_edge(clk) then
				if rst='1' then
						q<='1';
				else
						q<=q and I;
				end if;
		end if;
end process sync_process;

O<=q;

end Behavioral;

