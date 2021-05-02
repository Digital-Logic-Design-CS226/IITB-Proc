library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_input_logic is
	port ( clk : in std_logic;
			 opcode : in std_logic_vector (3 downto 0);
			 ra,rb,imm6,imm9,pc : in std_logic_vector (15 downto 0);
			 pc_update,control : in std_logic;
			 alu_a, alu_b : out std_logic_vector (15 downto 0);
			 to_nand : out std_logic);
end entity;

architecture behavourial of ALU_input_logic is
	
	signal one : std_logic_vector(15 downto 0) := "0000000000000001";
	signal alu_a_store,alu_b_store : std_logic_vector(15 downto 0);
	signal to_nand_store : std_logic := '0';
	
begin 

	alu_a <= alu_a_store;
	alu_b <= alu_b_store;
	to_nand <= to_nand_store;
	process(clk)
	begin
		if (rising_edge(clk)) then	
			if (control='1') then
				if (pc_update='1') then
					if (opcode="1100" and ra=rb) then -- BEQ
						alu_a_store <= pc;
						alu_b_store <= imm6;
					
					elsif (opcode="1000") then --Jump
						alu_a_store <= pc;
						alu_b_store <= imm9;
						
					else 
						alu_a_store <= pc;
						alu_b_store <= one;
					end if;
					
				else 
					if (opcode="0000" or opcode="0010") then --add or nand
						alu_a_store <= ra;
						alu_b_store <= rb;
					
					elsif (opcode="0001") then --lw
						alu_a_store <= ra;
						alu_b_store <= imm6;
					
					elsif (opcode="0100" or opcode="0101") then --sw
						alu_a_store <= rb;
						alu_b_store <= imm6;
					end if;
					
					if (opcode="0010") then 
						to_nand_store <= '1';
					else 
						to_nand_store <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;
end behavourial;
				
			
				
				
				
				 
				