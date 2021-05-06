library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity NOT_gate is 
	port(A: in std_logic; O: out std_logic);
end entity NOT_gate;

architecture Struct of NOT_gate is
begin
O <= not A;
end Struct;