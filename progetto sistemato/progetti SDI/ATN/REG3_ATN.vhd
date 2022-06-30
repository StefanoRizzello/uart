LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY REG3_ATN IS

PORT ( CLK, EN_REG: IN std_logic;
       D: IN std_logic_vector(2 downto 0);
       Q: OUT std_logic_vector(2 downto 0));
END REG3_ATN;

ARCHITECTURE behav OF REG3_ATN IS
 
BEGIN 

PROCESS(CLK)

BEGIN 

		IF (CLK'EVENT AND CLK = '1') THEN 
		IF (EN_REG ='1') THEN
		Q<=  D;
		
		END IF;
		END IF;
		END PROCESS;
		
END behav;