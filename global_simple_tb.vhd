--------------------------------------------------------------------------------
-- Create Date:   15:50:25 12/28/2018
-- Module Name:   global_simple_tb.vhd
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------------------
 
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
	
	--Dichiarazione di un segnale per memorizzare lo stato precedente
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
	
	
--------------------------------------------- Apertura in un tentativo --------------------------------------------
		rst<='1';
      wait for 10 ns;	--Reset
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	--Passaggio badge
		badge<="00";
		
		row<="1000";
		col<="001";
		wait for 10 ns;	--Prima cifra corretta	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 		
		col<="001";
		wait for 10 ns;	--Terza cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta
		row<="0000";
		col<="000";
		wait for 50 ns;	--Apertura porta	
		
		badge<="10";		
		wait for 10 ns;	--Chiusura porta
		badge<="00";
----------------------------------------------*************************--------------------------------------------
		
		
--------------------------------------------- Apertura in due tentativi -------------------------------------------
		rst<='1';
      wait for 10 ns;	--Reset
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	--Passaggio Badge
		badge<="00";
		
		row<="1000";
		col<="001";
		wait for 10 ns;	--Prima cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001";
		col<="001";
		wait for 10 ns;	--Terza cifra errata	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000";
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
	---------------- *PASSWORD ERRATA* -------------
	
	
	---------------- SECONDO TENTATIVO -------------
      row<="1000"; 
		col<="001";
		wait for 10 ns;	--Prima cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Terza cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta
		row<="0000";
		col<="000";
		wait for 50 ns;	--Apertura porta	
		
		badge<="10";
		wait for 10 ns;	--Chiusura porta	
		badge<="00";
----------------------------------------------*************************--------------------------------------------
		
		
--------------------------------------------- Apertura in tre tentativi -------------------------------------------
		rst<='1';
      wait for 10 ns;	--Reset
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	--Passaggio Badge
		badge<="00";
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Prima cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; 
		col<="001";
		wait for 10 ns;	--Terza cifra errata
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
	---------------- *PASSWORD ERRATA* -------------
	
	
	---------------- SECONDO TENTATIVO -------------
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Prima cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; 
		col<="001";
		wait for 10 ns;	--Terza cifra errata
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
	---------------- PASSWORD ERRATA --------------
	
	
	---------------- TERZO TENTATIVO --------------
      row<="1000"; 
		col<="001";
		wait for 10 ns;	--Prima cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Terza cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta
		row<="0000";
		col<="000";
		wait for 50 ns;	--Apertura porta
		
		badge<="10";
		wait for 10 ns;	--Chiusura porta
		badge<="00";
------------------------------------------------ ********************* --------------------------------------------
		
		
------------------------------------------------ Tre tentativi Falliti --------------------------------------------
		rst<='1';
      wait for 10 ns;	--Reset
		rst<='0';
		
		badge<="01";
		wait for 10 ns;	--Passaggio badge
		badge<="00";
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Prima cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; 
		col<="001";
		wait for 10 ns;	--Terza cifra errata	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta	
		row<="0000";
		col<="000";
		wait for 10 ns;
	---------------- *PASSWORD ERRATA* -------------
	
	
	---------------- SECONDO TENTATIVO -------------
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Prima cifra corretta	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; 
		col<="001";
		wait for 10 ns;	--Terza cifra errata	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta	
		row<="0000";
		col<="000";
		wait for 10 ns;
	---------------- PASSWORD ERRATA --------------
	
	
	---------------- TERZO TENTATIVO --------------
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Prima cifra corretta	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Seconda cifra corretta	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="0001"; 
		col<="001";
		wait for 10 ns;	--Terza cifra errata	
		row<="0000";
		col<="000";
		wait for 10 ns;
		
		row<="1000"; 
		col<="001";
		wait for 10 ns;	--Quarta cifra corretta e
		row<="0000";		--Ritorno allo stato iniziale
		col<="000";			
	-------------- **PASSWORD ERRATA** -------------
	
	
	-------------- TENTATIVI ESAURITI --------------
      wait;
   end process stim_proc;
	
	
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
