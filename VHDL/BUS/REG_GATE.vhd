LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY REG_GATE IS
port (force: IN std_logic;
		A: IN  std_logic_vector(2 downto 0);
       new_tx, read_rx: OUT std_logic);
end REG_GATE;

ARCHITECTURE behav of reg_gate is 

begin 

new_tx <= force and A(2) and (NOT A(1)) and (NOT A(0));
read_rx <= force 	and (NOT A(2)) and A(1)and  A(0);

END behav;	 