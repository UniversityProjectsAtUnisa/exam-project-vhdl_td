--------------------------------------------------------------------------------
-- Create Date:   16:32:00 01/05/2019
-- Module Name:   controllore_tb.vhd
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY controllore_tb IS
END controllore_tb;
 
ARCHITECTURE behavior OF controllore_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controllore
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         I : IN  std_logic;
         O : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal I : std_logic := '0';

 	--Outputs
   signal O : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controllore PORT MAP (
          clk => clk,
          rst => rst,
          I => I,
          O => O
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
	
	rst<='1';
	wait for 10 ns;	--alto
	
	I<='0';
	rst<='1';
	wait for 10 ns;	--alto
	
	I<='1';
	rst<='1';
	wait for 10 ns;	--alto
	
	I<='1';
	rst<='0';
	wait for 10 ns;	--alto
	
	I<='0';
	rst<='0';
	wait for 10 ns;	--basso
	
	I<='0';
	rst<='0';
	wait for 10 ns;	--basso
	
	I<='1';
	rst<='0';
	wait for 10 ns;	--basso
	
	I<='0';
	rst<='1';
	wait for 10 ns;	--alto
	
	I<='0';
	rst<='0';
	wait for 10 ns;	--basso
	
	I<='1';
	rst<='1';				
   wait;					--alto
	
   end process;

END;
