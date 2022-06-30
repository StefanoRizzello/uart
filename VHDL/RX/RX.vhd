LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY RX IS 
PORT ( CLK, DATA_IN, RX_EN: IN std_logic;
      DONE: OUT std_logic;
		PIN_8: OUT std_logic_vector(7 downto 0)); 
END RX;

ARCHITECTURE behav OF RX IS

COMPONENT start_g IS 
PORT (IN_0,IN_1,IN_2,IN_3,IN_4,IN_5,IN_6,IN_7 : IN std_logic;       
      START: OUT std_logic);
END COMPONENT;

COMPONENT REG IS
PORT ( D, EN_REG: IN std_logic;
       CLK: in std_logic;
       Q: OUT std_logic );
END COMPONENT;

COMPONENT VOTER IS 
PORT (Q0, Q1, Q2 : IN std_logic;
      V: OUT std_logic);
END COMPONENT;

COMPONENT Cnt_c IS 
PORT ( CLR,CLK,CE: IN std_logic;
       TC1,TC2,TC3: OUT std_logic);
END COMPONENT;

COMPONENT Cnt_0 IS 
PORT ( CLR,CLK,CE: IN std_logic;
       TC0: OUT std_logic);
END COMPONENT;

COMPONENT shift_register IS
PORT (RxD, CLK, SH_C: IN std_logic;
      out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7: BUFFER std_logic);
END COMPONENT;

COMPONENT FSM_RX IS
port ( clk,start,tc1,tc2,tc3,tc0,rx_en: IN std_logic;
       sh_c,clr,en_c,en_0,clr_0,en_reg_a,en_rv,ld_pin, DONE : BUFFER std_logic);
end COMPONENT;

SIGNAL start_s,tc1s,tc2s,tc3s,tc0s,sh_cs,clrs,en_cs,en_0s,clr_0s,en_reg_as,en_rvs,ld_pins: std_logic;
SIGNAL c0,c1,c2,c3,c4,c5,c6,c7,Q2s,Q4s,Q6s,votes,PINs: std_logic;
BEGIN 
CU: FSM_RX PORT MAP (rx_en => RX_EN, clk=> CLK, start => start_s,tc1=>tc1s, tc2=> tc2s, tc3=>tc3s, tc0=>tc0s,DONE=>DONE,
							sh_c=>sh_cs, clr=>clrs, en_c=>en_cs, en_0=> en_0s,clr_0=>clr_0s, en_reg_a=>en_reg_as,en_rv =>en_rvs, ld_pin=>ld_pins);
SHC: shift_register PORT MAP( CLK=>CLK,SH_C=>sh_cs,RxD=> DATA_IN,out_0=>c0,out_1=>c1,out_2=>c2,out_3=>c3,out_4=>c4,out_5=>c5,out_6=>c6,out_7=>c7);
strt: start_g PORT MAP (IN_0 => c0,IN_1=> c1, IN_2=> c2, IN_3=> c3, IN_4=> c4,IN_5=> c5,IN_6=> c6,IN_7=> c7, START =>start_s);
regA0: REG PORT MAP (D=> c2, EN_REG => en_reg_as,CLK=>CLK, Q=>Q2s);
regA1: REG PORT MAP (D=> c4, EN_REG => en_reg_as,CLK=>CLK, Q=>Q4s);
regA2: REG PORT MAP (D=> c6, EN_REG => en_reg_as,CLK=>CLK, Q=>Q6s);
vot: VOTER PORT MAP (Q0=>Q2s,Q1=>Q4s,Q2=>Q6s,V=> votes);
regVot: REG PORT MAP (D=> votes,CLK=>CLK, EN_REG=> en_rvs,Q=> PINs);
SHPIN: shift_register PORT MAP( RxD=>PINs, CLK=>CLK, SH_C=> ld_pins,
	out_0=> PIN_8(0), out_1=> PIN_8(1), out_2=> PIN_8(2), out_3=> PIN_8(3), out_4=> PIN_8(4), out_5=> PIN_8(5), out_6=> PIN_8(6), out_7=> PIN_8(7));
counter_c: Cnt_c PORT MAP( CLK=>CLK,TC1=>tc1s,TC2=>tc2s,TC3=>tc3s, CLR=> clrs, CE=> en_cs);	
counter_0: Cnt_0 PORT MAP (CLK=>CLK, TC0=> tc0s, CLR=> clr_0s,CE=> en_0s);
end behav;	
	