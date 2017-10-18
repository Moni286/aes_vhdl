----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:26 10/12/2017 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( ptblock : in  STD_LOGIC_VECTOR (127 downto 0);
				clk : in STD_LOGIC;
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0);
			  en : in STD_LOGIC);
end main;

architecture Behavioral of main is

COMPONENT aes_full is
    Port ( pt : in  STD_LOGIC_VECTOR (127 downto 0);
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
           en : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           ct : out  STD_LOGIC_VECTOR (127 downto 0));
end COMPONENT aes_full;

type t_sBox is array (0 to 10)
        of STD_LOGIC_VECTOR(127 downto 0);
  constant rkeys : t_sBox := (
		x"00000000000000000000000000000000",
		x"62636363626363636263636362636363", 
		x"9b9898c9f9fbfbaa9b9898c9f9fbfbaa",
		x"90973450696ccffaf2f457330b0fac99", 
		x"ee06da7b876a1581759e42b27e91ee2b", 
		x"7f2e2b88f8443e098dda7cbbf34b9290", 
		x"ec614b851425758c99ff09376ab49ba7",
		x"217517873550620bacaf6b3cc61bf09b",
		x"0ef903333ba9613897060a04511dfa9f",
		x"b1d4d8e28a7db9da1d7bb3de4c664941",
		x"b4ef5bcb3e92e21123e951cf6f8f188e"
);

signal current_rkey : STD_LOGIC_VECTOR(127 downto 0) := x"00000000000000000000000000000000";
signal round : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal rnd_counter : STD_LOGIC_VECTOR(2 downto 0) := "000";

begin

	aes : aes_full port map(
		pt => ptblock,
		clk => clk,
		en => en,
		rkey => current_rkey,
		ct => ciphertext
	);
	
	PROCESS (clk, en, ptblock, round, rnd_counter)
	BEGIN
		if rising_edge(clk) and en = '1' then
			if unsigned(rnd_counter) >= 4 then
				rnd_counter <= "001";
				if unsigned(round) < 9 then
					round <= STD_LOGIC_VECTOR(unsigned(round) + 1);
				end if;
				current_rkey <= rkeys(to_integer(unsigned(round)) + 1);
			else
				rnd_counter <= STD_LOGIC_VECTOR(unsigned(rnd_counter) + 1);
			end if;
		end if;
	END PROCESS;

end Behavioral;



