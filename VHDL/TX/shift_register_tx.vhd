LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY shift_register_tx IS 

PORT ( Pin_Ts: IN std_logic_vector (7 downto 0);
      Load, SH, CLK: IN std_logic;
		S_out : OUT  std_logic);
		
		END shift_register_tx;
		
ARCHITECTURE behav OF shift_register_tx IS


SIGNAL SD: std_logic_vector (9 downto 0);

BEGIN 

PROCESS(CLK)	

BEGIN
 
IF (rising_edge(CLK)) THEN 
   IF (Load = '1') THEN 
	  SD(9)<= '1';
	  SD(8 downto 1) <= Pin_Ts(7 downto 0);
	  SD(0) <= '0';
	  END IF ;


	
	 IF (SH = '1') THEN 
	 SD <= '0' & SD(9 DOWNTO 1);
	 
	 END IF ;
	 END IF ;
	 END PROCESS;
	 
	 S_out<= SD(0); 
END behav;
	 
 
		