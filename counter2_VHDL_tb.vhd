--------------------------------------------------------------------------------
-- Create Date:   17:29:17 12/27/2018
-- Module Name:   C:/Users/marco/Documents/XilinxProjects/porta/counter2_VHDL_tb.vhd
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counter2_VHDL_tb IS
END counter2_VHDL_tb;
 
ARCHITECTURE behavior OF counter2_VHDL_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter2_VHDL
    PORT(
         En : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         O : OUT  std_logic_vector(0 to 1)
        );
    END COMPONENT;
    

   --Inputs
   signal En : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal O : std_logic_vector(0 to 1);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter2_VHDL PORT MAP (
          En => En,
          clk => clk,
          rst => rst,
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
	
		rst <= '1';
      wait for 10 ns;	--00
		
		rst <= '0';
		En<='1';
		wait for 10 ns;	--01
		
		En<='1';
		wait for 10 ns;	--10	
		
		En<='1';
		wait for 10 ns;	--00
		
		En<='1';
		wait for 10 ns;	--01
		
		En<='1';
		wait for 10 ns;	--10
		
		En<='0';
		wait for 10 ns;	--10
		
		En<='0';
		wait for 10 ns;	--10
		
		En<='1';
		wait for 10 ns;	--00

      wait;
   end process;

END;
