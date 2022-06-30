LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY Cnt_RX_CONTROL IS 

PORT ( CLR,CLK,CE: IN std_logic;
       TC_rx_ctrln: OUT std_logic);
END Cnt_RX_CONTROL;

ARCHITECTURE behav OF Cnt_RX_CONTROL  IS 
SIGNAL K: INTEGER RANGE 0 TO 1024;

BEGIN 

PROCESS(CLR,CLK,CE)

BEGIN 

IF( CLR = '1') THEN 
TC_rx_ctrln<= '1';
K<= 0;	

ELSIF( CLK'EVENT AND CLK = '1') THEN 
  IF (CE = '1') THEN
  IF( K = 860) THEN -- 6
  TC_rx_ctrln <= '0';
  END IF;	 
  K  <= K+1;
  END IF;
  END IF;
  
END PROCESS;

END behav; 