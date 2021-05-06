library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity Generator is
    Port ( A : in std_logic;
           B : in std_logic;
           G_out : out std_logic;
           P_out : out std_logic);
end Generator;

architecture Behavioral of Generator is

component AND_gate
port(A, B: in std_logic; O: out std_logic);
end component;

component XOR_gate
port(A, B: in std_logic; O: out std_logic);
end component;

begin

Chip_XOR : XOR_gate
port map(A, B, P_out);


Chip_AND : AND_gate
port map(A, B, G_out);

end Behavioral;