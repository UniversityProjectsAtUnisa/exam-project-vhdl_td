--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:29:56 01/03/2019
-- Design Name:   
-- Module Name:   C:/Users/marco/Documents/XilinxProjects/porta/global_hard_tb.vhd
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
 
ENTITY global_hard_tb IS
END global_hard_tb;
 
ARCHITECTURE behavior OF global_hard_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT password
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         row : IN  std_logic_vector(3 downto 0);
         col : IN  std_logic_vector(2 downto 0);
         badge : IN  std_logic_vector(1 downto 0);
         stato_testbench : OUT  std_logic_vector(3 downto 0);
         contatore_testbench : OUT  std_logic_vector(1 downto 0);
         controllore_testbench : OUT  std_logic;
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
   signal stato_testbench : std_logic_vector(3 downto 0);
   signal contatore_testbench : std_logic_vector(1 downto 0);
   signal controllore_testbench : std_logic;
   signal porta_aperta : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	signal stato_precedente_testbench : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: password PORT MAP (
          clk => clk,
          rst => rst,
          row => row,
          col => col,
          badge => badge,
          stato_testbench => stato_testbench,
          contatore_testbench => contatore_testbench,
          controllore_testbench => controllore_testbench,
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
		
		rst<='1';
      wait for 10 ns;	
		rst<='0';
		
      wait for clk_period;

      -- insert stimulus here 

      wait;
   end process;
	
	CHEKOUTPUT: process (clk) -- controllo che le transizioni e le uscite siano corrette per tutti i casi
		begin 
		if(falling_edge(clk)) then
			stato_precedente_testbench <= stato_testbench;
			if porta_aperta='1' then
					if (stato_precedente_testbench = "1000" and stato_testbench = "1001") then
						report "Transizione SR4 -> SPA, porta aperta correttamente" severity note;
					elsif (stato_precedente_testbench = "1001" and stato_testbench = "1001") then
						report "Permanenza SPA -> SPA, porta aperta correttamente" severity note;
					else
						report "La porta si è aperta in seguito ad una transizione che non lo consentiva" severity error;
					end if;
			else
					if (stato_precedente_testbench = "1000" and stato_testbench = "1001") then
						report "Transizione SR4 -> SPA, la porta non si è aperta" severity error;
					elsif (stato_precedente_testbench = "1001" and stato_testbench = "1001") then
						report "Permanenza SPA -> SPA, la porta non è aperta" severity error;
					elsif (stato_precedente_testbench = "1001" and stato_testbench = "0000") then
						report "Transizione SPA -> S0, porta chiusa correttamente" severity note;
					end if;
			end if;
		end if;
	end process CHEKOUTPUT;

END;
