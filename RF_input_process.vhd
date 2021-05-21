library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RF_input_process  is
port ( opcode : in std_logic_vector (3 downto 0);
which_reg : in std_logic_vector (2 downto 0);
R1 : in std_logic_vector (2 downto 0);
R2 : in std_logic_vector (2 downto 0);
R3 : in std_logic_vector (2 downto 0);
output : out std_logic_vector (2 downto 0));
end entity;

architecture behaviour of RF_input_process is

signal output_temp : std_logic_vector(2 downto 0) := (others => '0');
 
begin
	process(opcode, which_reg, R1, R2, R3)
	begin
		if (opcode = "0000") or (opcode = "0010") then
			output_temp <= R3;
		elsif (opcode = "0001") then
			output_temp <= R2;
		elsif (opcode = "0011") or (opcode = "0100") or (opcode = "1000") or (opcode = "1001") then
			output_temp <= R1;
		elsif (opcode = "0110") then
			output_temp <= which_reg;
		end if;
	end process;
	output <= output_temp;
end behaviour;
