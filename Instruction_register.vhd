library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity Instruction_register  is
port ( indata : in std_logic_vector (15 downto 0);
ir_write : in std_logic;
opcode : out std_logic_vector (3 downto 0);
R1 : out std_logic_vector (2 downto 0);
R2 : out std_logic_vector (2 downto 0);
R3 : out std_logic_vector (2 downto 0);
cz : out std_logic_vector (1 downto 0);
imm6 : out std_logic_vector (5 downto 0);
imm9 : out std_logic_vector (8 downto 0);
clk: in std_logic);
end entity;

architecture behaviour of Instruction_register is

signal opcode_store : std_logic_vector (3 downto 0);
signal R1_store : std_logic_vector (2 downto 0);
signal R2_store : std_logic_vector (2 downto 0);
signal R3_store : std_logic_vector (2 downto 0);
signal cz_store : std_logic_vector (1 downto 0);
signal imm6_store : std_logic_vector (5 downto 0);
signal imm9_store : std_logic_vector (8 downto 0);

begin
	process(clk)
	begin
	if(rising_edge(clk)) then
		if(ir_write = '1') then
			opcode_store <= indata(15 downto 12);
			R1_store <= indata(11 downto 9);
			R2_store <= indata(8 downto 6);
			R3_store <= indata(6 downto 4);
			cz_store <= indata(1 downto 0);
			imm6_store <= indata(5 downto 0);
			imm9_store <= indata(8 downto 0);
		end if;
	end if;
	end process;
	opcode <= opcode_store;
	R1 <= R1_store;
	R2 <= R2_store;
	R3 <= R3_store;
	cz <= cz_store;
	imm6 <= imm6_store;
	imm9 <= imm9_store;
end behaviour;
