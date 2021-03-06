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
 PORT ( TX_p,ATN : OUT std_logic;
        RX_p,CS,RWn,CLK,ATNCK: IN std_logic;
		  D_IN: IN std_logic_vector(7 downto 0);
		  D_out: OUT std_logic_vector (7 downto 0);
		  A: IN std_logic_vector(2 downto 0)); 
END COMPONENT;

BEGIN

ua: UART PORT MAP(TX_p=>TX_p_tb,ATN=>ATN_tb,ATNCK=>ATNCK_tb,RX_p=>RX_p_tb,CS=>CS_tb,RWn=>RWn_tb,CLK=>CLK_tb,
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
 CS_tb<='1';
 RWn_tb<='0'; -- comando per scrivere dato da trasmettere
 A_tb<="100";
 D_IN_tb<="11111111"; -- dato da trasmettere
 wait for 5 ns;
 RWn_tb<='0'; --comando per attivare il tx
 A_tb<="010";
 D_IN_tb<="11111001"; --codici tx_en
 wait for 5 ns;
 CS_tb<='0';
 wait for 40 ns; -- IN TEORIA DEVE FERMARSI QUI MANCA ATNCK
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
 END PROCESS;
 
 END behav;
 
