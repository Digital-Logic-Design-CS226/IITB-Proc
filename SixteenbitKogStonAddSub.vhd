library work;
use work.all;


library IEEE;
use ieee.std_logic_1164.all;

entity SixteenbitKogStonAddSub is
port ( a, b : in std_logic_vector (15 downto 0);
cin: in std_logic;
sum: out std_logic_vector (15 downto 0);
cout: out std_logic;
z: out std_logic);
end entity;

architecture Behavioral of SixteenbitKogStonAddSub is

    -- Stage 0
    signal g_0, b_xor, p_0 : std_logic_vector(15 downto 0);
    
    -- Stage 1
    signal g_1, p_1 : std_logic_vector(15 downto 0);
    
    -- Stage 2
    signal g_2, p_2 : std_logic_vector(15 downto 0);
    
    -- Stage 3
    signal g_3, p_3 : std_logic_vector(15 downto 0);
	 
	 -- Stage 4
	 signal g_4, p_4, sum_temp : std_logic_vector(15 downto 0);
    
	 
component XOR_gate
port(A, B: in std_logic; O: out std_logic);
end component;

component Generator
Port ( A : in std_logic;
           B : in std_logic;
           G_out : out std_logic;
           P_out : out std_logic);
end component;

component GroupGenerator
    Port ( G_curr : in std_logic;
         G_prev : in std_logic;
         P_curr : in std_logic;
			G_out: out std_logic);
end component;

component Carry_oper
    Port ( G_prev : in std_logic;
           P_prev : in std_logic;
			  G_curr : in std_logic;
           P_curr : in std_logic;
           G_out : out std_logic;
           P_out : out std_logic);
end component;

begin
	XOR_neg: 
        for i in 0 to 15 generate
            map_xor: component XOR_gate PORT MAP(cin, b(i), b_xor(i) );
        end generate;
	
   Stage_0: 
        for i in 0 to 15 generate
            map_gen_0: component Generator PORT MAP(a(i) , b_xor(i) , g_0(i) , p_0(i) );
        end generate;
    
    -- Stage 1 operations
    -- Saving for first bit
    Stage_10 : -- Carry Operation
        for i in 0 to 0 generate
            map_car_10: component GroupGenerator port map (g_0(i), cin, p_0(i), g_1(i));
        end generate;
    
    Stage_11 : -- Carry Operation
        for i in 0 to 14 generate
            map_car_11: component Carry_oper port map (g_0(i), p_0(i), g_0(i+1), p_0(i+1), g_1(i+1), p_1(i+1));
        end generate;
     
     -- Stage 2 operations
	 
	 Storing_20:
        for i in 0 to 0 generate
            g_2(i) <= g_1(i);
            p_2(i) <= p_1(i);
        end generate;
	
	 Stage_21 : -- Carry Operation
        for i in 1 to 1 generate
            map_car_21: component GroupGenerator port map (g_1(i), cin, p_1(i), g_2(i));
        end generate;
		  
    Stage_22 : -- Carry Operation
        for i in 2 to 2 generate
            map_car_22: component GroupGenerator port map (g_1(i), g_1(i-2), p_1(i), g_2(i));
        end generate;
	 
	 
    Stage_23 : -- Carry Operation
        for i in 1 to 13 generate
            map_car_23: component Carry_oper port map (g_1(i), p_1(i), g_1(i+2), p_1(i+2), g_2(i+2), p_2(i+2));
        end generate;
     
     
     -- Stage 3 Operations
     Storing_30:
        for i in 0 to 2 generate
            g_3(i) <= g_2(i);
            p_3(i) <= p_2(i);
        end generate;
	
	 Stage_31 : -- Carry Operation
        for i in 3 to 3 generate
            map_car_31: component GroupGenerator port map (g_2(i), cin, p_2(i), g_3(i));
        end generate;
		  
    Stage_32 : -- Carry Operation
        for i in 4 to 6 generate
            map_car_32: component GroupGenerator port map (g_2(i), g_2(i-4), p_2(i), g_3(i));
        end generate;
	 
	 
    Stage_33 : -- Carry Operation
        for i in 3 to 11 generate
            map_car_23: component Carry_oper port map (g_2(i), p_2(i), g_2(i+4), p_2(i+4), g_3(i+4), p_3(i+4));
        end generate;
		  
	-- Stage 4 operations
	Storing_40:
        for i in 0 to 6 generate
            g_4(i) <= g_3(i);
            p_4(i) <= p_3(i);
        end generate;
	
	 Stage_41 : -- Carry Operation
        for i in 7 to 7 generate
            map_car_41: component GroupGenerator port map (g_3(i), cin, p_3(i), g_4(i));
        end generate;
		  
    Stage_42 : -- Carry Operation
        for i in 8 to 14 generate
            map_car_42: component GroupGenerator port map (g_3(i), g_3(i-8), p_3(i), g_4(i));
        end generate;
	 
	 
    Stage_43 : -- Carry Operation
        for i in 7 to 7 generate
            map_car_43: component Carry_oper port map (g_3(i), p_3(i), g_3(i+8), p_3(i+8), g_4(i+8), p_4(i+8));
        end generate;
	
	Chip_cout : GroupGenerator
	port map (g_4(15), cin, p_4(15), cout);
	
	Stage_5 : 
        for i in 1 to 15 generate
            map_car_4: component XOR_gate port map (g_4(i-1), p_0(i), sum_temp(i));
        end generate;
	
	Chip_sum_temp : XOR_gate
	port map(p_0(0), cin, sum_temp(0));
	
	z <= '1' when sum_temp="0000000000000000" else '0'; 
	sum <= sum_temp;
    
end Behavioral;
