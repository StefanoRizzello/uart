LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY shift_register IS
PORT (RxD, CLK, SH_C: IN std_logic;
      out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7: BUFFER std_logic);
END shift_register;

ARCHITECTURE behav OF shift_register IS

SIGNAL SD: std_logic_vector(7 downto 0);

BEGIN 

PROCESS(CLK)	

BEGIN
 
IF (rising_edge(CLK)) THEN 
   IF (SH_C='1') THEN
    SD(7) <= RxD;
    SD(6) <= SD(7);
    SD(5) <= SD(6);
    SD(4) <= SD(5);
    SD(3) <= SD(4);
    SD(2) <= SD(3);
    SD(1) <= SD(2);
    SD(0) <= SD(1);
END IF;
END IF;
END PROCESS;

	out_7 <= SD(7);
	out_6 <= SD(6);
	out_5 <= SD(5);
	out_4 <= SD(4);
	out_3 <= SD(3);
	out_2 <= SD(2);
	out_1 <= SD(1);
	out_0 <= SD(0);

END behav;