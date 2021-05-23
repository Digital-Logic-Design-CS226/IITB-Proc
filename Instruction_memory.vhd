library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;

entity Instruction_memory  is
port (pc : in std_logic_vector (15 downto 0);
instruction : out std_logic_vector (15 downto 0));
end entity;

architecture behaviour of Instruction_memory is

signal output : std_logic_vector(15 downto 0) := (others => '0');
--2^16 short word memory
constant ram_depth : natural := 2**16;
constant ram_width : natural := 16;
constant lines_in_file : natural := 25;
type mem is array(2**16-1 downto 0) of std_logic_vector(15 downto 0);



impure function init_ram_hex return mem is
  file text_file : text open read_mode is "D:\IITB\Semester 4\CS 226\Project\IITB-Proc\ram_content_hex.txt";
  variable text_line : line;
  variable ram_content : mem;
  variable bv : bit_vector(ram_content(0)'range);
begin
  for i in 0 to lines_in_file - 1 loop
    readline(text_file, text_line);
    read(text_line, bv);
    ram_content(i) := To_StdLogicVector(bv);
  end loop;
 
  return ram_content;
end function;

signal memory : mem := init_ram_hex;

 
begin



 

	process(pc)
	begin
		output <= memory(to_integer(unsigned(pc)));
	end process;
	instruction <= output;
end behaviour;
