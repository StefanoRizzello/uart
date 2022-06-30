LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY BUS_INT IS

PORT ( CLK,CS,RWn: IN std_logic;
       A,STATUS_IN: IN std_logic_vector(2 downto 0);
		 rx_en,tx_en,new_tx,read_rx: OUT std_logic;
		 D_IN,PIN_R: IN std_logic_vector (7 downto 0);
       D_OUT,PIN_T: OUT std_logic_vector(7 downto 0));
END BUS_INT;

ARCHITECTURE behav OF BUS_INT IS 

COMPONENT FSM_BUS IS
port ( clk,cs,RWn,clear: IN std_logic;
       force, force_m,reset_ctrl: BUFFER std_logic);
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

COMPONENT REG_GATE IS
port (force: IN std_logic;
		A: IN  std_logic_vector(2 downto 0);
       new_tx, read_rx: OUT std_logic);
end COMPONENT;


SIGNAL ERS,force_s, force_ms,reset_ctrls,clears:std_logic;
SIGNAL Es,Esm,Q_SS,D_SS,state_s:std_logic_vector(2 downto 0);
SIGNAL Q_RXS:std_logic_vector(7 downto 0);

BEGIN
gate: REG_GATE PORT MAP (A=>A, force=>force_s,new_tx=>new_tx,read_rx=>read_rx);
R_TX: REG_TX PORT MAP(D=> D_IN,Q=>PIN_T,CLK=>CLK,EN_REG=>Es);
R_RX: REG_RX PORT MAP(D=> PIN_R,Q=>Q_RXS,CLK=>CLK,EN_REG=>Es);
R_C: REG_CONTROL PORT MAP(D=> D_IN(2 downto 0),Q(0)=>tx_en,Q(1)=>rx_en,Q(2)=> clears,CLK=>CLK,EN_REG=>Es, RESET=>reset_ctrls);
R_S: REG_STATUS PORT MAP(D=> STATUS_IN,Q=>Q_SS,CLK=>CLK,EN_REG=>Es);
address_mux: ADD PORT MAP ( force=> force_ms , A=>A ,E=>Esm);
address: ADD PORT MAP (force=> force_s , A=>A ,E=>Es);
MUX: MUX_OUT PORT MAP (SEL_E=>Esm, OUTPUT=>D_OUT, RX_IN =>Q_RXS ,STATUS_IN=> Q_SS);
CU : FSM_bus PORT MAP ( CLK=>CLK, cs=> CS, RWn => RWn, clear=>clears,
								force=>force_s, force_m=>force_ms,reset_ctrl=>reset_ctrls);
 END behav;