----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:39:15 12/26/2018 
-- Design Name: 
-- Module Name:    counter2_VHDL - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter2_VHDL is
    Port ( En : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (0 to 1));
end counter2_VHDL;

architecture Behavioral of counter2_VHDL is
	signal temp: std_logic_vector(0 to 1);
begin
	process(clk)
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
	end process;
	O<=temp;
	
--https://en.wikibooks.org/wiki/VHDL_for_FPGA_Design/4-Bit_BCD_Counter_with_Clock_Enable
end Behavioral;

