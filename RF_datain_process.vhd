library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity RF_datain_process  is
port ( opcode : in std_logic_vector (3 downto 0);
imm9 : in std_logic_vector (8 downto 0);
mem_out : in std_logic_vector (15 downto 0);
PC : in std_logic_vector (15 downto 0);
ALU_out : in std_logic_vector (15 downto 0);
data_RF_in : out std_logic_vector (15 downto 0));
end entity;

architecture behaviour of RF_datain_process is

signal output : std_logic_vector(15 downto 0) := (others => '0');
signal imm9_temp : std_logic_vector(15 downto 0);
 
begin
	process(opcode, imm9, mem_out, PC, ALU_out)
	begin
		if(opcode = "0001") or (opcode = "0001") or (opcode = "0010") then
			output <= ALU_out;
		elsif (opcode = "0011") then
			output(15 downto 7) <= imm9;
			output(6 downto 0) <= "0000000";
			--output <= imm9_temp;
		elsif (opcode = "1000") or (opcode = "1001") then
			output <= PC;
		elsif (opcode = "0100") or (opcode = "0110") then
			output <= mem_out;
		end if;
	end process;
	data_RF_in <= output;
end behaviour;
