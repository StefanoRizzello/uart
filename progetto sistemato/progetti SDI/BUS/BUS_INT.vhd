LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY BUS_INT IS

PORT ( CLK,DONE_T,DONE_R,CS,RWn,ATNCK: IN std_logic;
       A: IN std_logic_vector(2 downto 0);
		 rx_en,tx_en,ATN: OUT std_logic;
		 D_IN,PIN_R: IN std_logic_vector (7 downto 0);
       D_OUT,PIN_T: OUT std_logic_vector(7 downto 0));
END BUS_INT;

ARCHITECTURE behav OF BUS_INT IS 

COMPONENT FSM_BUS IS
port ( clk, done_t,done_r,cs,RWn,ATNCK: IN std_logic;
       control: IN std_logic_vector(2 downto 0);
		 state: BUFFER std_logic_vector (2 downto 0);
       force,force_m, new_tx, rx_en, ATN,en_regST,reset_ctrl: BUFFER std_logic);
end COMPONENT;

COMPONENT ADD IS
PORT( force: IN std_logic;
      A: IN std_logic_vector(2 downto 0);
		E: OUT std_logic_vector(2 downto 0));
END COMPONENT;


COMPONENT MUX_OUT IS 
PORT( RX_IN : IN std_logic_vector( 7 downto 0);
      STATUS_IN: IN std_logic_vector (2 downto 0);
		SEL_E: IN std_logic_vector (2 downto 0);
		OUTPUT: OUT std_logic_vector (7 downto 0));
END COMPONENT;


COMPONENT REG3 IS
PORT ( CLK, EN_REG: IN std_logic;
       D: IN std_logic_vector(2 downto 0);
       Q: OUT std_logic_vector(2 downto 0));
END COMPONENT;

COMPONENT REG_STATUS IS
PORT ( CLK: IN std_logic;
       D, EN_REG: IN std_logic_vector(2 downto 0);
       Q: OUT std_logic_vector(2 downto 0));
END COMPONENT;

COMPONENT REG_CONTROL IS
PORT ( CLK,RESET: IN std_logic;
       D, EN_REG: IN std_logic_vector(2 downto 0);
       Q: OUT std_logic_vector(2 downto 0));
END COMPONENT;

COMPONENT REG_TX IS
PORT ( CLK: IN std_logic;
       EN_REG: IN std_logic_vector(2 downto 0);
		 D: IN std_logic_vector (7 downto 0);
       Q: OUT std_logic_vector(7 downto 0));
END COMPONENT;

COMPONENT REG_RX IS
PORT ( CLK: IN std_logic;
       EN_REG: IN std_logic_vector(2 downto 0);
		 D: IN std_logic_vector (7 downto 0);
       Q: OUT std_logic_vector(7 downto 0));
END COMPONENT;

SIGNAL ERS,force_s, force_ms,reset_ctrls:std_logic;
SIGNAL Es,Esm,Q_SS,D_SS,state_s,Q_CS:std_logic_vector(2 downto 0);
SIGNAL Q_RXS:std_logic_vector(7 downto 0);

BEGIN
R_TX: REG_TX PORT MAP(D=> D_IN,Q=>PIN_T,CLK=>CLK,EN_REG=>Es);
R_RX: REG_RX PORT MAP(D=> PIN_R,Q=>Q_RXS,CLK=>CLK,EN_REG=>Es);
R_C: REG_CONTROL PORT MAP(D=> D_IN(2 downto 0),Q=>Q_CS,CLK=>CLK,EN_REG=>Es, RESET=>reset_ctrls);
R_S: REG_STATUS PORT MAP(D=> D_SS,Q=>Q_SS,CLK=>CLK,EN_REG=>Es);
REG: REG3 PORT MAP(D=> state_s,Q=>D_SS,CLK=>CLK,EN_REG=>ERS);
address_mux: ADD PORT MAP ( force=> force_ms , A=>A ,E=>Esm);
address: ADD PORT MAP (force=> force_s , A=>A ,E=>Es);
MUX: MUX_OUT PORT MAP (SEL_E=>Esm, OUTPUT=>D_OUT, RX_IN =>Q_RXS ,STATUS_IN=> Q_SS);
CU : FSM_bus PORT MAP ( CLK=>CLK, done_t=>DONE_T, done_r=> DONE_R, cs=> CS, RWn => RWn, control=> Q_CS,
								state=> state_s, force=>force_s, force_m=>force_ms, new_tx=>tx_en, rx_en=>rx_en, ATN=>ATN,
								en_regST=> ERS, reset_ctrl=> reset_ctrls,ATNCK=>ATNCK);
 END behav;