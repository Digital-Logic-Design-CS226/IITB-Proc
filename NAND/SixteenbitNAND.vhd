library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity SixteenbitNAND is
port ( a, b : in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0);
z: out std_logic);
end entity;

architecture Behavioral of SixteenbitNAND is

    signal x : std_logic_vector(15 downto 0);
    signal output_temp : std_logic_vector(15 downto 0);
	 
component AND_gate
port(A, B: in std_logic; O: out std_logic);
end component;

component NOT_gate
port(A, B: in std_logic; O: out std_logic);
end component;

begin
	AND_16bit: 
        for i in 0 to 15 generate
            AND_bit: component AND_gate PORT MAP(a(i), b(i), x(i) );
        end generate;
	NOT_16bit: 
        for i in 0 to 15 generate
            NOT_bit: component NOT_gate PORT MAP(x(i), output_temp(i) );
        end generate;
	
	z <= '1' when output_temp="0000000000000000" else '0'; 
   output <= output_temp;
end Behavioral;
