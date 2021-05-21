library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Instruction_memory  is
port (pc : in std_logic_vector (15 downto 0);
instruction : out std_logic_vector (15 downto 0));
end entity;

architecture behaviour of Instruction_memory is

signal output : std_logic_vector(15 downto 0) := (others => '0');
--2^16 short word memory
type mem is array(2**16-1 downto 0) of std_logic_vector(15 downto 0);
signal memory : mem;
 
begin
	process(pc)
	begin
		output <= memory(to_integer(unsigned(pc)));
	end process;
	instruction <= output;
end behaviour;
