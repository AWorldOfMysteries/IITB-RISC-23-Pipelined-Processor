library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
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
end entity register_file;

architecture arch_register_file of register_file is
    type reg_type is array(0 to 7) of std_logic_vector(15 downto 0);
    signal reg_array: reg_type := (others => (others => '0'));
begin
    process(i_clk, i_rst)
    begin
        if(i_rst='1') then
            reg_array <= (others => (others => '0'));
        elsif(rising_edge(i_clk)) then
            if(i_reg_wr_en = '1' and i_r0_wr_en = '1') then         -- Case when we are using pc normally -- 
                reg_array(to_integer(unsigned(i_reg_wr_addr))) <= i_reg_wr_data;    -- needs to be updated for r0 hazard
                reg_array(0) <= i_r0_wr;
            elsif(i_reg_wr_en = '0' and i_r0_wr_en = '1') then
                reg_array(0) <= i_r0_wr;
            elsif(i_reg_wr_en = '1' and i_r0_wr_en = '0') then
                reg_array(to_integer(unsigned(i_reg_wr_addr))) <= i_reg_wr_data;
            end if;
        end if;    
    end process;
    o_reg_rd_data_1 <= reg_array(to_integer(unsigned(i_reg_rd_addr_1)));
    o_reg_rd_data_2 <= reg_array(to_integer(unsigned(i_reg_rd_addr_2)));
    o_r0_rd <= reg_array(0);
end architecture arch_register_file;