LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY Cnt_0 IS 

PORT ( CLR,CLK,CE: IN std_logic;
       TC0: OUT std_logic);
END Cnt_0;
ARCHITECTURE behav OF Cnt_0  IS 
SIGNAL K: INTEGER RANGE 0 TO 127;

BEGIN 

PROCESS(CLR,CLK,CE)

BEGIN 

IF( CLR = '1') THEN 
TC0 <= '0';
K<= 0;	

ELSIF( CLK'EVENT AND CLK = '1') THEN 
  IF (CE = '1') THEN
  IF( K = 6) THEN -- 6
  TC0 <= '1';
  END IF;	 
  K  <= K+1;
  END IF;
  END IF;
  
END PROCESS;

END behav; 