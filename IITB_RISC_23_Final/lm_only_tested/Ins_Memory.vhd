-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity Ins_Memory is
    port(
        addr_in             : in std_logic_vector(15 downto 0);
        data_out            : out std_logic_vector(15 downto 0)
    );
end entity Ins_Memory;

architecture arch_instruction_memory of Ins_Memory is
    type ROM_type is array (0 to 255) of std_logic_vector(15 downto 0);       -- Total size = (2^8)*2 bytes
    constant rom_data: ROM_type := (                                          --            = 512 B 
        0  => "0110011001001101",           -- lm r3, 001001101  ------->  r3=7 ------> 7th loc in Data Mem has value A -----> 
        1  => "1110000000000000",                                               ------> 8th loc has value B, 9th has C, and 10th has A again
        2  => "1110000000000000",           
        3  => "1110000000000000",                                                          -- 1100 0111 0011 1011 
        4  => "1110000000000000",              
        5  => "1110000000000000",          ---
        6  => "1110000000000000",
        7  => "1110000000000000",
        8  => "1110000000000000",
        9  => "1110000000000000",
        10 => "1110000000000000",
        11 => "1110000000000000",
        12 => "1110000000000000",
        13 => "1110000000000000",
        14 => "1110000000000000",
        15 => "1110000000000000",
        others => x"E000"
    );
begin
    data_out   <= rom_data(to_integer(unsigned(addr_in))) when addr_in < x"0100" else x"0000";
end architecture arch_instruction_memory;




