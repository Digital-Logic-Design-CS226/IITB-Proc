library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Register_file  is
port ( R1 : in std_logic_vector (2 downto 0);
R2 : in std_logic_vector (2 downto 0);
R3 : in std_logic_vector (2 downto 0);
reg_read : in std_logic;
reg_write : in std_logic;
data_write : in std_logic_vector (15 downto 0);
out_R1 : out std_logic_vector (15 downto 0);
out_R2 : out std_logic_vector (15 downto 0);
reg_0 : out std_logic_vector(15 downto 0);
reg_1 : out std_logic_vector(15 downto 0);
reg_2 : out std_logic_vector(15 downto 0);
reg_3 : out std_logic_vector(15 downto 0);
reg_4 : out std_logic_vector(15 downto 0);
reg_5 : out std_logic_vector(15 downto 0);
reg_6 : out std_logic_vector(15 downto 0);
reg_7 : out std_logic_vector(15 downto 0);
clk: in std_logic);
end entity;

architecture behaviour of Register_file is

signal out_R1_temp : std_logic_vector(15 downto 0) := (others => '0');
signal out_R2_temp : std_logic_vector(15 downto 0) := (others => '0');
--8 16-bit registers
type reg is array(7 downto 0) of std_logic_vector(15 downto 0);
signal registers: reg;

 
begin




	process(clk, reg_write, reg_read)
	begin
	if(rising_edge(clk)) then
			if (reg_write = '1') then
				registers(to_integer(unsigned(R3))) <= data_write;
			elsif (reg_read = '1') then
				out_R1_temp <= registers(to_integer(unsigned(R1)));
				out_R2_temp <= registers(to_integer(unsigned(R2)));
			end if;
	end if;
	end process;
	out_R1 <= out_R1_temp;
	out_R2 <= out_R2_temp;
	
	reg_0 <= registers(0);
	reg_1 <= registers(1);
	reg_2 <= registers(2);
	reg_3 <= registers(3);
	reg_4 <= registers(4);
	reg_5 <= registers(5);
	reg_6 <= registers(6);
	reg_7 <= registers(7);
	
end behaviour;
