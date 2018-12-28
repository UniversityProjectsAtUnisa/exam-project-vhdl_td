--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:50:25 12/28/2018
-- Design Name:   
-- Module Name:   C:/Users/marco/Documents/XilinxProjects/porta/global_simple_tb.vhd
-- Project Name:  porta
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: password
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
 
ENTITY global_simple_tb IS
END global_simple_tb;
 
ARCHITECTURE behavior OF global_simple_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT password
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         row : IN  std_logic_vector(3 downto 0);
         col : IN  std_logic_vector(2 downto 0);
         badge : IN  std_logic_vector(1 downto 0);
					stato_testbench : out std_logic_vector(3 downto 0); --Vale il numero relativo allo stato
					contatore_testbench : out std_logic_vector(1 downto 0); --Vale quanto tentativo_corrente 
					controllore_testbench : out std_logic;
         porta_aperta : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal row : std_logic_vector(3 downto 0) := (others => '0');
   signal col : std_logic_vector(2 downto 0) := (others => '0');
   signal badge : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal porta_aperta : std_logic;
	signal stato_testbench : std_logic_vector(3 downto 0); --Vale il numero relativo allo stato
	signal contatore_testbench : std_logic_vector(1 downto 0); --Vale quanto tentativo_corrente 
	signal controllore_testbench : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: password PORT MAP (
          clk => clk,
          rst => rst,
          row => row,
          col => col,
          badge => badge,
			 stato_testbench=>stato_testbench,
			 contatore_testbench=>contatore_testbench,
			 controllore_testbench=>controllore_testbench,
          porta_aperta => porta_aperta
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
		-- Apertura in un tentativo
		rst<='1';
      wait for 10 ns;	
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	
		badge<="00";
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 50 ns;
		
		badge<="10";
		wait for 10 ns;
----------------------------------------------**************************--------------------------------------------		
		-- Apertura in due tentativi
		rst<='1';
      wait for 10 ns;	
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	
		badge<="00";
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; --sbagliato
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		-----------------SECONDO TENTATIVO----------------
		
      row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 50 ns;
		
		badge<="10";
		wait for 10 ns;
------------------------------------******************************--------------------------------------		
		--Apertura in tre tentativi
		rst<='1';
      wait for 10 ns;	
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	
		badge<="00";
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; --sbagliato
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		-----------------SECONDO TENTATIVO----------------
		
		
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; --sbagliato
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		-----------------TERZO TENTATIVO-------------------
		
      row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 50 ns;
		
		badge<="10";
		wait for 10 ns;
		
---------------------------------------******************************---------------------------------------
		--Tre tentativi falliti
		rst<='1';
      wait for 10 ns;	
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	
		badge<="00";
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; --sbagliato
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		-----------------SECONDO TENTATIVO----------------
		
		
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; --sbagliato
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		-----------------TERZO TENTATIVO----------------
		
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; --sbagliato
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; --giusto
		col<="001";
		wait for 10 ns;	
		row<="0000";
		col<="000";
		wait for 50 ns;

      wait;
   end process;

END;
