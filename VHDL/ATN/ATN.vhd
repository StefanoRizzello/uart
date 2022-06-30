LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY ATN IS

port ( DONE_T, DONE_R, NEW_TX, READ_RX,CLK,ATNCK: IN std_logic;
       RX: IN std_logic_vector(7 downto 0);
		 RX_OUT: OUT std_logic_vector(7 downto 0);
		 STATUS_OUT : OUT std_logic_vector (2 downto 0);
       ATN: OUT std_logic);
end ATN ;

ARCHITECTURE BEHAV OF ATN IS 

COMPONENT OR_GATE IS

port ( DONE_T, DONE_R, NEW_TX, READ_RX: IN std_logic;
       ATN_req, en_reg_RX,en_reg_TX : OUT std_logic);
end COMPONENT;


COMPONENT REG7 IS

PORT ( CLK, EN_REG: IN std_logic;
       D: IN std_logic_vector(7 downto 0);
       Q: OUT std_logic_vector(7 downto 0));
END COMPONENT;


COMPONENT FSM_ATN IS

port ( ATN_req,ATNCK,CLK: IN std_logic;
       ATN,ERROR,en_reg_ERROR: BUFFER std_logic);
end COMPONENT;

COMPONENT REG IS

PORT ( D, EN_REG: IN std_logic;
       CLK: in std_logic;
       Q: OUT std_logic );
END COMPONENT;


SIGNAL ATN_req_S, error_s,en_reg_TXS,en_reg_RXS,en_reg_errors : std_logic;

BEGIN

reg_7: REG7 PORT MAP ( CLK=>CLK, EN_REG => DONE_R, D=>RX, Q=>RX_OUT);
OR_PORT: OR_GATE PORT MAP ( DONE_T => DONE_T, DONE_R=> DONE_R, NEW_TX => NEW_TX, READ_RX=> READ_RX,
									 ATN_req =>ATN_req_S,en_reg_TX=>en_reg_TXS,en_reg_RX=>en_reg_RXS );
CU: FSM_ATN PORT MAP (	ATN_req=> ATN_req_S,ATNCK=> ATNCK,CLK=> CLK, ATN=>ATN,ERROR=> error_s,
							en_reg_ERROR=> en_reg_errors);
REG_RX : REG PORT MAP (CLK=> CLK,D=>DONE_R,EN_REG=> en_reg_RXS,Q=> STATUS_OUT(1));
REG_TX : REG PORT MAP (CLK=> CLK,D=>DONE_T,EN_REG=> en_reg_TXS,Q=> STATUS_OUT(0));
REG_ERROR: REG PORT MAP (CLK=> CLK,D=>error_s,EN_REG=> en_reg_errors,Q=> STATUS_OUT(2));
END BEHAV;							 
