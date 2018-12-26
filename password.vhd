----------------------------------------------------------------------------------
-- Create Date:    12:56:39 12/24/2018 
-- Module Name:    password - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------

entity password is
-- Generic (rowN1, rowN2, rowN3, rowN4 : in std_logic_vector; (3 downto 0);
--				colN1, colN2, colN3, colN4 : in std_logic_vector (2 downto 0));
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           row : in  STD_LOGIC_VECTOR (3 downto 0);
           col : in  STD_LOGIC_VECTOR (2 downto 0);
           badge : in  STD_LOGIC_VECTOR (1 downto 0);
					badge_bug : out std_logic;	--ALTO QUANDO badge="11"
           porta_aperta : out  STD_LOGIC);
end password;

--------------------------INIZIO DICHIARAZIONE ARCHITECTURE-----------------------
architecture Behavioral of password is

--INIZIO DICHIARAZIONE COMPONENTI--
--componente che ricorda 0 se la password inserita è sbagliata, 1 altrimenti.
component controllore is
    Port ( rst : in  STD_LOGIC;
           I : in  STD_LOGIC;
           O : out  STD_LOGIC);
end component;

--componente che conta i tentativi di inserimento disponibili.
component accumulatore_mod3 is
    Port ( En : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (1 downto 0));
end component;
--FINE DICHIARAZIONE COMPONENTI--


--dichiarazione segnali controllore
signal rst_controllore : std_logic;
signal inserimento_corretto : std_logic;
signal password_corretta : std_logic;

--dichiarazione segnali accumulatore_mod3
signal prossimo_tentativo: std_logic;
--			*clk*
signal rst_tentativi: std_logic;
signal tentativo_corrente: std_logic_vector (1 downto 0);


-- dichiarazione 10 stati e segnali di stato
type state is (stato_iniziale, 
stato_lettura1, stato_attesa_rilascio1, 
stato_lettura2, stato_attesa_rilascio2, 
stato_lettura3, stato_attesa_rilascio3, 
stato_lettura4, stato_attesa_rilascio4, 
stato_porta_aperta);
signal current_state, next_state : state;

----------------------*****************-------------------------
----------------------Temporary section-------------------------
constant rowN1:  std_logic_vector (3 downto 0) := "0001";
constant rowN2:  std_logic_vector (3 downto 0) := "0001";
constant rowN3:  std_logic_vector (3 downto 0) := "0001";
constant rowN4:  std_logic_vector (3 downto 0) := "0001";
constant	colN1:  std_logic_vector (2 downto 0) :=  "001";
constant colN2:  std_logic_vector (2 downto 0) :=  "001";
constant colN3:  std_logic_vector (2 downto 0) :=  "001";
constant colN4:  std_logic_vector (2 downto 0) :=  "001";
----------------------------------------------------------------
----------------------*****************-------------------------

begin
--PORT MAPPING
	controllore_inserimento: controllore port map(rst_controllore, inserimento_corretto, password_corretta);
	contatore_tentativi: accumulatore_mod3 port map (prossimo_tentativo, clk, rst_tentativi, tentativo_corrente);


--Processo sincrono che valuta a tempo di clock il nuovo stato, sulla base del reset e dei processi concorrenti.
	Sync_process: process(clk, rst)
		begin
			if rising_edge(clk) then
					if rst='1' then current_state<=stato_iniziale;
					else				 current_state<=next_state;
					end if;
			end if;
		end process;
----------------------*****************-------------------------

--Processo asincrono che valuta i passaggi di stato e le uscite in una struttura automatica di tipo Mealy
	State_Transition_and_output: process (current_state, row, col, badge)
			begin
---------Inizio struttura case-when--------------------------------------------------------------------------------------
			case current_state is
				when stato_iniziale =>					if badge="11" then --caso di errore, inserire assert(?).
																			--In questo caso non era necessario,
																			--ma credo che aumenti la leggibilità.
																			next_state		<=	stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																		
																elsif badge="01" then
																			next_state		<=stato_lettura1; 
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																else
																			next_state		<=stato_iniziale;
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																end if;
-------------------------------------------------------------------------------------------------------------------------												
				when stato_lettura1 =>					if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																		
																elsif row = "0000" and col = "000" then 
																			next_state		<=stato_lettura1;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = rowN1  and col = colN1 then
																			next_state		<=stato_attesa_rilascio1;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																else
																			next_state		<=stato_attesa_rilascio1;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_attesa_rilascio1 =>		if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																			
																elsif	row = rowN1  and col = colN1 then
																			next_state		<=stato_attesa_rilascio1;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = "0000" and col = "000" then 
																			next_state		<=stato_lettura2;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																else
																			next_state		<=stato_attesa_rilascio1;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_lettura2 =>					if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																		
																elsif row = "0000" and col = "000" then 
																			next_state		<=stato_lettura2;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = rowN2  and col = colN2 then
																			next_state		<=stato_attesa_rilascio2;
																			porta_aperta	<='0';
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																else
																			next_state		<=stato_attesa_rilascio2;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_attesa_rilascio2 =>		if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																			
																elsif	row = rowN2  and col = colN2 then
																			next_state		<=stato_attesa_rilascio2;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = "0000" and col = "000" then 
																			next_state		<=stato_lettura3;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																else
																			next_state		<=stato_attesa_rilascio2;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_lettura3 =>					if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																		
																elsif row = "0000" and col = "000" then 
																			next_state		<=stato_lettura3;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = rowN3  and col = colN3 then
																			next_state		<=stato_attesa_rilascio3;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																else
																			next_state		<=stato_attesa_rilascio3;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_attesa_rilascio3 =>		if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																			
																elsif	row = rowN3  and col = colN3 then
																			next_state		<=stato_attesa_rilascio3;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = "0000" and col = "000" then 
																			next_state		<=stato_lettura4;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																else
																			next_state		<=stato_attesa_rilascio3;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_lettura4 =>					if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																		
																elsif row = "0000" and col = "000" then 
																			next_state		<=stato_lettura4;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = rowN4  and col = colN4 then
																			next_state		<=stato_attesa_rilascio4;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																else
																			next_state		<=stato_attesa_rilascio4;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_attesa_rilascio4 =>		if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																			
																elsif	row = rowN4  and col = colN4 then
																			next_state		<=stato_attesa_rilascio4;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='1';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																elsif row = "0000" and col = "000" then
																			if password_corretta = '0' and tentativo_corrente(1)='0' then 
																						next_state		<=stato_lettura1;
																						porta_aperta	<='0'; 
																						inserimento_corretto<='0';	rst_controllore<='1'; 
																						prossimo_tentativo  <='1';	rst_tentativi	<='0';
																		elsif password_corretta = '0' and tentativo_corrente="10" then 
																						next_state		<=stato_iniziale;
																						porta_aperta	<='0'; 
																						inserimento_corretto<='0';	rst_controllore<='1'; 
																						prossimo_tentativo  <='0';	rst_tentativi	<='1';
																		elsif password_corretta = '1' then
																						next_state		<=stato_porta_aperta;
																						porta_aperta	<='1'; 
																						inserimento_corretto<='0';	rst_controllore<='1'; 
																						prossimo_tentativo  <='0';	rst_tentativi	<='1';
																		else
																						next_state		<=stato_attesa_rilascio4;
																						porta_aperta	<='0'; 
																						inserimento_corretto<='0';	rst_controllore<='0'; 
																						prossimo_tentativo  <='0';	rst_tentativi	<='0';
																			end if;
																			
																else
																			next_state		<=stato_attesa_rilascio4;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='0'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='0';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				when stato_porta_aperta =>				if badge="11" then --caso di errore, inserire assert
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																			
																elsif badge="10" then
																			next_state		<=stato_iniziale;
																			porta_aperta	<='0'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																else
																			next_state		<=stato_porta_aperta;
																			porta_aperta	<='1'; 
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																end if;
-------------------------------------------------------------------------------------------------------------------------
				end case;
---------Fine struttura case-when----------------------------------------------------------------------------------------
	end process;


		--uscita badge_bug
		badge_bug<=badge(1) and badge(0);
end Behavioral;

