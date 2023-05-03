library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity instruction_memory is
    port(
        i_pc          : in std_logic_vector(15 downto 0);
        o_instruction : out std_logic_vector(15 downto 0);
        o_addr        : out std_logic_vector(7 downto 0)
    );
end entity instruction_memory;

architecture arch_instruction_memory of instruction_memory is
    signal rom_address: std_logic_vector(7 downto 0);
    type ROM_type is array (0 to 255) of std_logic_vector(15 downto 0);       -- Total size = (2^8)*2 bytes
    constant rom_data: ROM_type := (                                            --            = 512 B 
        0  => "0001011100101000",           -- ada r3, r4, r5
        1  => "0010110010001011",           -- Random instructions initialized
        2  => "1100010000000011",
        3  => "0001000111000000",
        4  => "1110110110000001",
        5  => "1100000001111011",
        6  => "0000000000000000",
        7  => "0000000000000000",
        8  => "0000000000000000",
        9  => "0000000000000000",
        10 => "0000000000000000",
        11 => "0000000000000000",
        12 => "0000000000000000",
        13 => "0000000000000000",
        14 => "0000000000000000",
        15 => "0000000000000000",
        others => x"0000"
    );
begin
    rom_address     <= i_pc(7 downto 0);
    o_instruction   <= rom_data(to_integer(unsigned(rom_address))) when i_pc <= x"00FF" else x"0000";
    o_addr          <= rom_address;
end architecture arch_instruction_memory;