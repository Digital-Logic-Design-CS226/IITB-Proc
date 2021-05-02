library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is 
port ( a, b : in std_logic_vector (15 downto 0);
C_in: in std_logic;
Z_in: in std_logic;
C_flag: in std_logic;
Z_flag: in std_logic;
op : in std_logic_vector;
z: out std_logic_vector (15 downto 0);
C_out: out std_logic;
Z_out: out std_logic);
end entity;

architecture behaviour of ALU is 

component SixteenbitKogStonAddSub is
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

signal condition = std_logic;
signal z_temp_1 : std_logic_vector(15 downto 0);
signal C_temp_1 : std_logic;
signal Z_temp_1 : std_logic;
signal z_temp_2 : std_logic_vector(15 downto 0);
signal C_temp_2 : std_logic;
signal Z_temp_2 : std_logic;
signal C_temp : std_logic;
signal Z_temp : std_logic;

begin

condition <= ((C_in = '0' and Z_in = '0') or (C_in = '1' and C_flag = '1' and Z_in = '0') or (Z_in = '1' and Z_flag = '1' and C_in = '0'));

Adder SixteenbitKogStonAddSub is 
port map( a => a, b => b, cin => '0', sum => z_temp_1, cout => C_temp_1, z => Z_temp_1);

NANDER SixteenbitNand is 
port map( a => a, b => b, output => z_temp_2, z => Z_temp_2);

C_temp_2 <= C_flag;

z <= z_temp_1 when op = '1' else z_temp_2;

C_temp <= C_temp_1 when op = '1' else C_temp_2;
Z_temp <= Z_temp_1 when op = '1' else Z_temp_2;

C_out <= C_temp when condition = '1' else C_flag;
Z_out <= Z_temp when condition = '1' else Z_flag;

end behaviour;