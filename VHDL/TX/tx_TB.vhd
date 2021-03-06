LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 


ENTITY tx_TB IS 
END tx_TB;

ARCHITECTURE behav OF tx_TB IS 

SIGNAL pin_tb: std_logic_vector(7 downto 0);
SIGNAL en_tx_tb,done_tb,CLK_tb,TX_tb: std_logic;


COMPONENT tx  IS 
PORT (PIN_T: IN std_logic_vector (7 downto 0);
       TX_EN,CLK: IN std_logic;
		 DONE, TX: OUT std_logic);
END COMPONENT;
 
 BEGIN 
 
 trasm: tx PORT MAP(PIN_T=> pin_tb,TX_EN=> en_tx_tb,CLK=> CLK_tb, DONE=> done_tb, TX=> TX_tb);
 
 clk_process: PROCESS 
 
 BEGIN 
 CLK_tb<= '0';
 wait for 1 ns;
 CLK_tb <= '1';
 wait for 1 ns;
 end process;
 
 
 s_process: PROCESS 
 begin 
 pin_tb <= "10110110";
 en_tx_tb <='1';
 wait for 10 ns;
 en_tx_tb <='0';
wait for 5 ns; 
 end process;
 
 end behav;
 