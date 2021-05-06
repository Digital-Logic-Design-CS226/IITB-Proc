library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Control_unit  is
port ( opcode: in std_logic_vector(3 downto 0);
-- various signals that will be output
clk: in std_logic;
rst: in std_logic);
end entity;

architecture behaviour of Control_unit is

type States is (start, S0, S1, S2, S3);
signal pstate: States;
signal nstate: States;
-- those output signals

begin
	process(clk, rst)
	begin
	if(rising_edge(clk)) then
			if (not reset = '1') then
				pstate <= start;
			else 
				pstate <= nstate;
			end if;
	end if;
	end process;
	outc <= outc_temp;
	outz <= outz_temp;
	output <= output_temp;
end behaviour;
