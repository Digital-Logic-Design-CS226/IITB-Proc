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
SA_which_reg_control : out std_logic;
clk: in std_logic;
rst: in std_logic);
end entity;

architecture behaviour of Control_unit is

type States is (start, S0, S1, S2, S3, S4, S5, S6, S7, S8);
signal pstate: States;
signal nstate: States;
-- those output signals
signal pc_wrt_t : std_logic;
signal ir_write_t : std_logic;
signal reg_read_t : std_logic;
signal reg_write_t : std_logic;
signal pc_update_t : std_logic;
signal status_reg_write_t : std_logic;
signal LA_SA_reg_write_t : std_logic;
signal mem_read_t : std_logic;
signal mem_write_t : std_logic;
signal which_reg_t : std_logic_vector(2 downto 0);
signal SA_which_reg_control_t : std_logic;
signal counter : integer range 0 to 7;
signal cycle_number : integer range 0 to 7;

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
			when S0 => --ir write
				if opcode = "0011" then
					nstate <= S3;
				else
					nstate <= S1;
				end if;
				which_reg_t <= "000";
				counter <= 0;
--				if opcode="0000" or opcode="0010" or opcode="0001" or opcode="0100" then
--					nstate <= S1; 
--				elsif opcode="0011" then
--					nstate <= S2;
--				end if;
			when S1 => --reg read
				if (cycle_number = 4) and (opcode="0000" or opcode="0010" or opcode="0001" or opcode="0100") then --or opcode="0101" then
					cycle_number <= 0;
					nstate <= S2;
				elsif (opcode="0000" or opcode="0010" or opcode="0001" or opcode="0100") then 
					cycle_number <= cycle_number + 1;
				elsif opcode="0011" then
					nstate <= S3;
				elsif opcode="1100" or opcode="1000" or opcode="1001" then
					nstate <= S4;
				elsif opcode="0101" then
					nstate <= S7;
				elsif opcode="0110" or opcode="0111" then
					nstate <= S8;
				end if;
			
			when S2 => --status reg
				if opcode="0000" or opcode="0010" or opcode="0001" then
					nstate <= S3;
				elsif opcode="0100" then
					nstate <= S6;
--				elsif opcode="0101" then
--					nstate <= S7;
				end if;
				
			when S3 => --reg write
				--S4
				if opcode="0000" or opcode="0010" or opcode="0001" or opcode="0011" or opcode="0100" then
					nstate <= S4;
				elsif opcode="0110" then
					if counter=7 then
						nstate <= S4;
					else 
						nstate <= S8;
					end if;
					counter <= counter + 1;
--					which_reg_t <= std_logic_vector(to_unsigned(to_integer(unsigned( in )) + 1, 3));
				end if;
					
			
			when S4 => --pc update
				if cycle_number = 4 then
					nstate <= S5;
					cycle_number <= 0;
				else
					cycle_number <= cycle_number + 1;
				end if;
--				if opcode="0000" or opcode="0010" or opcode="0001" or opcode="0011" then
--					nstate <= S4;
--				elsif 
--				end if;
			when S5 => --pc write
				nstate <= start;
			when S6 => --mem read
				if opcode="0100" or opcode="0110" then
					nstate <= S3;
				end if;
				which_reg_t <= std_logic_vector(to_unsigned(counter,3));
			when S7 => --mem write
				if opcode="0101" then
					nstate <= S4;
				elsif opcode="0111" then
					if counter=7 then
						nstate <= S4;
					else 
						nstate <= S8;
					end if;
				end if;
				counter <= counter + 1;
			when S8 =>
				if opcode="0110" then
					nstate <= S6;
				elsif opcode="0111" then
					nstate <= S7;
					which_reg_t <= std_logic_vector(to_unsigned(counter,3));
				end if;
					
				
			
		end case;
	end if;
	end process;
	
	process(clk)
	begin
	if(rising_edge(clk)) then
		case pstate is
			when start =>
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '0';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
				SA_which_reg_control_t <= '0';
--				counter <= 0;

			when S0 => --ir write
				pc_wrt_t <= '0';
				ir_write_t <= '1';
				reg_read_t <= '0';
				reg_write_t <= '0';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
				SA_which_reg_control_t <= '0';
				
			when S1 => --reg read
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '1';
				reg_write_t <= '0';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
				SA_which_reg_control_t <= '0';

				
			when S2 => --status reg write
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '0';
--				pc_update_t <= '0';
				status_reg_write_t <= '1';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
				SA_which_reg_control_t <= '0';
				
			when S3 => --reg write
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '1';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
--				SA_which_reg_control_t <= '0';
			
			when S4 => --pc update
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '0';
				pc_update_t <= '1';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
				SA_which_reg_control_t <= '0';
				
				
			when S5 => --pc write
				pc_wrt_t <= '1';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '0';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
				SA_which_reg_control_t <= '0';
				
			when S6 => --mem read
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '0';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '1';
				mem_write_t <= '0';
				SA_which_reg_control_t <= '1';
				
			when S7 => --mem write
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '0';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '0';
				mem_read_t <= '0';
				mem_write_t <= '1';
--				which_reg_t <= "000";
				SA_which_reg_control_t <= '1';
				
			when S8 => --a reg write
				pc_wrt_t <= '0';
				ir_write_t <= '0';
				reg_read_t <= '0';
				reg_write_t <= '0';
				pc_update_t <= '0';
				status_reg_write_t <= '0';
				LA_SA_reg_write_t <= '1';
				mem_read_t <= '0';
				mem_write_t <= '0';
--				which_reg_t <= "000";
--				SA_which_reg_control_t <= '0';		
				
				
			
			
		end case;
	end if;
	end process;
	
	--assign Si based on OPcode
	
	--assign output based on Si
--	outc <= outc_temp;
--	outz <= outz_temp;
--	output <= output_temp;
	pc_wrt <= pc_wrt_t ;
	ir_write <= ir_write_t; 
	reg_read <= reg_read_t ;
	reg_write <= reg_write_t ;
	pc_update <= pc_update_t ;
	status_reg_write <= status_reg_write_t ;
	LA_SA_reg_write <= LA_SA_reg_write_t ;
	mem_read <= mem_read_t ;
	mem_write <= mem_write_t ;
	which_reg <= which_reg_t ;
	SA_which_reg_control <= SA_which_reg_control_t ;
end behaviour;
