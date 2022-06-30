LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY FSM_ATN IS

port ( ATN_req,ATNCK,CLK,ERROR_CHECK: IN std_logic;
       ATN,ERROR,en_reg_ERROR: BUFFER std_logic);
end FSM_ATN;


ARCHITECTURE behav OF FSM_ATN IS 

TYPE STATE_TYPE IS ( POLLING, ATN_ST, ATNCK_ST,ERROR_ST);
SIGNAL PS, NS: STATE_TYPE;

BEGIN

PROCESS( CLK,PS, ATNCK,ATN_req) -- aggiornamento stato
BEGIN 

CASE PS IS
WHEN POLLING => IF (ATN_req = '1') THEN NS <= ATN_ST;
                END IF;
					IF( ATNCK = '1') THEN NS <= ATNCK_ST;
						END IF;
					IF (ERROR_CHECK = '1') THEN NS <= ERROR_ST;
				      END IF;	
WHEN ATN_ST  => NS <= POLLING;
WHEN ATNCK_ST  => NS <= POLLING;
WHEN ERROR_ST =>IF (ATNCK = '1') THEN NS <= ATNCK_ST;
               END IF;
					
WHEN OTHERS => NS<= POLLING;

END CASE;
END PROCESS;


PROCESS(CLK) 
BEGIN 
IF(CLK'EVENT AND CLK = '1') THEN 
 PS <= NS;
END IF; 
END PROCESS;

PROCESS (PS) -- generazione segnali controllo
BEGIN
ERROR<= '0';
en_reg_ERROR <= '0';
CASE PS IS

WHEN ATN_ST => ATN<= '1'; 
WHEN ATNCK_ST => ATN <= '0';
WHEN POLLING  => ERROR <= '0'; en_reg_ERROR<='1';
WHEN ERROR_ST => ERROR<= '1'; en_reg_ERROR<= '1'; ATN <= '1';
END CASE;
END PROCESS;

END BEHAV;