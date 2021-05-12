library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Control_unit  is
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
SA_which_reg_control : in std_logic;
clk: in std_logic;
rst: in std_logic);
end entity;

architecture behaviour of Control_unit is

type States is (start, S0, S1, S2, S3);
signal pstate: States;
signal nstate: States;
-- those output signals
signal pc_wrt_t : out std_logic;
signal ir_write_t : out std_logic;
signal reg_read_t : out std_logic;
signal reg_write_t : out std_logic;
signal pc_update_t : out std_logic;
signal status_reg_write_t : out std_logic;
signal LA_SA_reg_write_t : out std_logic;
signal mem_read_t : out std_logic;
signal mem_write_t : out std_logic;
signal which_reg_t : out std_logic_vector(2 downto 0);

begin
	process(clk, rst)
	begin
	if(rising_edge(clk)) then
			if (rst = '1') then
				pstate <= start;
			else 
				pstate <= nstate;
			end if;
	end if;
	end process;
	
	process(pstate, clk)
	begin
	if(rising_edge(clk)) then
		case pstate is
			when start =>
				nstate <= S0;
			when S0 =>
				nstate <= S1;
			when S1 =>
				nstate <= S2;
			when S2 =>
				nstate <= S3;
			when S3 =>
				nstate <= S0;
		end case;
	end if;
	end process;
	
	process(clk)
	begin
	if(rising_edge(clk)) then
		case pstate is
			when start =>
				nstate <= S0;
			when S0 =>
				nstate <= S1;
			when S1 =>
				nstate <= S2;
			when S2 =>
				nstate <= S3;
			when S3 =>
				nstate <= S0;
		end case;
	outc <= outc_temp;
	outz <= outz_temp;
	output <= output_temp;
end behaviour;
