LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY REG_RX IS

PORT ( CLK: IN std_logic;
       EN_REG: IN std_logic_vector(2 downto 0);
		 D: IN std_logic_vector (7 downto 0);
       Q: OUT std_logic_vector(7 downto 0));
END REG_RX;

ARCHITECTURE behav OF REG_RX IS
 
BEGIN 

PROCESS(CLK)

BEGIN 

		IF (CLK'EVENT AND CLK = '1') THEN 
		IF (EN_REG ="011") THEN  -- CODICE INDIRIZZO REG RX
		Q<= D;
		
		END IF;
		END IF;
		END PROCESS;
		
END behav;