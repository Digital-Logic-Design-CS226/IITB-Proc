library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Status_register  is
port (inc : in std_logic;
inz : in std_logic;
status_reg_write : in std_logic;
is_data_valid : in std_logic;
status_reg_read : in std_logic;
outc : out std_logic;
outz : out std_logic;
clk: in std_logic);
end entity;

architecture behaviour of Status_register is

signal outc_temp : std_logic;
signal outz_temp : std_logic;
 
begin
	process(clk)
	begin
	if(rising_edge(clk)) then
			if (status_reg_write = '1') and (is_data_valid = '1') then
				outc_temp <= inc;
				outz_temp <= inz;
			elsif (status_reg_read = '1') then
				-- do nothing
			end if;
	end if;
	end process;
	outc <= outc_temp;
	outz <= outz_temp;
end behaviour;
