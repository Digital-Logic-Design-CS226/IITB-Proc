library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memory  is
port ( indata : in std_logic_vector (15 downto 0);
address : in std_logic_vector (15 downto 0);
mem_read : in std_logic;
mem_write : in std_logic;
outdata : out std_logic_vector (15 downto 0);
clk: in std_logic);
end entity;

architecture behaviour of memory is

signal output : std_logic_vector(15 downto 0) := (others => '0');
--2^16 short word memory
type mem is array(2**16-1 downto 0) of std_logic_vector(15 downto 0);
signal memory : mem;
 
begin
	process(clk)
	begin
	if(rising_edge(clk)) then
			if(mem_write = '1') then
				memory(to_integer(unsigned(address))) <= indata;
			elsif (mem_read = '1') then
				output <= memory(to_integer(unsigned(address)));
			end if;
	end if;
	end process;
	outdata <= output;
end behaviour;
