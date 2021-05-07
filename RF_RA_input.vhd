library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RF_RA_input  is
port ( RA : in std_logic_vector (2 downto 0);
which_reg : in std_logic_vector (2 downto 0);
which_reg_SA_control : in std_logic;
RA_RF : out std_logic_vector (2 downto 0);
clk: in std_logic);
end entity;

architecture behaviour of RF_RA_input is

signal RA_RF_store: std_logic_vector(2 downto 0) := (others => '0');
 
begin
	process(clk)
	begin
	if(rising_edge(clk)) then
			if (which_reg_SA_control = '0') then
				RA_RF_store <= RA;
			elsif (which_reg_SA_control = '1') then
				RA_RF_store <= which_reg;
			end if;
	end if;
	end process;
	RA_RF <= RA_RF_store;
end behaviour;
