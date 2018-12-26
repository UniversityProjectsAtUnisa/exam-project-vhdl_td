--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:20:30 12/23/2018
-- Design Name:   
-- Module Name:   C:/Users/marco/Documents/XilinxProjects/porta/controllore_tb.vhd
-- Project Name:  porta
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controllore
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
 
ENTITY controllore_tb IS
END controllore_tb;
 
ARCHITECTURE behavior OF controllore_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controllore
    PORT(
         rst : IN  std_logic;
         I : IN  std_logic;
         O : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal I : std_logic := '0';

 	--Outputs
   signal O : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controllore PORT MAP (
          rst => rst,
          I => I,
          O => O
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
	rst<='1';
	wait for 10 ns;
	I<='0';
	rst<='1';
	wait for 10 ns;
	I<='1';
	rst<='1';
	wait for 10 ns;
	I<='1';
	rst<='0';
	wait for 10 ns;
	I<='0';
	rst<='0';
	wait for 10 ns;
	I<='0';
	rst<='0';
	wait for 10 ns;
	I<='1';
	rst<='0';
	wait for 10 ns;
	I<='0';
	rst<='1';
	wait for 10 ns;
	I<='0';
	rst<='0';
	wait for 10 ns;
	I<='1';
	rst<='1';
	
--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
