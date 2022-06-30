LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY REG_CONTROL IS

PORT ( CLK,RESET: IN std_logic;
       D, EN_REG: IN std_logic_vector(2 downto 0);
       Q: OUT std_logic_vector(2 downto 0));
END REG_CONTROL;

ARCHITECTURE behav OF REG_CONTROL IS
 SIGNAL S : std_logic_vector(2 downto 0);
BEGIN 

PROCESS(CLK,RESET)

BEGIN 
 IF ( RESET = '1') THEN 
 S<= "000";
 

		ELSIF (CLK'EVENT AND CLK = '1') THEN 
		IF (EN_REG ="010") THEN  -- CODICE INDIRIZZO REG CONTROL
		S<= D;
		
		END IF;
		END IF;
		END PROCESS;
		Q<= S;
		
END behav;