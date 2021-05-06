library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity XOR_gate is 
	port(A, B: in std_logic; O: out std_logic);
end entity XOR_gate;

architecture Struct of XOR_gate is
signal notA, notB, X, Y : std_logic;
component AND_gate
port(A, B: in std_logic; O: out std_logic);
end component;

component OR_gate
port(A, B: in std_logic; O: out std_logic);
end component;

component NOT_gate
port(A: in std_logic; O: out std_logic);
end component;

begin

Chip_NOT1 : NOT_gate
port map(A, notA);

Chip_NOT2 : NOT_gate
port map(B, notB);

Chip_AND1 : AND_gate
port map(A, notB, X);

Chip_AND2 : AND_gate
port map(notA, B, Y);

Chip_OR : OR_gate
port map(X, Y, O);

end Struct;