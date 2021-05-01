library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Sign_extender form 6 bits to 16 bits
entity Sign_extender_six  is
port ( input : in std_logic_vector(5 downto 0);
output : out std_logic_vector(15 downto 0));
end entity;

architecture behaviour of Sign_extender_six is

signal output_temp : std_logic_vector(15 downto 0);

 
begin
	output_temp <= std_logic_vector(resize(signed(input), output_temp'length));
	output <= output_temp;
end behaviour;
