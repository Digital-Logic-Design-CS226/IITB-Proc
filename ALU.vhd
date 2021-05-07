library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU  is
port ( in1 : in std_logic_vector (15 downto 0);
in2 : in std_logic_vector (15 downto 0);
outc : out std_logic;
outz : out std_logic;
decide : in std_logic;
output : out std_logic_vector (15 downto 0);
clk: in std_logic);
end entity;

architecture behaviour of ALU is

signal outc_temp : std_logic;
signal outz_temp1 : std_logic;
signal outz_temp2 : std_logic;
signal outz_temp : std_logic;
signal output_temp1 : std_logic_vector(15 downto 0);
signal output_temp2 : std_logic_vector(15 downto 0);
signal output_temp : std_logic_vector(15 downto 0);


component SixteenbitKogStonAddSub
port ( a, b : in std_logic_vector (15 downto 0);
cin: in std_logic;
sum: out std_logic_vector (15 downto 0);
cout: out std_logic;
z: out std_logic);
end component;

component SixteenbitNAND is
port ( a, b : in std_logic_vector (15 downto 0);
output: out std_logic_vector (15 downto 0);
z: out std_logic);
end component;

begin
	ADD : component SixteenbitKogStonAddSub port map (in1 , in2, '0', output_temp1, outc_temp, outz_temp);
	NAND_map : component SixteenbitNAND port map (in1 , in2, output_temp2, outz_temp2);

	process(clk)
	begin
	if(rising_edge(clk)) then
			if(decide = '0') then
				output_temp <= output_temp1;
				outz_temp <= outz_temp1;
			else
				output_temp <= output_temp2;
				outz_temp <= outz_temp2;
			end if;
	end if;
	end process;
	outc <= outc_temp;
	outz <= outz_temp;
	output <= output_temp;
end behaviour;
