LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY Counter_tx IS 

PORT ( CLR,CLK,CE: IN std_logic;
       TC: OUT std_logic);
END Counter_tx;

ARCHITECTURE behav OF Counter_tx IS 


SIGNAL K: INTEGER RANGE 0 TO 255;

BEGIN

PROCESS(CLR,CLK,CE)

BEGIN 

IF( CLR = '1') THEN 
TC <= '0';
K<= 0;

ELSIF( CLK'EVENT AND CLK = '1') THEN 
  IF (CE = '1') THEN
  IF( K = 137) THEN
  TC <= '1';
  ELSE
  K<= K+1;
  
  END IF;
  END IF;
  END IF;
  
  
  END PROCESS;
  
 END behav; 
    	

 		 
