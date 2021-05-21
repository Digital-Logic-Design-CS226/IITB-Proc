library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RISC  is
port ( rst: in std_logic;
clk: in std_logic);
end entity;

architecture behaviour of RISC is

signal opcode : std_logic_vector(3 downto 0);

-- various controls
signal pc_wrt : std_logic;
signal ir_write : std_logic;
signal reg_read : std_logic;
signal reg_write : std_logic;
signal pc_update : std_logic;
signal status_reg_write : std_logic;
signal LA_SA_reg_write : std_logic;
signal mem_read : std_logic;
signal mem_write : std_logic;
signal which_reg : std_logic_vector(2 downto 0);
signal SA_which_reg_control : std_logic;


component Control_unit
port ( opcode: in std_logic_vector(3 downto 0);
pc_wrt : out std_logic;
ir_write : out std_logic;
reg_read : out std_logic;
reg_write : out std_logic;
pc_update : out std_logic;
status_reg_write : out std_logic;
LA_SA_reg_write : out std_logic;
mem_read : out std_logic;
mem_write : out std_logic;
which_reg : out std_logic_vector(2 downto 0);
SA_which_reg_control : out std_logic;
clk: in std_logic;
rst: in std_logic);
end component;

component Data_path is
port ( opcode_out : out std_logic_vector (3 downto 0);
pc_wrt : in std_logic;
ir_write : in std_logic;
reg_read : in std_logic;
reg_write : in std_logic;
pc_update : in std_logic;
status_reg_write : in std_logic;
LA_SA_reg_write : in std_logic;
mem_read : in std_logic;
mem_write : in std_logic;
which_reg : in std_logic_vector(2 downto 0);
SA_which_reg_control : in std_logic;
clk: in std_logic;
rst: in std_logic);
end component;

begin
	CU : component Control_unit port map (opcode, pc_wrt, ir_write, reg_read, reg_write, pc_update, status_reg_write,
							LA_SA_reg_write, mem_read, mem_write, which_reg, SA_which_reg_control, clk, rst);
	DP : component Data_path port map (opcode, pc_wrt, ir_write, reg_read, reg_write, pc_update, status_reg_write,
							LA_SA_reg_write, mem_read, mem_write, which_reg, SA_which_reg_control, clk, rst);
end behaviour;
