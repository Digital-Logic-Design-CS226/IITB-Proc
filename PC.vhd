library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity PC  is
port ( indata : in std_logic_vector (15 downto 0);
pc_wrt_s2 : in std_logic;
outdata : out std_logic_vector (15 downto 0);
clk: in std_logic;
rst: in std_logic);
end entity;

architecture behaviour of PC is

signal output : std_logic_vector(15 downto 0) := (others => '0');
 
begin
	process(clk, rst)
	begin
	if(rising_edge(clk)) or (falling_edge(rst)) then
			if(rst = '0') then
				output <= (others => '0');
			elsif (pc_wrt_s2 = '1') then
				output <= indata;
			end if;
	end if;
	end process;
	outdata <= output;
end behaviour;
