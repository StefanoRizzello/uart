LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY OR_GATE IS

port ( DONE_T, DONE_R, NEW_TX, READ_RX,ERROR_TX,ERROR_RX: IN std_logic;
       ATN_req, en_reg_TX, en_reg_RX,ERROR_CK : OUT std_logic);
end OR_GATE;

ARCHITECTURE behav of OR_GATE IS 
 BEGIN
ATN_req <= DONE_T OR DONE_R;
en_reg_TX <= (DONE_T OR NEW_TX); 
en_reg_RX <= (DONE_R OR READ_RX);
ERROR_CK <= (ERROR_TX OR ERROR_RX); 
END behav;