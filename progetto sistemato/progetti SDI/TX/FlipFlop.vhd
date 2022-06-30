LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY FlipFlop IS 

PORT (D, CLK : IN std_logic;
       Q: OUT std_logic);
END  FlipFlop;

ARCHITECTURE behav OF FlipFlop IS 

BEGIN 

PROCESS(CLK)

BEGIN 

		IF (CLK'EVENT AND CLK = '1') THEN 
		Q<= D;
		
		END IF;
		END PROCESS;
		
END behav;