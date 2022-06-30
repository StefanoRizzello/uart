LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY ADD IS
PORT( force: IN std_logic;
      A: IN std_logic_vector(2 downto 0);
		E: OUT std_logic_vector(2 downto 0));
END ADD;

ARCHITECTURE behav OF ADD IS 
BEGIN 
E(0) <= A(0) AND force;
E(1) <= A(1) AND force; 
E(2) <= A(2) AND force; 
END behav; 