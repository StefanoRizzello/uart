LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY REG_STATUS IS

PORT ( CLK: IN std_logic;
       D, EN_REG: IN std_logic_vector(2 downto 0);
       Q: OUT std_logic_vector(2 downto 0));
END REG_STATUS;

ARCHITECTURE behav OF REG_STATUS IS
 
BEGIN 

PROCESS(CLK)

BEGIN 

		IF (CLK'EVENT AND CLK = '1') THEN 
		IF (EN_REG ="001") THEN  -- CODICE INDIRIZZO REG STATUS
		Q<= D;
		
		END IF;
		END IF;
		END PROCESS;
		
END behav;