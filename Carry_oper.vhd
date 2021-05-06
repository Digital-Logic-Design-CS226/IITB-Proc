library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity Carry_oper is
    Port ( G_prev : in std_logic;
           P_prev : in std_logic;
			  G_curr : in std_logic;
           P_curr : in std_logic;
           G_out : out std_logic;
           P_out : out std_logic);
end Carry_oper;

architecture Behavioral of Carry_oper is
signal T : std_logic;

component AND_gate
port(A, B: in std_logic; O: out std_logic);
End component;

component OR_gate
port(A, B: in std_logic; O: out std_logic);
End component;

begin

Chip_AND1 : AND_gate
port map(P_prev, P_curr, P_out);


Chip_AND2 : AND_gate
port map(P_curr, G_prev, T);

Chip_OR : OR_gate
port map(G_curr, T, G_out);

end Behavioral;