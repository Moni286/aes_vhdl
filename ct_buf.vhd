----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:23:41 10/27/2017 
-- Design Name: 
-- Module Name:    ct_buf - Behavioral 
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

entity ct_buf is
    Port ( ct : in  STD_LOGIC_VECTOR (127 downto 0);
           w : in  STD_LOGIC;
			  clk : in STD_LOGIC;
			  index : in STD_LOGIC_VECTOR (3 downto 0);
           ct_byte : out  STD_LOGIC_VECTOR (7 downto 0));
end ct_buf;

architecture Behavioral of ct_buf is

type buff is array (0 to 15)
        of STD_LOGIC_VECTOR(7 downto 0);
signal ciphertext : buff := (others => "00000000");

begin
	
	PROCESS(clk)
	BEGIN
	if rising_edge(clk) then
		ct_byte <= ciphertext(to_integer(unsigned(index)));
		
		if w = '1' then
			ciphertext(15) <= ct(7 downto 0);
			ciphertext(14) <= ct(15 downto 8);
			ciphertext(13) <= ct(23 downto 16);
			ciphertext(12) <= ct(31 downto 24);
			ciphertext(11) <= ct(39 downto 32);
			ciphertext(10) <= ct(47 downto 40);
			ciphertext(9) <= ct(55 downto 48);
			ciphertext(8) <= ct(63 downto 56);
			ciphertext(7) <= ct(71 downto 64);
			ciphertext(6) <= ct(79 downto 72);
			ciphertext(5) <= ct(87 downto 80);
			ciphertext(4) <= ct(95 downto 88);
			ciphertext(3) <= ct(103 downto 96);
			ciphertext(2) <= ct(111 downto 104);
			ciphertext(1) <= ct(119 downto 112);
			ciphertext(0) <= ct(127 downto 120);
		end if;
	end if;
	END PROCESS;

end Behavioral;

