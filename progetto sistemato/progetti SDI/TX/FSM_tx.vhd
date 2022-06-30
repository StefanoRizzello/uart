LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY FSM_tx IS 

PORT ( CLK, TC, TX_EN: IN std_logic;
       DONE, Load_c, SH, CE, CLR,ERROR_TX,CLR_WD,CE_WD: BUFFER std_logic);
 END FSM_tx;
 
ARCHITECTURE behav OF FSM_tx IS 



TYPE STATE_TYPE IS(IDLE, LOAD, START, SH0,SH1,SH2,SH3,SH4,SH5,SH6,SH7,SH_STOP, STOP, D0,D1,D2,D3,D4,D5,D6,D7,DONE_STATE,ERROR_CHECK_ST);
SIGNAL  NS, PS: STATE_TYPE; 

BEGIN

PROCESS( TX_EN,TC,PS) -- aggiornamento stato
BEGIN 

CASE PS IS 
WHEN IDLE => IF( TX_EN = '1') THEN  NS <= LOAD;
END IF;
WHEN LOAD => NS <= START;
WHEN START => IF( TC = '1') THEN NS <= SH0;
END IF;
WHEN SH0 => NS <= D0;
WHEN D0 => IF (TC ='1') THEN NS <= SH1;
END IF;
WHEN SH1 => NS <= D1;
WHEN SH2 => NS <= D2;
WHEN SH3 => NS <= D3;
WHEN SH4 => NS <= D4;
WHEN SH5 => NS <= D5;
WHEN SH6 => NS <= D6;
WHEN SH7 => NS <= D7;
WHEN SH_STOP => NS <= STOP;
WHEN DONE_STATE=> NS<= ERROR_CHECK_ST;
WHEN ERROR_CHECK_ST => NS<= IDLE;

WHEN D1 =>IF (TC ='1') THEN NS <= SH2;
END IF;
WHEN D2 =>IF (TC ='1') THEN NS <= SH3;
END IF;
WHEN D3 =>IF (TC ='1') THEN NS <= SH4;
END IF;
WHEN D4 =>IF (TC ='1') THEN NS <= SH5;
END IF;
WHEN D5 => IF (TC ='1') THEN NS <= SH6;
END IF;
WHEN D6 =>IF (TC ='1') THEN NS <= SH7;
END IF;
WHEN D7=>IF (TC ='1') THEN NS <= SH_STOP;
END IF;
WHEN STOP => IF (TC ='1') THEN NS<= DONE_STATE;
END IF;

WHEN OTHERS => NS <= IDLE;


END CASE;
END PROCESS;

PROCESS(CLK) 
BEGIN 
IF(CLK'EVENT AND CLK = '1') THEN 
 PS <= NS;
END IF; 
END PROCESS; 

PROCESS (PS) -- generazione segnali controllo
BEGIN
DONE <='0';
Load_c<= '0';
CE<= '0';
CLR<= '0';
CLR_WD <='0';
SH<='0';
ERROR_TX <='0';

CASE PS IS 
WHEN DONE_STATE=> DONE<= '0';
WHEN ERROR_CHECK_ST=> ERROR_TX<= '1';CE_WD<='0';
WHEN IDLE => DONE <='0';
WHEN LOAD => Load_c <= '1';CLR <= '1'; DONE<='1'; CE_WD<='1'; CLR_WD<='1';
WHEN START => CE <= '1'; 
WHEN SH_STOP =>  SH <= '1'; CLR <='1';
WHEN SH0 =>  SH <= '1';CLR <= '1';
WHEN SH1 =>  SH <= '1';CLR <= '1';
WHEN SH2 =>  SH <= '1';CLR <= '1';
WHEN SH3 =>  SH <= '1';CLR <= '1';
WHEN SH4 =>  SH <= '1';CLR <= '1';
WHEN SH5 =>  SH <= '1';CLR <= '1';
WHEN SH6 =>  SH <= '1';CLR <= '1';
WHEN SH7 =>  SH <= '1';CLR <= '1';
WHEN D0 => CE<= '1'; 
WHEN D1 => CE<= '1'; 
WHEN D2 => CE<= '1'; 
WHEN D3 => CE<= '1'; 
WHEN D4 => CE<= '1'; 
WHEN D5 => CE<= '1'; 
WHEN D6 => CE<= '1'; 
WHEN D7 => CE<= '1'; 
WHEN STOP => CE<= '1'; 
WHEN OTHERS => DONE <='0';
					Load_c<= '0';
					CE<= '0';
					CLR<= '0';
					SH<='0';
					ERROR_TX<='0';

END CASE;
END PROCESS;

END behav;
