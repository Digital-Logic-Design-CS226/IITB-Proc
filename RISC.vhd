--library work;
--use work.all;
--
--
--library IEEE;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--
--entity RISC  is
--port ( rst: in std_logic;
--clk: in std_logic);
--end entity;
--
--architecture behaviour of RISC is
--
--signal opcode : std_logic_vector(3 downto 0);
--
---- various controls
--
--
--
--component Control_unit
--port ( opcode, --various signal,
--clk, rst);
--end component;
--
--component Data_path is
--port ( opcode, -- various signals,
--clk, rst);
--end component;
--
--begin
--	CU : component Control_unit port map (opcode , clk, rst);
--	DP : component Data_path port map (opcode, clk, rst);
--end behaviour;
