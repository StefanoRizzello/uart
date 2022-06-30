LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY FSM_RX IS

port ( clk,start,tc1,tc2,tc3,tc0,rx_en: IN std_logic;
       sh_c,clr,en_c,en_0,clr_0,en_reg_a,en_rv,ld_pin, DONE : BUFFER std_logic);
end FSM_RX;


ARCHITECTURE behav OF FSM_RX IS 

TYPE STATE_TYPE IS ( IDLE,SH_X,NC, START_ST, SH_C0,C0,SH_C1,C1,SH_C2,C2,SH_C3,C3,SH_C4,C4,SH_C5,C5,SH_C6,C6,SH_C7,REG_A,VOTE, LP, WAIT_ST, DONE_ST);
SIGNAL PS, NS: STATE_TYPE;

BEGIN

PROCESS( CLK,PS,start,tc1,tc2,tc0,tc3,rx_en) -- aggiornamento stato
BEGIN 

CASE PS IS
WHEN IDLE => IF (rx_en = '1') THEN NS <= SH_X;
						END IF;
WHEN SH_X => IF (start = '0') THEN NS <= NC;
             END IF;
				 IF ( start = '1') THEN NS <= START_ST;
				 END IF; 
WHEN	NC => IF( tc1 = '1') THEN NS <= SH_X;
				END IF;
WHEN START_ST => IF ( tc2 = '1') THEN NS <= SH_C0;
                END IF;
WHEN SH_C0 => NS <= C0;	
WHEN SH_C1 => NS <= C1;
WHEN SH_C2 => NS <= C2;
WHEN SH_C3 => NS <= C3;
WHEN SH_C4 => NS <= C4;
WHEN SH_C5 => NS <= C5;
WHEN SH_C6 => NS <= C6;
WHEN SH_C7 => NS <= REG_A;
WHEN DONE_ST => NS<= IDLE;
WHEN C0 => IF (tc1='1')THEN NS<= SH_C1;
				END IF;
WHEN C1 => IF (tc1='1')THEN NS<= SH_C2;
				END IF;
WHEN C2 => IF (tc1='1')THEN NS<= SH_C3;
				END IF;
WHEN C3 => IF (tc1='1')THEN NS<= SH_C4;
				END IF;
WHEN C4 => IF (tc1='1')THEN NS<= SH_C5;
				END IF;
WHEN C5 => IF (tc1='1')THEN NS<= SH_C6;
				END IF;
WHEN C6 => IF (tc1='1')THEN NS<= SH_C7;
				END IF;
WHEN REG_A => NS<= VOTE;
WHEN VOTE => NS <= LP;
WHEN LP=> IF (tc0='0') THEN NS <= WAIT_ST;
          END IF;
			 IF (tc0='1') THEN NS <= DONE_ST;
			 END IF;
WHEN WAIT_ST => IF(tc3='1') THEN NS<= SH_C0;
						END IF;

WHEN OTHERS => NS<= IDLE;

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
sh_c <= '0';
clr <= '0';
en_c <= '0';
en_0 <= '0';
clr_0 <= '0';
en_reg_a <= '0';
en_rv <= '0';
ld_pin <= '0';
DONE <='0';

CASE PS IS
WHEN IDLE => DONE<= '0'; clr_0<= '1'; 
WHEN DONE_ST => DONE <='1'; clr_0<= '1';
WHEN START_ST => en_c <= '1'; 
WHEN SH_X => sh_c <= '1'; clr <='1';
WHEN SH_C0 =>  sh_c <= '1';clr <= '1';
WHEN SH_C1 =>  sh_c <= '1';clr <= '1';
WHEN SH_C2 =>  sh_c <= '1';clr<= '1';
WHEN SH_C3 =>  sh_c <= '1';clr <= '1';
WHEN SH_C4 =>  sh_c <= '1';clr <= '1';
WHEN SH_C5 =>  sh_c <= '1';clr <= '1';
WHEN SH_C6 =>  sh_c <= '1';clr <= '1';
WHEN SH_C7 =>  sh_c <= '1';clr <= '1';
WHEN NC => en_c <= '1'; 
WHEN C0 => en_c <= '1'; 
WHEN C1 => en_c <= '1'; 
WHEN C2 => en_c <= '1'; 
WHEN C3 => en_c <= '1'; 
WHEN C4 => en_c <= '1'; 
WHEN C5 => en_c <= '1'; 
WHEN C6 => en_c <= '1'; 
WHEN REG_A => en_reg_a <= '1';
WHEN VOTE => en_rv <= '1';
WHEN LP => ld_pin <= '1'; en_0<='1'; clr<='1';
WHEN WAIT_ST => en_c <= '1';
WHEN OTHERS =>
			sh_c <= '0';
			clr <= '0';
			en_c <= '0';
			en_0 <= '0';
			clr_0 <= '0';
			en_reg_a <= '0';
			en_rv <= '0';
			ld_pin <= '0';
END CASE;
END PROCESS;

END behav;