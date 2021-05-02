library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Status_Register is 
port (
D_in : in std_logic;
R_in : in std_logic;
reg_read : in std_logic;
reg_write : in std_logic;
D_out : out std_logic;
clk : in std_logic;
)

architecture behaviour of Status_Register is

signal registers : std_logic_vector(1 downto 0);

begin
	process(clk)
	begin
	
	if(rising_edge(clk)) then
		if (reg_read = '1') then
			D_out <= registers(to_integer(unsigned(R_in)));
		elsif (reg_write = '1') then
			registers(to_integer(unsigned(R_in))) <= D_in;
		end if;
	end if;
	end process;
end behaviour;