library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;


entity Status_Registers is 
port (
C_in : in std_logic;
Z_in : in std_logic;
C_alu : in std_logic;
Z_alu : in std_logic;
reg_write : in std_logic;
C_out : out std_logic;
Z_out : out std_logic;
clk : in std_logic);
end entity;


architecture behaviour of Status_Registers is

signal registers : std_logic_vector(1 downto 0) := "00";
signal to_update : std_logic := '0';

begin
	process(clk)
	begin
	
	if(rising_edge(clk)) then
		if (reg_write = '1') then
			to_update <= ((not(C_in) and not(Z_in) ) or ( C_in and registers(0) and not(Z_in) ) or ( Z_in and registers(1) and not(C_in) ));
			registers(1) <= ( (to_update and C_alu) or ( not(to_update) and registers(0) ) );
			registers(0) <= ( (to_update and Z_alu) or ( not(to_update) and registers(1) ) );
		end if;
	end if;
	end process;
	C_out <= registers(1);
	Z_out <= registers(0);
end behaviour;