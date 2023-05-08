-- COMPILE CHECKED

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File is
    port(
        i_clk, i_rst        : in std_logic;
        i_reg_wr_en         : in std_logic;
        i_reg_wr_data       : in std_logic_vector(15 downto 0);
        i_reg_wr_addr       : in std_logic_vector(2 downto 0);
        i_reg_rd_addr_1     : in std_logic_vector(2 downto 0);
        i_reg_rd_addr_2     : in std_logic_vector(2 downto 0);
        o_reg_rd_data_1     : out std_logic_vector(15 downto 0);
        o_reg_rd_data_2     : out std_logic_vector(15 downto 0);

        i_r0_wr_en          : in std_logic;
        o_r0_rd             : out std_logic_vector(15 downto 0);
        i_r0_wr             : in std_logic_vector(15 downto 0)
    );
end entity Register_File;

architecture arch_register_file of Register_File is
    type reg_type is array(0 to 7) of std_logic_vector(15 downto 0);
    signal reg_array: reg_type := (
        0    => x"0000",         
        1    => x"0001",
        2    => x"0002",
        3    => x"0003",
        4    => x"0004",
        5    => x"0005",
        6    => x"0006",
        7    => x"0007"
    );
begin
    process(i_clk, i_rst)
    begin
        if(i_rst='1') then
            reg_array <= (others => (others => '0'));
        elsif(rising_edge(i_clk)) then
            if(i_r0_wr_en = '1') then
                reg_array(0) <= i_r0_wr;
            else
                null;
            end if;

            if(i_reg_wr_en = '1') then
                reg_array(to_integer(unsigned(i_reg_wr_addr))) <= i_reg_wr_data;
            else
                null;
            end if;
        end if;    
    end process;
    o_reg_rd_data_1 <= reg_array(to_integer(unsigned(i_reg_rd_addr_1)));
    o_reg_rd_data_2 <= reg_array(to_integer(unsigned(i_reg_rd_addr_2)));
    o_r0_rd <= reg_array(0);
end architecture arch_register_file;

---RULES OF RF:
---1) Only i_r0_wr can write to R0 and i_reg_wr_data to R1-R7 and NOT R0
---2) i_r0_wr_en is write enable for R0 and i_reg_wr_en is for R1-R7 and NOT R0
---3) R0-R7 (R0 included) registers can be read by referring their addresses