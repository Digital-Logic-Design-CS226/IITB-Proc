library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_write is
port (opcode : in std_logic_vector (3 downto 0);
rb,alu_out : in std_logic_vector (15 downto 0);
output : out std_logic_vector (15 downto 0));
end entity;

architecture behavourial of PC_write is
	
	signal output_temp : std_logic_vector(15 downto 0);
	
begin 
	process(opcode, rb, alu_out)
	begin
		if (opcode = "1001") then
			output_temp <= rb;
		else 
			output_temp <= alu_out;
		end if;
	end process;
	output <= output_temp;
end behavourial;
				
			
				
				
				
				 
				