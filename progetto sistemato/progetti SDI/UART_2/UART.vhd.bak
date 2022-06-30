LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY UART IS 
 PORT ( TX_p,ATN : OUT std_logic;
        RX_p,CS,RWn,CLK,ATNCK: IN std_logic;
		  D_IN: IN std_logic_vector(7 downto 0);
		  D_out: OUT std_logic_vector (7 downto 0);
		  A: IN std_logic_vector(2 downto 0));
END UART; 

ARCHITECTURE behav OF UART IS 

		  
COMPONENT BUS_INT IS

PORT ( CLK,DONE_T,DONE_R,CS,RWn,ATNCK: IN std_logic;
       A: IN std_logic_vector(2 downto 0);
		 rx_en,tx_en,ATN: OUT std_logic;
		 D_IN,PIN_R: IN std_logic_vector (7 downto 0);
       D_OUT,PIN_T: OUT std_logic_vector(7 downto 0));
END COMPONENT;


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


SIGNAL done_ts,done_rs,tx_ens,rx_ens: std_logic;
SIGNAL PIN_TS,PIN_RS:std_logic_vector(7 downto 0);

BEGIN 
   
	
trasm: tx	PORT MAP( CLK=> CLK, TX=>TX_p, DONE=>done_ts, TX_EN=> tx_ens, PIN_T=>PIN_TS);
rix: RX PORT MAP (CLK=>CLK, DATA_IN=>RX_p, RX_EN=> rx_ens, DONE=> done_rs, PIN_8=>PIN_RS);
bus_i: BUS_INT PORT MAP(A=>A,CLK=>CLK, DONE_T=> done_ts, DONE_R=> done_rs, CS=> CS,RWn=> RWn,
								ATN=>ATN,rx_en=> rx_ens,tx_en=>tx_ens,D_IN=>D_IN,D_OUT=>D_OUT,
								PIN_R=>PIN_RS,PIN_T=>PIN_TS,ATNCK=>ATNCK);
end behav;								