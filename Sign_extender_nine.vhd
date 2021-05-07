library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Sign_extender form 9 bits to 16 bits
entity Sign_extender_nine  is
port ( input : in std_logic_vector(8 downto 0);
output : out std_logic_vector(15 downto 0);
clk : in std_logic);
end entity;

architecture behaviour of Sign_extender_nine is

signal output_temp : std_logic_vector(15 downto 0);

 
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			output_temp <= std_logic_vector(resize(signed(input), output_temp'length));
		end if;
	end process;
	output <= output_temp;
end behaviour;
