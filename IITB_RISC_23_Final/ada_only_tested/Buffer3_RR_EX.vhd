library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Buffer3_RR_EX is
    port(
        i_rst                : in std_logic;
        i_en                 : in std_logic;
        i_clk                : in std_logic;
        i_ALU1_A_input       : in std_logic_vector(15 downto 0);              
        i_ALU1_B_input       : in std_logic_vector(15 downto 0);              
        i_Ra_data            : in std_logic_vector(15 downto 0);          
        i_Rb_data            : in std_logic_vector(15 downto 0);          
        i_Temp_Data          : in std_logic_vector(15 downto 0);          
        i_PC_in              : in std_logic_vector(15 downto 0);      
        i_Ins                : in std_logic_vector(15 downto 0);
        o_ALU1_A_input       : out std_logic_vector(15 downto 0);                                      
        o_ALU1_B_input       : out std_logic_vector(15 downto 0);                                      
        o_Ra_data            : out std_logic_vector(15 downto 0);                                 
        o_Rb_data            : out std_logic_vector(15 downto 0);                                 
        o_Temp_Data          : out std_logic_vector(15 downto 0);                                   
        o_PC_in              : out std_logic_vector(15 downto 0);                               
        o_Ins                : out std_logic_vector(15 downto 0);

        i_Rc_addr            : in std_logic_vector(2 downto 0);
        o_Rc_addr            : out std_logic_vector(2 downto 0)
    );
end entity Buffer3_RR_EX;

architecture arch_Buffer3_RR_EX of Buffer3_RR_EX is
begin
    process(i_clk, i_rst)
    begin
        if(i_rst='1') then
            o_ALU1_A_input <= x"0000";
            o_ALU1_B_input <= x"0000";
            o_Ra_data <="UUUUUUUUUUUUUUUU";
            o_Rb_data <="UUUUUUUUUUUUUUUU";
            o_Temp_Data <= "UUUUUUUUUUUUUUUU";
            o_PC_in <= x"0000";
            o_Ins <= x"E000";
            
            o_Rc_addr <= "UUU";
        elsif(rising_edge(i_clk)) then
            if(i_en='1') then
                o_ALU1_A_input <= i_ALU1_A_input;
                o_ALU1_B_input <= i_ALU1_B_input;
                o_Ra_data <= i_Ra_data;
                o_Rb_data <= i_Rb_data;
                o_Temp_Data <= i_Temp_Data;
                o_PC_in <= i_PC_in;
                o_Ins <= i_Ins;

                o_Rc_addr <= i_Rc_addr;
            end if;
        end if;
    end process;
end architecture arch_Buffer3_RR_EX;
