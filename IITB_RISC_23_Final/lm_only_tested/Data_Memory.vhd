-- COMPILE CHECKED

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Data_Memory IS
    PORT (
        clk : IN STD_LOGIC;
        mem_write_en : IN STD_LOGIC;
        mem_write_data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        mem_read_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        mem_access_addr : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END Data_Memory;

ARCHITECTURE arch_Data_Memory OF Data_Memory IS
    SIGNAL i : INTEGER;
    SIGNAL ram_addr : STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE data_mem IS ARRAY(0 TO 255) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL RAM : data_mem := (
        0       => x"0000",
        1       => x"0001",
        2       => x"0002",
        3       => x"0003",
        4       => x"0004",
        5       => x"0005",
        6       => x"0006",
        7       => x"000A",
        8       => x"000B",
        9       => x"000C",
        10      => x"000A",
        11      => x"B4D9",    
        12      => x"000C",
        13      => x"000D",    
        14      => x"000E",
        15      => x"000F",      
        OTHERS => (OTHERS => '0')
    );
BEGIN
    ram_addr <= mem_access_addr(7 DOWNTO 0);
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (mem_write_en = '1') THEN
                RAM(to_integer(unsigned(ram_addr))) <= mem_write_data;
            else
                null;
            END IF;
        else
            null;
        END IF;
    END PROCESS;
    mem_read_data <= RAM(to_integer(unsigned(ram_addr)));
END arch_Data_Memory;