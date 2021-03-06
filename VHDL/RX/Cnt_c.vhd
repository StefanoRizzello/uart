LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY Cnt_c IS 

PORT ( CLR,CLK,CE: IN std_logic;
       TC1,TC2,TC3: OUT std_logic);
END Cnt_c;

ARCHITECTURE behav OF Cnt_c IS 


SIGNAL K: INTEGER RANGE 0 TO 127;

BEGIN

PROCESS(CLR,CLK,CE)

BEGIN 

IF( CLR = '1') THEN 
TC1 <= '0';
TC2 <= '0';
TC3 <= '0';
K<= 0;

ELSIF( CLK'EVENT AND CLK = '1') THEN 
  IF (CE = '1') THEN
  IF( K = 15 ) THEN
  TC1 <= '1';
  END IF;
  IF ( K = 67) THEN
  TC2 <= '1';
  END IF;
  IF (K = 11) THEN
  TC3 <= '1';
  END IF;
  
  K<= K+1;
  
  END IF;
  END IF;
  
  
  END PROCESS;
  
 END behav; 
    	

 		 
