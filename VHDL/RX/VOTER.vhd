LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY VOTER IS 
PORT (Q0, Q1, Q2 : IN std_logic;
      V: OUT std_logic);
END VOTER;

ARCHITECTURE behav OF VOTER IS

BEGIN 

V<= (Q0 AND Q1) OR (Q1 AND Q2) OR (Q0 AND Q2 );
END behav; 