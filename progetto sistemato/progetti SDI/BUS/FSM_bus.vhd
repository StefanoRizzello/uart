LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY FSM_BUS IS

port ( clk, done_t,done_r,cs,RWn,ATNCK: IN std_logic;
       control: IN std_logic_vector(2 downto 0);
		 state: BUFFER std_logic_vector (2 downto 0);
       force, force_m,new_tx, rx_en, ATN,en_regST,reset_ctrl: BUFFER std_logic);
end FSM_BUS;


ARCHITECTURE behav OF FSM_BUS IS 

TYPE STATE_TYPE IS ( WAIT_ST,READ_ST,WRITE_ST,EN_RX_ST,EN_TX_ST,BUSY,EMPTY_TX,FULL_RX,RESET_CTRL_REG,MUX_ST,ATN_ST);
SIGNAL PS, NS: STATE_TYPE;

BEGIN

PROCESS( CLK,PS,cs,RWn,control,done_t,done_r

) -- aggiornamento stato
BEGIN 

CASE PS IS
WHEN WAIT_ST => IF( cs = '1' AND RWn = '1') THEN NS<= READ_ST;
                END IF;
					 IF( cs = '1' AND RWn = '0') THEN NS<= WRITE_ST;
                END IF;
					 IF( control = "001") THEN NS<= EN_TX_ST;
                END IF;
					 IF( control = "010") THEN NS<= EN_RX_ST;
                END IF;
WHEN EN_TX_ST => NS<= BUSY;
WHEN EN_RX_ST => NS<= BUSY;
WHEN READ_ST => NS<= MUX_ST;
WHEN MUX_ST=> NS<= WAIT_ST;
WHEN WRITE_ST => NS<= WAIT_ST;
WHEN BUSY=> IF(done_t = '1')THEN NS <= EMPTY_TX;
				END IF;
				IF(done_r = '1')THEN NS <= FULL_RX;
				END IF;	
WHEN EMPTY_TX=> NS<= RESET_CTRL_REG;
WHEN FULL_RX => NS <= RESET_CTRL_REG;
WHEN RESET_CTRL_REG => NS<= ATN_ST;
WHEN ATN_ST => IF (ATNCK = '1') THEN NS<= WAIT_ST;
               END IF;
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
state <= "000";
force <= '0'; 
new_tx <= '0';
rx_en <='0';
ATN <= '0';
en_regST<='0';
reset_ctrl<= '0';
force_m <= '0';

CASE PS IS 
WHEN ATN_ST => ATN <= '1';
WHEN WAIT_ST => ATN <='0';
WHEN MUX_ST => force_m <= '1';
WHEN READ_ST => force <= '1'; 
WHEN WRITE_ST => force <= '1';
WHEN BUSY => ATN <= '0';
WHEN EN_TX_ST => new_tx<= '1';
WHEN EN_RX_ST => rx_en <= '1';
WHEN EMPTY_TX => state<= "001"; en_regST<='1';
WHEN FULL_RX => state<= "010"; en_regST<='1';
WHEN RESET_CTRL_REG => reset_ctrl<= '1';
WHEN OTHERS => state <= "000";
					force <= '0';
					force_m <= '0';
					new_tx <= '0';
					rx_en <='0';
					ATN <= '0';
					en_regST<='0';
					reset_ctrl<= '0'; 


END CASE;
END PROCESS;

END behav;