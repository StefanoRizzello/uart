LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY REG IS

PORT ( D, EN_REG: IN std_logic;
       CLK: in std_logic;
       Q: OUT std_logic );
END REG;

ARCHITECTURE behav OF REG IS
 
BEGIN 

PROCESS(CLK)

BEGIN 

		IF (CLK'EVENT AND CLK = '1') THEN 
		IF (EN_REG ='1') THEN
		Q<= D;
		
		END IF;
		END IF;
		END PROCESS;
		
END behav;