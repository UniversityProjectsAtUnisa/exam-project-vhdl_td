----------------------------------------------------------------------------------
-- Create Date:    12:56:39 12/24/2018 
-- Module Name:    password - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
----------------------------------------------------------------------------------

entity password is
 Generic (  rowN1, rowN2, rowN3, rowN4 : in std_logic_vector (3 downto 0);
				colN1, colN2, colN3, colN4 : in std_logic_vector (2 downto 0));
    Port ( clk :   in  STD_LOGIC;
           rst :   in  STD_LOGIC;
           row :   in  STD_LOGIC_VECTOR (3 downto 0);
           col :   in  STD_LOGIC_VECTOR (2 downto 0);
           badge : in  STD_LOGIC_VECTOR (1 downto 0);
					----------------------------------------------------------------------------------------------
					stato_testbench : 		out std_logic_vector(3 downto 0); --Vale il numero relativo allo stato
					contatore_testbench : 	out std_logic_vector(1 downto 0); --Vale quanto tentativo_corrente 
					controllore_testbench : out std_logic;
					----------------------------------------------------------------------------------------------
           porta_aperta : out  STD_LOGIC);
end password;

--------------------------INIZIO DICHIARAZIONE ARCHITECTURE-----------------------
architecture Behavioral of password is

--INIZIO DICHIARAZIONE COMPONENTI--
--Componente che ricorda 0 se la password inserita è sbagliata, 1 altrimenti.
component controllore is
    Port ( clk: 	in   STD_LOGIC;
			  rst :  in   STD_LOGIC;
           I : 	in   STD_LOGIC;
           O : 	out  STD_LOGIC);
end component;

--Componente che conta istante per istante 
--quanti tentativi di inserimento della password sono falliti consecutivamente.
component counter2_VHDL is
    Port ( En :  in   STD_LOGIC;
           clk : in   STD_LOGIC;
           rst : in   STD_LOGIC;
           O :   out  STD_LOGIC_VECTOR (1 downto 0));
end component;
--FINE DICHIARAZIONE COMPONENTI--


--dichiarazione segnali controllore
--       *clk*
signal rst_controllore : 		std_logic;
signal inserimento_corretto : std_logic;
signal password_corretta : 	std_logic;

--dichiarazione segnali counter2_VHDL
signal prossimo_tentativo: 	std_logic;
--			*clk*
signal rst_tentativi: 			std_logic;
signal tentativo_corrente: 	std_logic_vector (1 downto 0);


--dichiarazione 10 stati come da diagramma di flusso
type state is ( stato_iniziale, 
stato_lettura1, stato_attesa_rilascio1, 
stato_lettura2, stato_attesa_rilascio2, 
stato_lettura3, stato_attesa_rilascio3, 
stato_lettura4, stato_attesa_rilascio4, 
stato_porta_aperta);

--dichiarazione segnali di stato
signal current_state, next_state : state;

--dichiarazione segnale di bug
signal bug : std_logic := '0'; --ALTO QUANDO badge="11" O tentativo_corrente="11" O non vi sono intersezioni tra righe e colonne


----------------------*****************-------------------------
----------------------Temporary section-------------------------
--constant rowN1:  std_logic_vector (3 downto 0) := "1000";
--constant colN1:  std_logic_vector (2 downto 0) :=  "001";
--constant rowN2:  std_logic_vector (3 downto 0) := "1000";
--constant colN2:  std_logic_vector (2 downto 0) :=  "001";
--constant rowN3:  std_logic_vector (3 downto 0) := "1000";
--constant colN3:  std_logic_vector (2 downto 0) :=  "001";
--constant rowN4:  std_logic_vector (3 downto 0) := "1000";
--constant colN4:  std_logic_vector (2 downto 0) :=  "001";
----------------------------------------------------------------
----------------------*****************-------------------------

begin
--PORT MAPPING
	controllore_inserimento: controllore 	port map(clk, rst_controllore, inserimento_corretto, password_corretta);
	
	contatore_tentativi:   	 counter2_VHDL port map(prossimo_tentativo, clk, rst_tentativi, tentativo_corrente);

-----------------********************-----------------------
-----------------Gestione casi di bug-----------------------
	bug_process: process(badge, tentativo_corrente, row, col)
		begin
------------------Errore di badge---------------------------
		if badge="11" then	
				bug<='1';
------------------Errore di contatore-----------------------
		elsif tentativo_corrente="11" then	
				bug<='1';
------------------Errore di tastierino----------------------
		elsif row="0000" xor col="000" then	
				bug<='1';
		else 	bug<='0';
		end if;
	end process;
-----------------**************************-----------------
	
--Processo sincrono che gestisce l'assegnamento temporizzato di ogni stato.
	Sync_process: process(clk)
		begin
			if rising_edge(clk) then	
							current_state	 <= next_state;
							--Gestione di uno dei tre segnali di debug utilizzati nel testbench
							stato_testbench <= conv_std_logic_vector(state'POS(next_state),4);
			end if;
		end process;
----------------------*****************-------------------------

--Processo asincrono che calcola i passaggi di stato e gestisce le uscite in una struttura automatica di tipo Mealy
--Se il reset è attivo o si verifica un caso non accettabile (bug) ritorna allo stato iniziale con uscita 0RR.
	State_Transition_and_output: process (current_state, row, col, badge, bug, rst)
			begin
---------Inizio struttura case-when--------------------------------------------------------------------------------------
				case current_state is
				when stato_iniziale =>					if rst='1' or bug='1' then 
																			next_state		<=stato_iniziale;
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
																			porta_aperta	<='0';
																			inserimento_corretto<='0';	rst_controllore<='1'; 
																			prossimo_tentativo  <='0';	rst_tentativi	<='1';
																end if;
-------------------------------------------------------------------------------------------------------------------------												
				when stato_lettura1 =>					if rst='1' or bug='1' then 
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
				when stato_attesa_rilascio1 =>		if rst='1' or bug='1' then 
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
				when stato_lettura2 =>					if rst='1' or bug='1' then 
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
				when stato_attesa_rilascio2 =>		if rst='1' or bug='1' then 
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
				when stato_lettura3 =>					if rst='1' or bug='1' then 
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
				when stato_attesa_rilascio3 =>		if rst='1' or bug='1' then 
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
				when stato_lettura4 =>					if rst='1' or bug='1' then 
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
				when stato_attesa_rilascio4 =>		if rst='1' or bug='1' then 
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
				when stato_porta_aperta =>				if rst='1' or bug='1' then 
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

--Gestione di due dei tre segnali di debug utilizzati nel testbench
contatore_testbench	 <= tentativo_corrente;
controllore_testbench <= password_corretta;
		
end Behavioral;

