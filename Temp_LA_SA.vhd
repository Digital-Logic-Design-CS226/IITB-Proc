library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Temp_LA_SA  is
port ( from_reg : in std_logic;
out_RA : in std_logic_vector ( 15 downto 0);
ALU_out : in std_logic_vector ( 15 downto 0);
reg_write : in std_logic;
output : out std_logic_vector (15 downto 0);
clk: in std_logic);
end entity;

architecture behaviour of Temp_LA_SA is

signal store : std_logic_vector(15 downto 0) := (others => '0');
 
begin
	process(clk, reg_write)
	begin
	if(rising_edge(clk)) then
		if (reg_write = '1') then
			if (from_reg = '0') then
				store <= out_RA;
			elsif (from_reg = '1') then
				store <= ALU_out;
			end if;
		end if;
	end if;
	end process;
	output <= store;
end behaviour;
