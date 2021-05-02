library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Status_Register is 
port (
C_in : in std_logic;
Z_in : in std_logic;
C_alu : in std_logic;
Z_alu : in std_logic;
reg_read : in std_logic;
reg_write : in std_logic;
C_out : in std_logic;
Z_out : in std_logic;
clk : in std_logic;
)

architecture behaviour of Status_Register is

signal registers : std_logic_vector(1 downto 0);

begin
	process(clk)
	begin
	
	if(rising_edge(clk)) then
		if (reg_read = '1') then
			C_out <= registers(0);
			Z_out <= registers(1);
		elsif (reg_write = '1') then
			to_update <= ((C_in = '0' and Z_in = '0') or (C_in = '1' and registers(0) = '1' and Z_in = '0') or (Z_in = '1' and registers(1) = '1' and C_in = '0'));
			registers(0) <= ( (to_update and C_alu) or ( not(to_update) and registers(0) ) );
			registers(1) <= ( (to_update and Z_alu) or ( not(to_update) and registers(1) ) );
		end if;
	end if;
	end process;
end behaviour;