LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY REG7 IS

PORT ( CLK, EN_REG: IN std_logic;
       D: IN std_logic_vector(7 downto 0);
       Q: OUT std_logic_vector(7 downto 0));
END REG7;

ARCHITECTURE behav OF REG7 IS
 
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