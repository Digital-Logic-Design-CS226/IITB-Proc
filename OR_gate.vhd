library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity OR_gate is 
	port(A, B: in std_logic; O: out std_logic);
end entity OR_gate;

architecture Struct of OR_gate is
begin
O <= (A or B);
end Struct;