----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:02 12/21/2018 
-- Design Name: 
-- Module Name:    controllore - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controllore is	-- considera se farlo sincrono
    Port ( clk : in std_logic;
			  rst : in  STD_LOGIC; --usato come preset nel flip-flop
           I : in  STD_LOGIC;
           O : out  STD_LOGIC);
end controllore;

architecture Behavioral of controllore is
--Dichiaro segnale per utilizzare la retroazione
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

