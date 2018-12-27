--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:29:17 12/27/2018
-- Design Name:   
-- Module Name:   C:/Users/marco/Documents/XilinxProjects/porta/counter2_VHDL_tb.vhd
-- Project Name:  porta
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter2_VHDL
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
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 10 ns;	
		rst <= '0';
		En<='1';
		wait for 10 ns;
		En<='1';
		wait for 10 ns;
		En<='1';
		wait for 10 ns;
		En<='1';
		wait for 10 ns;
		En<='1';
		wait for 10 ns;
		En<='0';
		wait for 10 ns;
		En<='0';
		wait for 10 ns;
		En<='1';
		wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
