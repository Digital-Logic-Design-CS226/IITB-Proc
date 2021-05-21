library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity GroupGenerator is
    Port ( G_curr : in std_logic;
         G_prev : in std_logic;
         P_curr : in std_logic;
			G_out: out std_logic);
end GroupGenerator;

architecture Behavioral of GroupGenerator is
signal T : std_logic;

component AND_gate
port(A, B: in std_logic; O: out std_logic);
end component;

component OR_gate
port(A, B: in std_logic; O: out std_logic);
end component;

begin

Chip_AND : AND_gate
port map(G_prev, P_curr, T);


Chip_OR : OR_gate
port map(T, G_curr, G_out);

end Behavioral;