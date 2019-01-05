--------------------------------------------------------------------------------
-- Create Date:   17:29:56 01/03/2019
-- Module Name:   global_hard_tb.vhd
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
--------------------------------------------------------------------------------

ENTITY global_hard_tb IS
END global_hard_tb;
 
ARCHITECTURE behavior OF global_hard_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT password
	 Generic (rowN1, rowN2, rowN3, rowN4 : in std_logic_vector (3 downto 0);
			  colN1, colN2, colN3, colN4 : in std_logic_vector (2 downto 0));
    PORT(
         clk 	: IN  std_logic;
         rst 	: IN  std_logic;
         row 	: IN  std_logic_vector(3 downto 0);
         col 	: IN  std_logic_vector(2 downto 0);
         badge  : IN  std_logic_vector(1 downto 0);
		 stato_testbench : 			OUT  std_logic_vector(3 downto 0);
         contatore_testbench : 		OUT  std_logic_vector(1 downto 0);
         controllore_testbench : 	OUT  std_logic;
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
   uut: password 
			Generic map (rowN1 => "1000",
					 rowN2 => "1000",
					 rowN3 => "1000",
					 rowN4 => "1000",
					 colN1 =>  "001",
					 colN2 =>  "001",
					 colN3 =>  "001",
					 colN4 =>  "001")
			PORT MAP (
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
 

--Provo almeno una volta tutte le singole possibili transizioni tra stati dell'automa
   stim_proc: process
   begin		
	
		rst<='1';
		wait for 10 ns;	--Reset
		rst<='0';
		
		badge <= "00";		--Permanenza stato iniziale
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		badge <= "01";		--Passaggio Badge
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		badge <= "00";		--Attesa prima lettura
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
-------------------------------------------------		
		rst<='1';
		wait for 10 ns;	--Reset
		rst<='0';
		
		badge <= "01";		--Passaggio Badge
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		badge <= "00";		--Inserimento prima cifra
		row <= "1000";
		col <= "001";
		wait for 10 ns;
		
		row <= "1000";		--Attesa rilascio prima cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio prima cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Attesa seconda lettura
		col <= "010";
		wait for 10 ns;

-------------------------------------------------	

		rst<='1';
		wait for 10 ns;	--Reset
		rst<='0';
		
		badge <= "01";		--Passaggio Badge
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		badge <= "00";		--Inserimento prima cifra
		row <= "1000";
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio prima cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "1000";		--Inserimento seconda cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "1000";		--Attesa rilascio seconda cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio seconda cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0000";		--Attesa inserimento terza cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
-------------------------------------------------	
		
		rst<='1';
		wait for 10 ns;	--Reset
		rst<='0';
		
		badge <= "01";		--Passaggio Badge
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		badge <= "00";		--Inserimento prima cifra
		row <= "1000";
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio prima cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "1000";		--Inserimento seconda cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio seconda cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "1000";		--Inserimento terza cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "1000";		--Attesa rilascio terza cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio terza cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0000";		--Attesa inserimento quarta cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
-------------------------------------------------	
		
		rst<='1';
		wait for 10 ns;	--Reset
		rst<='0';
		
		badge <= "01";		--Passaggio Badge
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		badge <= "00";		--Inserimento prima cifra
		row <= "1000";
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio prima cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "1000";		--Inserimento seconda cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio seconda cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "1000";		--Inserimento terza cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio terza cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "1000";		--Inserimento quarta cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "1000";		--Attesa rilascio quarta cifra
		col <= "001";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio quarta cifra e
		col <= "000";		--Apertura porta
		wait for 10 ns;
		
		row <= "0000";		--Attesa chiusura porta
		col <= "000";
		wait for 10 ns;
		
		badge <= "10";		
		wait for 10 ns;	--Chiusura porta
		badge <="00";
			
-------------------------------------------------	
		
		rst <= '1';
		wait for 10 ns;	--Reset
		rst <= '0';
		
		badge <= "01";		--Passaggio Badge
		row <= "0000";
		col <= "000";
		wait for 10 ns;
		
		badge <= "00";		--Inserimento cifra errata
		row <= "0100";
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio prima cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata	
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio seconda cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio terza cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio quarta cifra
		col <= "000";
		wait for 10 ns;
	---------------- *PASSWORD ERRATA* -------------
	
	
	---------------- SECONDO TENTATIVO -------------
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio prima cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio seconda cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio terza cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio quarta cifra
		col <= "000";
		wait for 10 ns;
	---------------- PASSWORD ERRATA --------------
	
	
	---------------- TERZO TENTATIVO --------------
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio prima cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio seconda cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio terza cifra
		col <= "000";
		wait for 10 ns;
		
		row <= "0100";		--Inserimento cifra errata
		col <= "010";
		wait for 10 ns;
		
		row <= "0000";		--Rilascio quarta cifra e
		col <= "000";		--Ritorno allo stato iniziale
	-------------- **PASSWORD ERRATA** -------------
	
	
	-------------- TENTATIVI ESAURITI --------------
      wait;
   end process;
	
	CHEKOUTPUT: process (clk) 
	--Lo scopo di questo processo è di verificare che la porta si apra solo nei casi previsti.
	--Registrando lo stato precedente l'individuazione dell'transizione è univoca.
	--La difficoltà nasce dal fatto che gli input e lo stato corrente non siano sempre sufficienti ad identificare univocamente lo stato di provenienza.
	
	--La valutazione del falling_edge garantisce che vi sia una certa distanza temporale (mezzo ciclo di clock) con la valutazione dello stato corrente successivo
	--Così che possano esserci momenti in cui lo stato corrente e il precedente non siano uguali.
		begin 
		if falling_edge(clk) then
				stato_precedente_testbench <= stato_testbench;
				if porta_aperta='1' then
						if (stato_precedente_testbench = "1000" and stato_testbench = "1001") then
							report "Transizione SR4 -> SPA, porta aperta correttamente" severity note;
						elsif (stato_precedente_testbench = "1001" and stato_testbench = "1001") then
							report "Permanenza SPA -> SPA, porta aperta correttamente" severity note;
						else
								report "La porta si è aperta in seguito ad una transizione che non lo consentiva" severity ERROR;
						end if;
				else
						if (stato_precedente_testbench = "1000" and stato_testbench = "1001") then
							report "Transizione SR4 -> SPA, la porta non si è aperta" severity ERROR;
						elsif (stato_precedente_testbench = "1001" and stato_testbench = "1001") then
							report "Permanenza SPA -> SPA, la porta non è aperta" severity ERROR;
						elsif (stato_precedente_testbench = "1001" and stato_testbench = "0000") then
							report "Transizione SPA -> S0, porta chiusa correttamente" severity note;
						end if;
				end if;
		end if;
		
	end process CHEKOUTPUT;
END;
