--------------------------------------------------------------------------------
-- Create Date:   19:20:30 12/23/2018
-- Module Name:   C:/Users/marco/Documents/XilinxProjects/porta/controllore_tb.vhd
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------------------
 
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

      -- insert stimulus here 

      wait;
   end process;

END;
