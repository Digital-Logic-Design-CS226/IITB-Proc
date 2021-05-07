library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memory_address_input  is
port ( opcode : in std_logic_vector (3 downto 0);
alu_out : in std_logic_vector (15 downto 0);
la_sa_wire : in std_logic_vector (15 downto 0);
outdata : out std_logic_vector (15 downto 0);
clk: in std_logic);
end entity;

architecture behaviour of memory_address_input is

signal address: std_logic_vector(15 downto 0) := (others => '0');
 
begin
	process(clk)
	begin
	if(rising_edge(clk)) then
			if (opcode = "0100") or (opcode = "0101") then
				address <= alu_out;
			elsif (opcode = "0110") or (opcode = "0111")then
				address <= la_sa_wire;
			end if;
	end if;
	end process;
	outdata <= address;
end behaviour;
