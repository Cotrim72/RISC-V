library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port (
	clk           : in  std_logic;
        reset         : in  std_logic;
        a_in           : in  std_logic_vector(31 downto 0);
        b_in           : in std_logic_vector(31 downto 0);
	c_in		: in std_logic_vector(3 downto 0);
	result_out	: out std_logic_vector(31 downto 0);
	zero_flag_out	: out std_logic
    );
end alu;

architecture Behavioral of alu is
begin
  process(clk, reset)
	variable temp : std_logic_vector(31 downto 0);
	variable temp2 : std_logic_vector(31 downto 0);
  begin
    if reset = '1' then
        result_out <= (others => '0');
	zero_flag_out <= '0';
    elsif rising_edge(clk) then
	temp  := (others => '0');
	temp2 := std_logic_vector(to_unsigned(0,32));
	case c_in is
		when "0000" =>
			temp := a_in and b_in;
		when "0001" =>
			temp := a_in or b_in;
		when "0011" =>
			temp := a_in xor b_in;
		when "0010" =>
			temp := std_logic_vector(unsigned(a_in) + unsigned(b_in));
		when "0110" =>
			temp := std_logic_vector(signed(unsigned(a_in) - unsigned(b_in)));
		when "0100" =>
			temp :=	std_logic_vector(shift_left(unsigned(a_in), to_integer(unsigned(b_in(4 downto 0)))));
		when "0101" =>
			temp :=	std_logic_vector(shift_right(unsigned(a_in), to_integer(unsigned(b_in(4 downto 0)))));
		when others =>
			temp := (others => '0');
	end case;
	
	result_out <= temp;
	
	if temp=temp2 then
    		zero_flag_out <= '1';
	else
    		zero_flag_out <= '0';
	end if;
	
    end if;
  end process;
end Behavioral;
