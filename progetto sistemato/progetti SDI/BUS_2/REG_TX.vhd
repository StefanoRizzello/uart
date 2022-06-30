LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY REG_TX IS

PORT ( CLK: IN std_logic;
       EN_REG: IN std_logic_vector(2 downto 0);
		 D: IN std_logic_vector (7 downto 0);
       Q: OUT std_logic_vector(7 downto 0));
END REG_TX;

ARCHITECTURE behav OF REG_TX IS
 
BEGIN 

PROCESS(CLK)

BEGIN 

		IF (CLK'EVENT AND CLK = '1') THEN 
		IF (EN_REG ="100") THEN  -- CODICE INDIRIZZO REG TX
		Q<= D;
		
		END IF;
		END IF;
		END PROCESS;
		
END behav;