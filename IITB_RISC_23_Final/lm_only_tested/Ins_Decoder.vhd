-- Compile Checked

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Ins_Decoder is
    port(
        Ins       : in std_logic_vector(15 downto 0);
        Rc_Addr     : out std_logic_vector(2 downto 0);
        Rb_Addr     : out std_logic_vector(2 downto 0);
        Ra_Addr     : out std_logic_vector(2 downto 0);
        imm6        : out std_logic_vector(5 downto 0);
        imm8        : out std_logic_vector(7 downto 0);
        imm9        : out std_logic_vector(8 downto 0)
    );
end entity Ins_Decoder;

architecture arch_Ins_Decoder of Ins_Decoder is
begin
 
    decoding: process(Ins)

    variable Op: std_logic_vector(3 downto 0);
    variable A,B,C: std_logic_vector(2 downto 0);
    variable Cpl: std_logic;
    variable CZ: std_logic_vector(1 downto 0);

    begin

        imm9 <= Ins(8 downto 0);
        imm6 <= Ins(5 downto 0);
        imm8 <= Ins(7 downto 0);
        Op  := Ins(15 downto 12);
        A := Ins(11 downto 9);
        B := Ins(8 downto 6);
        C := Ins(5 downto 3);
        Cpl := Ins(2);
        CZ  := Ins(1 downto 0);

        case Op is
------------------------------------------------------------------
            when "0001" =>                  -- Addition Instructions
            if(Cpl='0') then
                if(CZ="00") then        --ADA    
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                elsif(CZ="01") then     --ADZ
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                elsif(CZ="10") then     --ADC
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                elsif(CZ="11") then     --AWC
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                end if;

            elsif(Cpl='1') then
                if(CZ="00") then        --ACA
                    Ra_Addr <=A;
                    Rb_Addr <=A;
                    Rc_Addr <=C;
                elsif(CZ="01") then     --ACZ
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                elsif(CZ="10") then     --ACC
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                elsif(CZ="11") then     --ACW
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                end if;
            end if;


            when "0000" =>                  --ADI
                    Ra_Addr <=A; --DONT CARE
                    Rb_Addr <=A;
                    Rc_Addr <=B;

            when "0010" =>                  --NAND Instructions
                if (Cpl='0') then
                    if(CZ="00") then    --NDU
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;

                    elsif(CZ="01") then --NDZ
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;

                    elsif(CZ="10") then --NDC
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                    end if;
                
                elsif (Cpl='1') then
                    if(CZ="00") then    --NCU
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;

                    elsif(CZ="01") then --NCZ
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;

                    elsif(CZ="10") then --NCC
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C;
                    end if;
                end if;

            when "0011" =>                  --LLI
                    Ra_Addr <=A; --DONT CARE
                    Rb_Addr <=B; --DONT CARE
                    Rc_Addr <=A;

            when "0100" =>                  --LW
                    Ra_Addr <=A; --DONT CARE
                    Rb_Addr <=B;
                    Rc_Addr <=A;

            when "0101" =>                  --SW
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C; --DONT CARE

            when "0110" =>                  --LM
                    Ra_Addr <=A;
                    Rb_Addr <=B; --DONT CARE
                    Rc_Addr <=C; --DONT CARE

            when "0111" =>                  --SM
                    Ra_Addr <=A; ----MAYBE DONT CARE
                    Rb_Addr <=A; --DO CARE --DONT CARE
                    Rc_Addr <=C; --DONT CARE

            when "1000" =>                  --BEQ
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C; --DONT CARE

            when "1001" =>                  --BLT         
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C; --DONT CARE

            when "1010" =>                  --BLE [OPCODE of this INS is wrong in the Problem Sheet; BLE:1010]
                    Ra_Addr <=A;
                    Rb_Addr <=B;
                    Rc_Addr <=C; --DONT CARE

            when "1100" =>                  --JAL
                    Ra_Addr <=A; --DONT CARE
                    Rb_Addr <=B; --DONT CARE
                    Rc_Addr <=A;

            when "1101" =>                  --JLR
                    Ra_Addr <=B;
                    Rb_Addr <=B; --DONT CARE
                    Rc_Addr <=A;

            when "1111" =>                  --JLI
                    Ra_Addr <=A;
                    Rb_Addr <=B; --DONT CARE
                    Rc_Addr <=C; --DONT CARE

            when others=>
            null;
        end case;
    end process decoding;
end architecture arch_Ins_Decoder;