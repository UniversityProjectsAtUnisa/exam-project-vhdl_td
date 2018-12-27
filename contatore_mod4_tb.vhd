--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:56:35 12/27/2018
-- Design Name:   
-- Module Name:   C:/Users/marco/Documents/XilinxProjects/porta/contatore_mod4_tb.vhd
-- Project Name:  porta
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: contatore_mod4
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY contatore_mod4_tb IS
END contatore_mod4_tb;
 
ARCHITECTURE behavior OF contatore_mod4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contatore_mod4
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         count : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal count : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contatore_mod4 PORT MAP (
          clk => clk,
          rst => rst,
          count => count
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst<='1';
      wait for 100 ns;	
		rst<='0';
		

      -- insert stimulus here 

      wait;
   end process;

END;
