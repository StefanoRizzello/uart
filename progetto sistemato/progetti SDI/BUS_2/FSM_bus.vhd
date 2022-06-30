LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY FSM_BUS IS

port ( clk,cs,RWn,clear: IN std_logic;
       force, force_m, reset_ctrl: BUFFER std_logic);
end FSM_BUS;


ARCHITECTURE behav OF FSM_BUS IS 

TYPE STATE_TYPE IS (WAIT_ST,READ_ST,WRITE_ST,MUX_ST);
SIGNAL PS, NS: STATE_TYPE;

BEGIN

PROCESS( CLK,PS,cs,RWn) -- aggiornamento stato
BEGIN 

CASE PS IS
WHEN WAIT_ST => IF( cs = '1' AND RWn = '1') THEN NS<= READ_ST;
                END IF;
					 IF( cs = '1' AND RWn = '0') THEN NS<= WRITE_ST;
                END IF;
					 					 


WHEN READ_ST => NS<= MUX_ST;
WHEN MUX_ST=> NS<= WAIT_ST;
WHEN WRITE_ST => NS<= WAIT_ST;


WHEN OTHERS => NS <= WAIT_ST;

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
force <= '0'; 
force_m <= '0';
reset_ctrl<= '0';

CASE PS IS 
WHEN WAIT_ST=>force <= '0'; 
					force_m <= '0';
					reset_ctrl<= '0';
					
WHEN MUX_ST => force_m <= '1';
WHEN READ_ST => force <= '1'; 
WHEN WRITE_ST => force <= '1'; 


WHEN OTHERS => force <= '0'; 
					force_m <= '0';
					reset_ctrl<= '0';

END CASE;
END PROCESS;

END behav;