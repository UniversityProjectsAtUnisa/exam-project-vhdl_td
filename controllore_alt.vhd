----------------------------------------------------------------------------------
-- Create Date:    16:31:02 12/21/2018 
-- Module Name:    controllore - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------

entity controllore_asincrono is
    Port ( rst : in  STD_LOGIC;
           I : in  STD_LOGIC;
           O : out  STD_LOGIC);
end controllore_asincrono;

architecture Behavioral of controllore_asincrono is
--Dichiaro un segnale per utilizzare la retroazione evitando così di adottare 
--le simili, ma meno leggibili, funzioni di un segnale di tipo INOUT
signal q: std_logic;

begin
q<=(q and I) or rst;
O<=q;

end Behavioral;

