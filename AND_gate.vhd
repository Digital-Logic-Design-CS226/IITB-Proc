library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity AND_gate is 
	port(A, B: in std_logic; O: out std_logic);
end entity AND_gate;

architecture Struct of AND_gate is
begin
O <= (A and B);
end Struct;