LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 


ENTITY UART_tb IS 
END UART_tb;

ARCHITECTURE behav OF UART_tb IS

SIGNAL D_IN_tb,D_out_tb: std_logic_vector (7 downto 0);
SIGNAL A_tb: std_logic_vector (2 downto 0);
SIGNAL TX_p_tb,ATN_tb,RX_p_tb,CS_tb,RWn_tb,CLK_tb,ATNCK_tb: std_logic;

COMPONENT UART  IS
 PORT ( TX_p,ATN_p : OUT std_logic;
        RX_p,CS,RWn,CLK,ATNCK: IN std_logic;
		  D_IN: IN std_logic_vector(7 downto 0);
		  D_out: OUT std_logic_vector (7 downto 0);
		  A: IN std_logic_vector(2 downto 0)); 
END COMPONENT;

BEGIN

ua: UART PORT MAP(TX_p=>TX_p_tb,ATN_p=>ATN_tb,ATNCK=>ATNCK_tb,RX_p=>RX_p_tb,CS=>CS_tb,RWn=>RWn_tb,CLK=>CLK_tb,
						A=>A_tb,D_IN=>D_IN_tb,D_out=>D_out_tb);

clk_process: PROCESS 
 
 BEGIN 
 CLK_tb<= '0';
 wait for 1 ns;
 CLK_tb <= '1';
 wait for 1 ns;
 end process;
 
   PROCESS
 BEGIN

 wait for 5 ns;
 RX_p_tb <= '1'; --nnt
 wait for 278 ns;
 RX_p_tb <= '0'; --start
 wait for 278 ns;
 RX_p_tb <= '1'; --0
 wait for 278 ns;
 RX_p_tb <= '0';--1
 wait for 278 ns;
 RX_p_tb <= '1';--2
 wait for 278 ns;
 RX_p_tb <= '0';--3
 wait for 278 ns;
 RX_p_tb <= '1';--4
 wait for 278 ns;
 RX_p_tb <= '0';--5
 wait for 278 ns;
 RX_p_tb <= '1';--6
 wait for 278 ns;
 RX_p_tb <= '0';--7
 wait for 278 ns;
 RX_p_tb <= '1';--stop
 wait for 1000 ns;
 END PROCESS;
 
 
 PROCESS
 BEGIN
 wait for 5 ns;

 CS_tb<='1';
 RWn_tb<='0'; -- comando per scrivere dato da trasmettere
 A_tb<="100";
 D_IN_tb<="01010101"; -- dato da trasmettere
 wait for 5 ns;
 RWn_tb<='0'; --comando per attivare il tx
 A_tb<="010";
 D_IN_tb<="00000011"; --codici tx_en
 wait for 5 ns;
 CS_tb<='0';
 wait for 60 ns; -- IN TEORIA DEVE FERMARSI QUI MANCA ATNCK
 ATNCK_tb <= '1';
 wait for 5 ns;
 ATNCK_tb <= '0';
 wait for 5 ns;
 CS_tb<='1';
 RWn_tb<='1'; --comando per leggere stato 
 A_tb<="001";
 wait for 5 ns;
 CS_tb<='0';
 wait for 10 ns;
 CS_tb <= '1';
 RWn_tb<='0'; --comando per spegnere il tx
 A_tb<="010";
 D_IN_tb<="00000010"; --codici spegnere tx
 wait for 5 ns;
 CS_tb<= '0';
 wait for 999 ns;
 END PROCESS;
 
 END behav;
 
