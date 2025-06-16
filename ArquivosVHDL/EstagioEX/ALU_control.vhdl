library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControl is
    port (
        ALUOp  : in  std_logic_vector(1 downto 0);
        funct3 : in  std_logic_vector(2 downto 0);
        funct7_5: in std_logic;  -- bit 30 da instrução (funct7[5])
        ALUCtrl : out std_logic_vector(3 downto 0)
    );
end entity;

architecture Behavioral of ALUControl is
begin
    process(ALUOp, funct3, funct7_5)
    begin
        case ALUOp is
            when "00" =>  -- Loads, Stores, AUIPC (ADD)
                ALUCtrl <= "0010";  -- ADD

            when "01" =>  -- Branches (SUB)
                ALUCtrl <= "0110";  -- SUB

            when "10" =>  -- R-Type instructions
                case funct3 is
                    when "000" =>  -- ADD or SUB
                        if funct7_5 = '0' then
                            ALUCtrl <= "0010"; -- ADD
                        else
                            ALUCtrl <= "0110"; -- SUB
                        end if;
                    when "111" => ALUCtrl <= "0000"; -- AND
                    when "110" => ALUCtrl <= "0001"; -- OR
                    when "100" => ALUCtrl <= "0011"; -- XOR
                    when "001" => ALUCtrl <= "0100"; -- SLL
                    when "101" => ALUCtrl <= "0101"; -- SRL
                    when others =>
                        ALUCtrl <= "1111"; -- Default / não definido
                end case;

            when "11" =>  -- I-Type aritméticas e shifts imediatas
                case funct3 is
                    when "000" => ALUCtrl <= "0010"; -- ADDI
                    when "111" => ALUCtrl <= "0000"; -- ANDI
                    when "110" => ALUCtrl <= "0001"; -- ORI
                    when "100" => ALUCtrl <= "0011"; -- XORI
                    when "001" => ALUCtrl <= "0100"; -- SLLI
                    when "101" => ALUCtrl <= "0101"; -- SRLI
                    when others =>
                        ALUCtrl <= "1111"; -- Default / não definido
                end case;

            when others =>
                ALUCtrl <= "1111"; -- Default / não definido
        end case;
    end process;
end architecture
