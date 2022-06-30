LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY MUX_OUT IS 
PORT( RX_IN : IN std_logic_vector( 7 downto 0);
      STATUS_IN: IN std_logic_vector (2 downto 0);
		SEL_E: IN std_logic_vector (2 downto 0);
		OUTPUT: OUT std_logic_vector (7 downto 0));
END MUX_OUT;

ARCHITECTURE behav OF MUX_OUT IS 

BEGIN
with SEL_E select
    OUTPUT <= RX_IN when "011",
					"00000" & STATUS_IN when "001",
					
         "00000000"  when others;
end Behav;

