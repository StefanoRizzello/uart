LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY start_g IS 

PORT (IN_0,IN_1,IN_2,IN_3,IN_4,IN_5,IN_6,IN_7 : IN std_logic;       
      START: OUT std_logic);
END start_g ;

ARCHITECTURE behav OF start_g IS

BEGIN


START<= IN_0 and IN_1 and IN_2 and IN_3 and (NOT IN_4) and (NOT IN_5) and (NOT IN_6) and (NOT IN_7);
end behav; 