LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY tx  IS 
PORT (PIN_T: IN std_logic_vector (7 downto 0);
       TX_EN,CLK: IN std_logic;
		 DONE, TX, ERROR_TX: OUT std_logic);
END tx;

ARCHITECTURE behav OF tx IS 

COMPONENT shift_register_tx 
PORT ( Pin_Ts: IN std_logic_vector (7 downto 0);
      Load, SH, CLK: IN std_logic;
		S_out : OUT  std_logic);
END COMPONENT ;	

COMPONENT Cnt_TX_CONTROL IS 
PORT ( CLR,CLK,CE: IN std_logic;
       TC_tx_ctrln: OUT std_logic);
END COMPONENT;


COMPONENT FlipFlop 
PORT ( D, CLK: IN std_logic;
       Q: OUT std_logic);
END  COMPONENT;

COMPONENT Counter_tx 
PORT ( CLR,CLK,CE: IN std_logic;
       TC: OUT std_logic);
END COMPONENT;

COMPONENT FSM_tx 
PORT ( CLK, TC, TX_EN : IN std_logic;
      DONE, Load_c, SH, CE, CLR,ERROR_TX,CLR_WD,CE_WD: OUT std_logic);
END COMPONENT;

SIGNAL load_s, SH_s,S_out_s, TC_s,CLR_s,CE_s,CE_WDS,CLR_WDS,ERROR_TXS,WDS: std_logic;

BEGIN 
WD_tx: Cnt_TX_CONTROL PORT MAP (CLR => CLR_WDS,CLK=> CLK,CE=> CE_WDS,TC_tx_ctrln=>WDS);
S_REG: shift_register_tx PORT MAP(Pin_Ts => PIN_T,CLK => CLK,Load=> load_s, SH=> SH_S, S_out=> S_out_s);
FF: FlipFlop PORT MAP ( CLK => CLK, Q=> TX, D=> S_out_s);
CNT: Counter_tx PORT MAP ( CLK => CLK,TC=> TC_s, CLR=> CLR_s,CE=> CE_s); 
CU: FSM_tx PORT MAP(CLK => CLK, TX_EN => TX_EN, DONE=> DONE,TC=> TC_s,Load_c=> load_s, SH=> SH_s, CE=> CE_s, CLR=> CLR_s,
							ERROR_TX=> ERROR_TXS,CLR_WD=>CLR_WDS,CE_WD=>CE_WDS);
ERROR_TX <= WDS AND ERROR_TXS;
END behav;