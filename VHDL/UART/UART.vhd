LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY UART IS 
 PORT ( TX_p,ATN_p : OUT std_logic;
        RX_p,CS,RWn,CLK,ATNCK: IN std_logic;
		  D_IN: IN std_logic_vector(7 downto 0);
		  D_out: OUT std_logic_vector (7 downto 0);
		  A: IN std_logic_vector(2 downto 0));
END UART; 

ARCHITECTURE behav OF UART IS 

		  
COMPONENT BUS_INT IS

PORT ( CLK,CS,RWn: IN std_logic;
       A,STATUS_IN: IN std_logic_vector(2 downto 0);
		 rx_en,tx_en,new_tx,read_rx: OUT std_logic;
		 D_IN,PIN_R: IN std_logic_vector (7 downto 0);
       D_OUT,PIN_T: OUT std_logic_vector(7 downto 0));
END COMPONENT;

COMPONENT ATN IS

port (DONE_T, DONE_R, NEW_TX, READ_RX,CLK,ATNCK: IN std_logic;
       RX: IN std_logic_vector(7 downto 0);
		 RX_OUT: OUT std_logic_vector(7 downto 0);
		 STATUS_OUT : OUT std_logic_vector (2 downto 0);
       ATN: OUT std_logic);
end COMPONENT ;


COMPONENT RX IS 
PORT ( CLK, DATA_IN, RX_EN: IN std_logic;
      DONE: OUT std_logic;
		PIN_8: OUT std_logic_vector(7 downto 0)); 
END COMPONENT;


COMPONENT tx  IS 
PORT (PIN_T: IN std_logic_vector (7 downto 0);
       TX_EN,CLK: IN std_logic;
		 DONE, TX: OUT std_logic);
END COMPONENT;


SIGNAL done_ts,done_rs,tx_ens,rx_ens,NEW_TXS,READ_RXS: std_logic;
SIGNAL PIN_TS,PIN_RS,RX_OUTS:std_logic_vector(7 downto 0);
SIGNAL STATUS_OUTS : STD_LOGIC_VECTOR(2 downto 0);

BEGIN 
   
	
trasm: tx	PORT MAP( CLK=> CLK, TX=>TX_p, DONE=>done_ts, TX_EN=> tx_ens, PIN_T=>PIN_TS);
rix: RX PORT MAP (CLK=>CLK, DATA_IN=>RX_p, RX_EN=> rx_ens, DONE=> done_rs, PIN_8=>PIN_RS);
bus_i: BUS_INT PORT MAP(CLK=>CLK, CS=> CS,RWn=> RWn,A=>A,
								rx_en=> rx_ens,tx_en=>tx_ens,D_IN=>D_IN,D_OUT=>D_OUT,
								PIN_R=>RX_OUTS,PIN_T=>PIN_TS,STATUS_IN=>STATUS_OUTS,new_tx=> NEW_TXS, read_rx=>READ_RXS);
								
ATN_B : ATN PORT MAP (DONE_T=> done_ts, DONE_R=> done_rs, NEW_TX=>NEW_TXS, READ_RX=>READ_RXS,CLK=>CLK,ATNCK=>ATNCK,							
							ATN=>ATN_p, RX=>PIN_RS, RX_OUT=>RX_OUTS, STATUS_OUT => STATUS_OUTS); 

end behav;
								