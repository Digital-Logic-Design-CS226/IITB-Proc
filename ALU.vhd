
library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU  is
port ( clk : in std_logic;
in1 : in std_logic_vector (15 downto 0);
in2 : in std_logic_vector (15 downto 0);
outc : out std_logic;
outz : out std_logic;
decide : in std_logic;
output : out std_logic_vector (15 downto 0));
end entity;

architecture behaviour of ALU is

signal outc_temp : std_logic;
signal outz_temp1 : std_logic;
signal outz_temp2 : std_logic;
signal outz_temp : std_logic;
signal output_temp1 : std_logic_vector(15 downto 0) := "0000000000000000";
signal output_temp2 : std_logic_vector(15 downto 0) := "0000000000000000";
signal output_temp : std_logic_vector(15 downto 0);
signal clock_counter : integer range 0 to 4;
signal last_in1, last_in2, last_out : std_logic_vector(15 downto 0) := "0000000000000000";
signal last_c, last_z : std_logic;



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
	ADD : component SixteenbitKogStonAddSub port map (in1 , in2, '0', output_temp1, outc_temp, outz_temp1);
	NAND_map : component SixteenbitNAND port map (in1 , in2, output_temp2, outz_temp2);


	process(in1, in2, decide, clk)
	begin
		if not((in1(0) = last_in1(0)) and (in1(1) = last_in1(1)) and (in1(2) = last_in1(2)) and (in1(3) = last_in1(3)) and 
				 (in1(4) = last_in1(4)) and (in1(5) = last_in1(5)) and (in1(6) = last_in1(6)) and (in1(7) = last_in1(7)) and 
				 (in1(8) = last_in1(8)) and (in1(9) = last_in1(9)) and (in1(10) = last_in1(10)) and (in1(11) = last_in1(11)) and 
				 (in1(12) = last_in1(12)) and (in1(13) = last_in1(13)) and (in1(14) = last_in1(14)) and (in1(15) = last_in1(15)) and 
				 (in2(0) = last_in2(0)) and (in2(1) = last_in2(1)) and (in2(2) = last_in2(2)) and (in2(3) = last_in2(3)) and 
				 (in2(4) = last_in2(4)) and (in2(5) = last_in2(5)) and (in2(6) = last_in2(6)) and (in2(7) = last_in2(7)) and 
				 (in2(8) = last_in2(8)) and (in2(9) = last_in2(9)) and (in2(10) = last_in2(10)) and (in2(11) = last_in2(11)) and 
				 (in2(12) = last_in2(12)) and (in2(13) = last_in2(13)) and (in2(14) = last_in2(14)) and (in2(15) = last_in2(15))) then
				clock_counter <= 0;
				output <= last_out;
				outz <= last_z;
				last_in1 <= in1;
				last_in2 <= in2;
		elsif(decide = '0') then
			if clock_counter = 4 then
			clock_counter <= 0;
			output <= output_temp1;
			outz <= outz_temp1;
			last_out <= output_temp1;
			last_z <= outz_temp1;
			else	
			clock_counter <= clock_counter + 1;
			output <= last_out;
			outz <= last_z;
			end if;
		else
			if clock_counter = 4 then
			clock_counter <= 0;
			output <= output_temp2;
			outz <= outz_temp2;
			last_out <= output_temp2;
			last_z <= outz_temp2;
			else	
			clock_counter <= clock_counter + 1;
			output <= last_out;
			outz <= last_z;
			end if;
		end if;
	end process;
	outc <= outc_temp;
	--outz <= outz_temp;
	--	output <= output_temp;
end behaviour;
