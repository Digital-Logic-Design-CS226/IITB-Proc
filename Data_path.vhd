library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Data_path  is
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
end entity;

architecture behaviour of Data_path is

signal pc_in : std_logic_vector(15 downto 0) := (others => '0');
signal pc_out : std_logic_vector(15 downto 0);
signal instruction : std_logic_vector(15 downto 0);
signal opcode: std_logic_vector(3 downto 0);
signal RA : std_logic_vector(2 downto 0);
signal RB : std_logic_vector(2 downto 0);
signal RC : std_logic_vector(2 downto 0);
signal cz : std_logic_vector(1 downto 0);
signal imm6 : std_logic_vector(5 downto 0);
signal imm9 : std_logic_vector(8 downto 0);
signal RF_R3 : std_logic_vector(2 downto 0);
signal data_RF_in : std_logic_vector(15 downto 0);
signal out_RA: std_logic_vector(15 downto 0);
signal out_RB : std_logic_vector(15 downto 0);
signal ALU_out : std_logic_vector(15 downto 0);
signal mem_out : std_logic_vector (15 downto 0);
signal imm6_ext : std_logic_vector (15 downto 0);
signal imm9_ext : std_logic_vector (15 downto 0);
signal ALU_A : std_logic_vector (15 downto 0);
signal ALU_B : std_logic_vector (15 downto 0);
signal to_nand : std_logic;
signal ALU_c : std_logic;
signal ALU_z : std_logic;
signal C_out : std_logic;
signal Z_out : std_logic;
signal LA_SA_wire : std_logic_vector(15 downto 0);
signal mem_add_in : std_logic_vector(15 downto 0);
signal RA_RF : std_logic_vector(2 downto 0);

component PC
port ( indata : in std_logic_vector (15 downto 0);
pc_wrt : in std_logic;
outdata : out std_logic_vector (15 downto 0);
clk: in std_logic;
rst: in std_logic);
end component;

component Instruction_memory
port (pc : in std_logic_vector (15 downto 0);
instruction : out std_logic_vector (15 downto 0));
end component;

component Instruction_register
port ( indata : in std_logic_vector (15 downto 0);
ir_write : in std_logic;
opcode : out std_logic_vector (3 downto 0);
R1 : out std_logic_vector (2 downto 0);
R2 : out std_logic_vector (2 downto 0);
R3 : out std_logic_vector (2 downto 0);
cz : out std_logic_vector (1 downto 0);
imm6 : out std_logic_vector (5 downto 0);
imm9 : out std_logic_vector (8 downto 0));
end component;

component RF_input_process
port ( opcode : in std_logic_vector (3 downto 0);
R1 : in std_logic_vector (2 downto 0);
R2 : in std_logic_vector (2 downto 0);
R3 : in std_logic_vector (2 downto 0);
which_reg : in std_logic_vector (2 downto 0);
output : out std_logic_vector (2 downto 0));

end component;

component Register_file
port ( R1 : in std_logic_vector (2 downto 0);
R2 : in std_logic_vector (2 downto 0);
R3 : in std_logic_vector (2 downto 0);
reg_read : in std_logic;
reg_write : in std_logic;
data_write : in std_logic_vector (15 downto 0);
out_R1 : out std_logic_vector (15 downto 0);
out_R2 : out std_logic_vector (15 downto 0);
clk: in std_logic);
end component;

component RF_datain_process
port ( opcode : in std_logic_vector (3 downto 0);
imm9 : in std_logic_vector (8 downto 0);
mem_out : in std_logic_vector (15 downto 0);
PC : in std_logic_vector (15 downto 0);
ALU_out : in std_logic_vector (15 downto 0);
data_RF_in : out std_logic_vector (15 downto 0));
end component;

component Sign_extender_nine
port ( input : in std_logic_vector(8 downto 0);
output : out std_logic_vector(15 downto 0));
end component;

component Sign_extender_six
port ( input : in std_logic_vector(5 downto 0);
output : out std_logic_vector(15 downto 0));
end component;

component ALU_input_logic
port ( opcode : in std_logic_vector (3 downto 0);
ra,rb,imm6,imm9,pc, la_sa : in std_logic_vector (15 downto 0);
pc_update : in std_logic;
alu_a, alu_b : out std_logic_vector (15 downto 0);
to_nand : out std_logic);
end component;

component ALU
port ( in1 : in std_logic_vector (15 downto 0);
in2 : in std_logic_vector (15 downto 0);
outc : out std_logic;
outz : out std_logic;
decide : in std_logic;
output : out std_logic_vector (15 downto 0));
end component;

component Status_Registers
port (
C_in : in std_logic;
Z_in : in std_logic;
C_alu : in std_logic;
Z_alu : in std_logic;
reg_write : in std_logic;
C_out : out std_logic;
Z_out : out std_logic;
clk : in std_logic);
end component;

component PC_write
port ( opcode : in std_logic_vector (3 downto 0);
rb,alu_out : in std_logic_vector (15 downto 0);
output : out std_logic_vector (15 downto 0));
end component;

component memory
port ( indata : in std_logic_vector (15 downto 0);
address : in std_logic_vector (15 downto 0);
mem_read : in std_logic;
mem_write : in std_logic;
outdata : out std_logic_vector (15 downto 0);
clk: in std_logic);
end component;

component Temp_LA_SA
port ( from_reg : in std_logic;
out_RA : in std_logic_vector ( 15 downto 0);
ALU_out : in std_logic_vector ( 15 downto 0);
reg_write : in std_logic;
output : out std_logic_vector (15 downto 0);
clk: in std_logic);
end component;

component memory_address_input
port ( opcode : in std_logic_vector (3 downto 0);
alu_out : in std_logic_vector (15 downto 0);
la_sa_wire : in std_logic_vector (15 downto 0);
outdata : out std_logic_vector (15 downto 0));
end component;

component RF_RA_input
port ( RA : in std_logic_vector (2 downto 0);
which_reg : in std_logic_vector (2 downto 0);
which_reg_SA_control : in std_logic;
RA_RF : out std_logic_vector (2 downto 0));
end component;


begin

chip_PC : PC
port map(pc_in, pc_wrt, pc_out, clk, rst);

chip_IM : Instruction_memory
port map(pc_out, instruction);

chip_IR : Instruction_register
port map(instruction, ir_write, opcode, RA, RB, RC, cz, imm6, imm9);

chip_RF_ip : RF_input_process 
port map(opcode, RA, RB, RC, which_reg, RF_R3);

chip_RF : Register_file
port map(RA_RF, RB, RF_R3, reg_read, reg_write, data_RF_in , out_RA, out_RB, clk);

chip_RF_data_in : RF_datain_process
port map(opcode, imm9, mem_out, pc_out, ALU_out, data_RF_in);

chip_sign_extender_six : Sign_extender_six
port map(imm6, imm6_ext);

chip_sign_extender_nine : Sign_extender_nine
port map(imm9, imm9_ext);

chip_ALU_input_logic : ALU_input_logic
port map(opcode, out_RA, out_RB, imm6_ext, imm9_ext, pc_out, LA_SA_wire, pc_update, ALU_A, ALU_B, to_nand);

chip_ALU : ALU
port map(ALU_A, ALU_B, ALU_c, ALU_z, to_nand, ALU_out);

chip_SReg : Status_Registers
port map(cz(1), cz(0), ALU_c, ALU_z, status_reg_write, C_out, Z_out, clk);

chip_PC_write : PC_write 
port map(opcode, out_RB, ALU_out, PC_in);

chip_LA_SA : Temp_LA_SA
port map(SA_which_reg_control, out_RA, ALU_out, LA_SA_reg_write, LA_SA_wire, clk);

chip_memory_address_input : memory_address_input
port map(opcode, ALU_out, LA_SA_wire, mem_add_in);

chip_memory : memory
port map(out_RA , mem_add_in , mem_read, mem_write, mem_out, clk);

chip_RF_RA_input : RF_RA_input
port map(RA, which_reg, SA_which_reg_control, RA_RF);

opcode_out <= opcode;

end behaviour;
