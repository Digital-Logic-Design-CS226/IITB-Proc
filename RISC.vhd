library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RISC  is
--port ( rst: in std_logic;
--indata_received : out std_logic_vector (15 downto 0);
--clk: in std_logic);
	port ( rst: in std_logic;
	indata_received : out std_logic_vector (15 downto 0);
reg_0 : out std_logic_vector(15 downto 0);
reg_1 : out std_logic_vector(15 downto 0);
reg_2 : out std_logic_vector(15 downto 0);
reg_3 : out std_logic_vector(15 downto 0);
reg_4 : out std_logic_vector(15 downto 0);
reg_5 : out std_logic_vector(15 downto 0);
reg_6 : out std_logic_vector(15 downto 0);
reg_7 : out std_logic_vector(15 downto 0);
PC_out_1 : out std_logic_vector(15 downto 0);
Instruction_returned : out std_logic_vector(15 downto 0);
cpc_wrt : out std_logic;
cir_write : out std_logic;
creg_read : out std_logic;
creg_write : out std_logic;
cpc_update : out std_logic;
cstatus_reg_write : out std_logic;
cLA_SA_reg_write : out std_logic;
cmem_read : out std_logic;
cmem_write : out std_logic;
cwhich_reg : out std_logic_vector(2 downto 0);
cSA_which_reg_control : out std_logic;
opcode_out : out std_logic_vector(3 downto 0);
data_RF_out : out std_logic_vector(15 downto 0);
ALU_output_tb : out std_logic_vector(15 downto 0);
ALU_A_out : out std_logic_vector (15 downto 0);
ALU_B_out : out std_logic_vector (15 downto 0);
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
--signal reg_0 : std_logic_vector(15 downto 0);
--signal reg_1 : std_logic_vector(15 downto 0);
--signal reg_2 : std_logic_vector(15 downto 0);
--signal reg_3 : std_logic_vector(15 downto 0);
--signal reg_4 : std_logic_vector(15 downto 0);
--signal reg_5 : std_logic_vector(15 downto 0);
--signal reg_6 : std_logic_vector(15 downto 0);
--signal reg_7 : std_logic_vector(15 downto 0);
--signal PC_out_1 : std_logic_vector(15 downto 0);
--signal Instruction_returned : std_logic_vector(15 downto 0);
--signal cpc_wrt : std_logic;
--signal cir_write : std_logic;
--signal creg_read : std_logic;
--signal creg_write : std_logic;
--signal cpc_update : std_logic;
--signal cstatus_reg_write : std_logic;
--signal cLA_SA_reg_write : std_logic;
--signal cmem_read : std_logic;
--signal cmem_write : std_logic;
--signal cwhich_reg : std_logic_vector(2 downto 0);
--signal cSA_which_reg_control : std_logic;
--signal opcode_out : std_logic_vector(3 downto 0);
--signal data_RF_out : std_logic_vector(15 downto 0);
--signal ALU_output_tb : std_logic_vector(15 downto 0);
--signal ALU_A_out : std_logic_vector (15 downto 0);
--signal ALU_B_out : std_logic_vector (15 downto 0);
--


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
indata_received : out std_logic_vector (15 downto 0);
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
reg_0 : out std_logic_vector(15 downto 0);
reg_1 : out std_logic_vector(15 downto 0);
reg_2 : out std_logic_vector(15 downto 0);
reg_3 : out std_logic_vector(15 downto 0);
reg_4 : out std_logic_vector(15 downto 0);
reg_5 : out std_logic_vector(15 downto 0);
reg_6 : out std_logic_vector(15 downto 0);
reg_7 : out std_logic_vector(15 downto 0);
PC_out_1 : out std_logic_vector(15 downto 0);
Instruction_returned : out std_logic_vector(15 downto 0);
data_RF_out : out std_logic_vector(15 downto 0);
ALU_output_tb : out std_logic_vector(15 downto 0);
ALU_A_out : out std_logic_vector (15 downto 0);
ALU_B_out : out std_logic_vector (15 downto 0);
clk: in std_logic;
rst: in std_logic);
end component;

begin
	CU : component Control_unit port map (opcode, pc_wrt, ir_write, reg_read, reg_write, pc_update, status_reg_write,
							LA_SA_reg_write, mem_read, mem_write, which_reg, SA_which_reg_control, clk, rst);
	DP : component Data_path port map (opcode, indata_received, pc_wrt, ir_write, reg_read, reg_write, pc_update, status_reg_write,
							LA_SA_reg_write, mem_read, mem_write, which_reg, SA_which_reg_control, reg_0, reg_1, reg_2, reg_3, reg_4, reg_5, reg_6, reg_7, 
							PC_out_1, Instruction_returned, data_RF_out, ALU_output_tb, ALU_A_out, ALU_B_out, clk, rst);

							
cpc_wrt <= pc_wrt;
cir_write <= ir_write;
creg_read <= reg_read;
creg_write <= reg_write;
cpc_update <= pc_update;
cstatus_reg_write <= status_reg_write;
cLA_SA_reg_write <= LA_SA_reg_write;
cmem_read <= mem_read;
cmem_write <= mem_write;
cwhich_reg <= which_reg;
cSA_which_reg_control <= SA_which_reg_control;
opcode_out <= opcode;

end behaviour;
