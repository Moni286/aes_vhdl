----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:55:34 10/08/2017 
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
    Port ( 	clk  : in  STD_LOGIC;
				win  : in  STD_LOGIC_VECTOR (31 downto 0);
				wout : out STD_LOGIC_VECTOR (31 downto 0));
end sbox4B;

architecture Behavioral of sbox4B is
	COMPONENT sbox PORT (
		clk : IN  STD_LOGIC;
		d   : IN  STD_LOGIC_VECTOR (7 downto 0);
		q   : OUT STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT sbox;
begin

s0: sbox port map(clk, win(31 downto 24), wout(31 downto 24));
s1: sbox port map(clk, win(23 downto 16), wout(23 downto 16));
s2: sbox port map(clk, win(15 downto 8 ), wout(15 downto 8 ));
s3: sbox port map(clk, win(7  downto 0 ), wout(7  downto 0 ));

end Behavioral;

