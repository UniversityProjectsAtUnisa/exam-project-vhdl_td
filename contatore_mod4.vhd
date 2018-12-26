----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:49:36 12/23/2018 
-- Design Name: 
-- Module Name:    contatore_mod4 - Behavioral 
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contatore_mod4 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (1 downto 0));
end contatore_mod4;

architecture Behavioral of contatore_mod4 is
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

