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
	 Generic (rowN1, rowN2, rowN3, rowN4 : in std_logic_vector (3 downto 0);
				colN1, colN2, colN3, colN4 : in std_logic_vector (2 downto 0));
    PORT(clk : IN  std_logic;
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
	
	-- Funzione che converte un std_logic_vector in una stringa
	function to_string (a: std_logic_vector) return string is
	variable b : string (1 to a'length) := (others => NUL);
	variable stri : integer := 1; 
		begin
		for i in a'range loop
			b(stri) := std_logic'image(a((i)))(2);
			stri := stri+1;
			end loop;
		return b;
   end function;
	
	signal stato_precedente_testbench : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: password 
	Generic map (rowN1 => "1000",
					 rowN2 => "1000",
					 rowN3 => "1000",
					 rowN4 => "1000",
					 colN1 =>  "100",
					 colN2 =>  "001",
					 colN3 =>  "001",
					 colN4 =>  "001")
	PORT MAP (
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
   end process stim_proc;
	
	--Lo scopo di questo processo è di registrare lo stato precedente per controllare che la transizione sia avvenuta con successo nelle condizioni corrette
	--La difficoltà nasce dal fatto che gli input e lo stato corrente non sono sempre sufficienti ad identificare univocamente lo stato di provenienza.
	--La valutazione del falling_edge garantisce che vi sia una certa distanza temporale (mezzo ciclo di clock) con la valutazione dello stato corrente successivo
	--Così che possano esserci momenti in cui lo stato corrente e il precedente non siano uguali.
--	getsprecedentstate: process(clk)
--	begin
--		if(falling_edge(clk)) then
--			stato_precedente_testbench <= stato_testbench;
--		end if;
--	end process getsprecedentstate;
	
	-- Secondo la struttura precedente, ad ogni rising_edge(clk) lo stato corrente e il precedente risultavano uguali
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
