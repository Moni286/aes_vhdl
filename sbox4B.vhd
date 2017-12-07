----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:23:34 10/20/2017 
-- Design Name: 
-- Module Name:    sbox4B - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sbox4B is
    Port ( d : in  STD_LOGIC_VECTOR (31 downto 0);
           q : out  STD_LOGIC_VECTOR (31 downto 0));
end sbox4B;

architecture Behavioral of sbox4B is

	COMPONENT sbox PORT ( 
		d : in  STD_LOGIC_VECTOR (7 downto 0);
		q : out  STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT sbox;
	
begin

s0: sbox port map(d(31 downto 24), q(31 downto 24));
s1: sbox port map(d(23 downto 16), q(23 downto 16));
s2: sbox port map(d(15 downto 08), q(15 downto 08));
s3: sbox port map(d(07 downto 00), q(07 downto 00));

end Behavioral;

